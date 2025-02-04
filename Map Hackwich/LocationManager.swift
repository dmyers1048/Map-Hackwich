//
//  LocationManager.swift
//  Map Hackwich
//
//  Created by Devan Myers on 2/3/25.
//

import Foundation
import CoreLocation

class LocationManager:NSObject,CLLocationManagerDelegate,ObservableObject {
    var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}
