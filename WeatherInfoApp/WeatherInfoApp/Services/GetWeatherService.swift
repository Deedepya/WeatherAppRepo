//
//  GetWeatherService.swift
//  AppleTutorialSwiftUI
//
//  Created by dedeepya reddy salla on 19/06/23.
//

import Foundation

struct WeatherService: ServiceRequestInput {

    typealias DataModel = WeatherModel
   //-- if this is not declared, then if you try to mutate then error is shown for mutation. find why?
    var queryItems: [String : Any] = [APIConstants.QueryConstants.appId.rawValue: APIConstants.APIKeys.weatherApiKey]
    
    var urlStr: String {
        return APIConstants.HttpString.openWeatherBaseUrl
    }
    
    mutating func addQueryItem(withCityName city: String) {
        queryItems[APIConstants.QueryConstants.query.rawValue] = city
    }
    
    mutating func addQueryItem(withCoordinates coordinates: Coordinates) {
        queryItems[APIConstants.QueryConstants.latitude.rawValue] = coordinates.lat
        queryItems[APIConstants.QueryConstants.longtitude.rawValue] = coordinates.lon
    }
}


