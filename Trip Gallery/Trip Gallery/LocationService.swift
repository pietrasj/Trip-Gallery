//
//  LocationService.swift
//  Trip Gallery
//
//  Created by Jayne Pietraszkiewicz on 25/4/17.
//  Copyright © 2017 Deakin. All rights reserved.
//

import UIKit
import MapKit

protocol LocationObserver {
    func locationDidChange(newLocations: [CLLocation])
}

class LocationService: NSObject, CLLocationManagerDelegate {
    var locationObservers : [LocationObserver] = []
    var locationManager = CLLocationManager.init()
    static let shared: LocationService = LocationService()
    
    override private init() {
        super.init()
        locationManager.desiredAccuracy = 100 // metres
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func registerLocationObserver(locationObserver : LocationObserver) {
        locationObservers.append(locationObserver)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // notify all observers with the new change
        for observer in locationObservers {
            observer.locationDidChange(newLocations: locations)
        }
    }
    

}
