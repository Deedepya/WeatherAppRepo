//
//  ImageLoader.swift
//  WeatherInfoApp
//
//  Created by dedeepya reddy salla on 29/06/23.
//

import UIKit
import Combine


/*
 imageLoader is an observable object -- so whenever image is availble, it publishes notificaion to attached view
 
 after map publisher if you use receive publisher direclty then assign subsciber then -- it gives below error: why?? (note: without assign sibscriber it does not give any error, because publisher to publisher no error occurs)
 
 solu: use decoder or replace erro -- basically convert that data into usabel form -- then only you can attach to subscriber like assign variblae
 if subscirber assign expects -- image and you pass data -- how does it accept
 
 Cannot assign value of type
 Referencing instance method 'assign(to:on:)' on 'Publisher' requires the types 'URLSession.DataTaskPublisher.Failure' (aka 'URLError') and 'Never' be equivalent
 'Publishers.ReceiveOn<Publishers.Map<URLSession.DataTaskPublisher, UIImage?>, DispatchQueue>' to type 'AnyCancellable'
 
 Referencing instance method 'assign(to:on:)' on 'Publisher' requires the types 'URLSession.DataTaskPublisher.Failure' (aka 'URLError') and 'Never' be equivalent
 */
//class ImageLoader1: ObservableObject {
//    @Published var image: UIImage?
//    var sub: AnyCancellable?
//
//    func getImageFromAPI(urlStr: String) {
//        guard let url = URL(string: urlStr) else {
//            return
//        }
//        URLSession.shared.dataTaskPublisher(for: url)
//            .map { data, response in
//                return UIImage(data: data)
//            }
//            .receive(on: DispatchQueue.main)
//            .sink { val in
//                print(val)
//            }
//    }
//}

class ImageLoader: ObservableObject {
    
    @Published private(set) var uiImage: UIImage?
    var subscriber: AnyCancellable?

    func fetchImage(urlStr: String) {
        
        guard let url = URL(string: urlStr) else {
            return
        }
        
        if let cachedImage = AsyncCacheImages.cache.object(forKey: url.absoluteString as NSString) {
            uiImage = cachedImage
            return
        }
        
        let pub = URLSession.shared.dataTaskPublisher(for: url)
        
        subscriber = pub
            .map({ UIImage(data:$0.data) })
            .replaceError(with: nil) //here when you type replace error, you get upstream image? - so if there is error, then send nil downwards
            .handleEvents(receiveOutput: { outputFromUpstream in
                if let img = outputFromUpstream {
                    AsyncCacheImages.cache.setObject(img, forKey: url.absoluteString as NSString)
                }
               
                print(outputFromUpstream)
            })
            .receive(on: DispatchQueue.main)
            .assign(to: \.uiImage, on: self)
        //this says assign to uiimage variable which is availble in self
    }
    
    func cancelDownload() {
        subscriber?.cancel()
    }
}


class AsyncCacheImages {
    //static let shared = AsyncCacheImages() //it should be shared because its values must be accessiblae from anywhere and only signle instace creates magic
    //or else simple make cache static, that also creates magic
    
    static var cache = NSCache<NSString, UIImage>()
}
/*
 Use handleEvents(receiveSubscription:receiveOutput:receiveCompletion:receiveCancel:receiveRequest:) when you want to examine elements as they progress through the stages of the publisher’s lifecycle.
 In the example below, a publisher of integers shows the effect of printing debugging information at each stage of the element-processing lifecycle:
 */

/*
 
 does not wrok because -- eventhough you set value -- that publisher will never be called withut subscirber attaching, so better set restul in subscriber noce attached
 
 subscriber = pub.tryMap({
 if let image = UIImage(data: $0.data) {
     self?.uiImage = image
 } else {
     throw ServiceError.emptyData
 }
})*/
