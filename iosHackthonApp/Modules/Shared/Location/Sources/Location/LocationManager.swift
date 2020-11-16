//
//  LocationManager.swift
//  iosHackthonApp
//
//  Created by Raynelle Francisca on 10/11/2020.
//  Copyright © 2020 orgName. All rights reserved.
//

import Foundation
import Combine
import CoreLocation

public class LocationManager: NSObject, ObservableObject {

    @Published public var userLatitude: Double = 0
    @Published public var userLongitude: Double = 0
    @Published public var address: String = ""

    private let locationManager = CLLocationManager()

    public override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {

    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        userLatitude = location.coordinate.latitude
        userLongitude = location.coordinate.longitude
        print(location)

        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if (error != nil) {
                print("error in reverseGeocode")
            }
            if placemarks?.count ?? 0 > 0 {
                let placemark = placemarks?[0]
                self.address = "\(placemark?.postalCode ?? ""), \(placemark?.locality ?? ""),  \(placemark?.administrativeArea ?? ""), \(placemark?.country ?? "")"
            }
        }
    }

	public func userDistanceFrom(_ lat: Float, _ long: Float) -> Double {
        let mealLocation = CLLocation(latitude: Double(lat), longitude: Double(long))
        let userLocation = CLLocation(latitude: userLatitude, longitude: userLongitude)
        return mealLocation.distance(from: userLocation)/1000
    }
}
