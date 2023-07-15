//
//  CombineHTTPService.swift
//  WeatherInfoApp
//
//  Created by dedeepya reddy salla on 28/06/23.
//

import Foundation
import Combine

protocol ServiceRequestInput {
    associatedtype DataModel: Decodable
//    associatedtype subDataModel: Decodable
    var urlStr: String {get}
    var httpMethod: HTTPMethod {get}
    var queryItems: [String: Any] { get}
    var postBodyDic: [String: Any] { get}
    
    var urlRequest: URLRequest? {get}
}

extension ServiceRequestInput {
    
    var queryItems: [String: Any] {
        [:]
    }
    
    var postBodyDic: [String: Any]{
        [:]
    }
    
    var httpMethod: HTTPMethod {
        .get
    }
    
    var urlRequest: URLRequest? {
        
        guard var urlComponents = URLComponents(string: urlStr) else {
            return nil
        }
        
        var urlQueryItems: [URLQueryItem] = []
        queryItems.forEach { key, value in
            urlQueryItems.append(URLQueryItem(name: key, value: "\(value)"))
        }
        if urlQueryItems.count > 0 && httpMethod != HTTPMethod.post {
            urlComponents.queryItems = urlQueryItems
        }
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        var urlReq = URLRequest(url: url)
        urlReq.httpMethod = httpMethod.value
          
       /* if httpMethod == HTTPMethod.post {
            do {
                let parameters: [String: Any] = ["country": "United States"]
                urlReq.httpBody = getHttpBodyData(params: parameters)
                urlReq.httpBody = urlComponents.query?.data(using: .utf8)
                let test = try JSONSerialization.data(withJSONObject: postBodyDic)
            } catch {
                
            }
        }*/
        return urlReq
    }
    
    private func getHttpBodyData(params: [String: Any]) -> Data? {
        do {
            // convert parameters to Data and assign dictionary to httpBody of request
            let parameters: [String: Any] = ["country": "United States"]
            return "country=United States".data(using: .utf8)

        } catch let error {
            print(error.localizedDescription)
        }
    }
}

struct combineRestService {
    
    static func getAPICall<T: ServiceRequestInput>(service: T) -> AnyPublisher<T.DataModel, Error> {
        
        guard let urlReq = service.urlRequest else {
            return Fail(error: ServiceError.badURL).eraseToAnyPublisher()
        }
        
        //let mappedData = getDataFromAPI(urlReq: urlReq)
        let pub = URLSession.shared.dataTaskPublisher(for: urlReq)
        print("publisher---", pub)
        let mappedData = pub.tryMap { data, response in

            print("came to mapped data---")
            print(Thread.current)
            guard let res = response as? HTTPURLResponse, res.statusCode == 200 else {
                throw ServiceError.httpStatusError
            }

            return data
        }
        let jsonDecodedData = mappedData.decode(type: T.DataModel.self, decoder: JSONDecoder())
        let mainQue = jsonDecodedData.receive(on: DispatchQueue.main).eraseToAnyPublisher()

        return mainQue
    }
    
//    static func getDataFromAPI(urlReq: URLRequest) -> AnyPublisher<Data, Error> {
//
//        let pub = URLSession.shared.dataTaskPublisher(for: urlReq)
//        print("publisher---", pub)
//        let mappedData = pub.tryMap { data, response in
//
//            print("came to mapped data---")
//            print(Thread.current)
//            guard let res = response as? HTTPURLResponse, res.statusCode == 200 else {
//                throw ServiceError.httpStatusError
//            }
//
//            return data
//        }
//    }
}
