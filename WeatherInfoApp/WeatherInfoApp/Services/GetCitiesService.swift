//
//  GetCitiesService.swift
//  WeatherApp
//
//  Created by dedeepya reddy salla on 05/06/23.
//

import Foundation

struct GetCitiesService: ServiceRequestInput {
   // var queryItems: [String : Any] = [:]
    
    var queryItems: [String : Any] = [APIConstants.QueryConstants.country.rawValue: APIConstants.QueryConstants.unitedStates.rawValue]
    typealias DataModel = CitiesModel
//    typealias subDataModel = City
    
    var urlStr: String {
        let baseURL: String = APIConstants.HttpString.getCitiesURL
        return baseURL
    }
    
    var postBodyDic: [String : Any]{
        return [APIConstants.QueryConstants.country.rawValue: APIConstants.QueryConstants.unitedStates.rawValue]
    }
    
    
    var httpMethod: HTTPMethod {
        .post
    }
}
