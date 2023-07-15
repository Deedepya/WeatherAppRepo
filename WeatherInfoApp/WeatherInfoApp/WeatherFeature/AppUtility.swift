//
//  AppUtility.swift
//  AppleTutorialSwiftUI
//
//  Created by dedeepya reddy salla on 19/06/23.
//

import CoreLocation

protocol locationProtocol: AnyObject {
    func receivedLocation(with coordinates: Coordinates)
}


class AppUtility: NSObject {
    
    static var shared: AppUtility {
        return AppUtility()
    }
    
    var currentLocation: Coordinates = Coordinates(lon: 142.369, lat: 38.322)
    var currentWeatherInfo: CurrentWeatherInfo?
    
    var locationManager: CLLocationManager?
    weak var delegate: locationProtocol?
    
    override private init() {
        super.init()
    }
    
    func getCurrentLocationInfo() {
        self.locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.startUpdatingLocation()
    }
}

extension AppUtility: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        currentLocation = Coordinates(lon: userLocation.coordinate.longitude, lat: userLocation.coordinate.latitude)
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("received error while trying to get location \(error)")
    }
}
