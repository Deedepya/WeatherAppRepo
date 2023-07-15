//
//  AllConstants.swift
//  AppleTutorialSwiftUI
//
//  Created by dedeepya reddy salla on 14/06/23.
//

import Foundation

//Note: Don't add more than third hierarchy
enum ResourceName {
    
    enum SystemImageName {
        static let trash = "trash"
        static let plus = "plus"
        static let cancel = "cancel"
    }
    
    enum DisplayText { //add for localizatio later
        static let delete = "Delete"
      
    }
}

/**
    Contains constants which are used during Network call
 */
enum APIConstants {
    enum HttpString {
        static let openWeatherBaseUrl = "https://api.openweathermap.org/data/2.5/weather"
        static let iconRequestUrl = "https://openweathermap.org/img/wn/"
        static let getCitiesURL = "https://countriesnow.space/api/v0.1/countries/cities"
    }

    enum APIKeys {
        static let weatherApiKey: String = "fa5cb89e48e32f17f631ae8c5b5469f6"
    }
    
    enum QueryConstants: String {
        case country = "country"
        case unitedStates = "United States"
        case appId = "appid"
        case query = "q"
        case latitude = "lat"
        case longtitude = "lon"
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    
    var value: String {
        self.rawValue
    }
}

enum ServiceError: Error {
    case badURL
    case httpStatusError
    case apiFailure (_ errorInfo: String)
    case emptyData
    case parseError (_ errorInfo: String)
    case unknown
}

enum AppStrings {
    static let visibility = "Visibility"
    static let humidity = "humidity"
    static let pressure = "pressure"
    static let mintemp = "Min Temperature"
    static let maxTemp = "Max Temperature"
}
