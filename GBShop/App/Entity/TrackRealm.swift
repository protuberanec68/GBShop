//
//  TrackRealm.swift
//  GBShop
//
//  Created by Игорь Андрианов on 22.05.2022.
//

import Foundation
import RealmSwift
import CoreLocation

class RealmLocation: Object {
    @Persisted(primaryKey: true) var id = UUID()
    @Persisted var latitude: Double
    @Persisted var longitude: Double
    
    convenience init(location: CLLocationCoordinate2D) {
        self.init()
        self.latitude = location.latitude
        self.longitude = location.longitude
    }
}
