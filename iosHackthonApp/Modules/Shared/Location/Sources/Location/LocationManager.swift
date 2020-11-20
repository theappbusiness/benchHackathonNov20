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

    private let locationManager = CLLocationManager()

    @Published public var userLatitude: Double = 0
    @Published public var userLongitude: Double = 0
    @Published public var address: String = ""
    @Published public var status: CLAuthorizationStatus? {
        willSet { objectWillChange.send() }
    }
    public let objectWillChange = PassthroughSubject<Void, Never>()

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

    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.status = status
    }
}
