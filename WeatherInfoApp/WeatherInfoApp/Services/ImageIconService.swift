//
//  ImageIconService.swift
//  AppleTutorialSwiftUI
//
//  Created by dedeepya reddy salla on 20/06/23.
//

import Foundation

struct WeatherImageModel: Decodable {
    let imageData: Data
}

struct ImageIconService: ServiceRequestInput {

    typealias DataModel = WeatherImageModel

    var urlStr: String {
        if let imageIcon = imageIcon {
            return APIConstants.HttpString.iconRequestUrl + imageIcon + "@2x.png"
        } else {
            return ""
        }
    }

    var imageIcon: String?
    
}
