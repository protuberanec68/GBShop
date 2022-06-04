//
//  LocationManager.swift
//  GBShop
//
//  Created by Игорь Андрианов on 04.06.2022.
//

import Foundation
import CoreLocation
import RxSwift

final class LocationManager: NSObject {
    
    static let instance = LocationManager()
    private override init() {
        super.init()
        configureLocationManager()
    }
    
    let locationManager = CLLocationManager()
    let location = PublishSubject<CLLocation?>()
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    private func configureLocationManager() {
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = false
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.requestAlwaysAuthorization()
    }
}

extension LocationManager: CLLocationManagerDelegate {

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]) {
            self.location.onNext(locations.last)
        }
    
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error) {
            print(error.localizedDescription)
        }
}
