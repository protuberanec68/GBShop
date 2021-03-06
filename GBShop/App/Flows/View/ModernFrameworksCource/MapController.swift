//
//  MapController.swift
//  GBShop
//
//  Created by Игорь Андрианов on 15.05.2022.
//

import UIKit
import GoogleMaps
import RxSwift

class MapController: UIViewController {

    var onLogout: (() -> Void)?
    
    @IBOutlet weak var mapView: GMSMapView!
    var route: GMSPolyline?
    var routePath: GMSMutablePath?
    var beginBackgroundTask: UIBackgroundTaskIdentifier?
    
    var timer: Timer?
    
    let locationManager = LocationManager.instance
    var currentLocation: CLLocationCoordinate2D? {
        locationManager.locationManager.location?.coordinate
    }
    var locationEventHandler: Disposable?
    
//    used to check that camera moved by user actions and to disable / enable
//    automatic tracking of the camera for the current location
    var isCameraNeedAutoMove = true
    var isCameraMovedAutomatically = true
    var isTracking = false
    
    let defaultLocation = CLLocationCoordinate2D(latitude: 59.939095, longitude: 30.315868)
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMap()
        сonfigureBackground()
        configureLocationManager()
    }
    @IBAction func logoutTapped(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isLogin")
        locationEventHandler?.dispose()
        onLogout?()
    }
    
    @IBAction func locationTapped(_ sender: Any) {
        isCameraNeedAutoMove = true
        isCameraMovedAutomatically = true
        mapView.animate(toLocation: currentLocation ?? defaultLocation)
    }
    @IBAction func startNewTrackTapped(_ sender: Any) {
        locationManager.locationManager.allowsBackgroundLocationUpdates = true
        route?.map = nil
        route = GMSPolyline()
        routePath = GMSMutablePath()
        route?.strokeWidth = 2
        
        route?.map = mapView
        isTracking = true
        showToast(message: "Запись нового трека начата", font: .systemFont(ofSize: 12.0))
    }
    
    @IBAction func stopTrackTapped(_ sender: Any) {
        stopTracking()
    }
    
    private func stopTracking() {
        if isTracking {
            locationManager.locationManager.allowsBackgroundLocationUpdates = false
            guard let routePath = routePath else { return }
            let count = routePath.count()
            var locations: [RealmLocation] = []
            
            for index in (0 ..< count) {
                let coordinate = routePath.coordinate(at: index)
                locations.append(RealmLocation(location: coordinate))
            }
            do {
                let oldPath = try RealmService.load(typeOf: RealmLocation.self)
                try RealmService.delete(object: oldPath)
                try RealmService.save(items: locations)
            } catch {
                print(error.localizedDescription)
                return
            }
            
            showToast(message: "Запись трека остановлена", font: .systemFont(ofSize: 12.0))
            isTracking = false
        }
        route?.map = nil
        route = nil
        self.routePath = nil
    }
    
    @IBAction func showLastTrackTapped(_ sender: Any) {
        if isTracking {
            showOk(
                title: "Идет запись трека",
                message: "Сбросить текущую запись трека и показать последнюю запись?",
                cancelButtonNeeded: true) { [weak self] in
                    guard let self = self else { return }
                    self.stopTracking()
                    self.showLastTrack()
                }
            return
        } else {
            showLastTrack()
        }
    }
    
    private func showLastTrack() {
        isCameraNeedAutoMove = false
        route?.map = nil
        route = GMSPolyline()
        routePath = GMSMutablePath()
        do {
            let locationsResult = try RealmService.load(typeOf: RealmLocation.self)
            locationsResult.forEach {
                routePath?.add(CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude))
            }
        } catch {
            print(error.localizedDescription)
            return
        }
        
        route?.strokeWidth = 2
        route?.map = mapView
        route?.path = routePath
        
        let pathBounds = GMSCoordinateBounds(path: routePath!)
        let cameraUpdate = GMSCameraUpdate.fit(pathBounds, withPadding: 10.0)
        mapView.animate(with: cameraUpdate)
        
        showToast(message: "Последний трек", font: .systemFont(ofSize: 12.0))
    }
    
    // MARK: Configure baskground
    func сonfigureBackground() {
        NotificationCenter.default.addObserver(
            forName: UIApplication.didEnterBackgroundNotification,
            object: nil,
            queue: OperationQueue.main) { [weak self] _ in
                guard let self = self else { return }
                self.locationManager.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            }
        
        NotificationCenter.default.addObserver(
            forName: UIApplication.willEnterForegroundNotification,
            object: nil,
            queue: OperationQueue.main) { [weak self] _ in
                guard let self = self else { return }
                self.locationManager.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            }
    }
    
    private func configureLocationManager() {
        locationEventHandler = locationManager.location.subscribe { event in
            print(event)
            guard let location = event.element,
                  let coordinate = location?.coordinate
            else { return }
            if self.isCameraNeedAutoMove {
                self.isCameraMovedAutomatically = true
                self.mapView.animate(toLocation: coordinate)
            }
            if self.isTracking {
                self.routePath?.add(coordinate)
                self.route?.path = self.routePath
            }
        }
        locationManager.locationManager.startUpdatingLocation()
    }
}

// MARK: MapView Delegate
extension MapController: GMSMapViewDelegate {
    private func configureMap() {
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        let camera = GMSCameraPosition.camera(withTarget: currentLocation ?? defaultLocation, zoom: 10.0)
        mapView.camera = camera
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        if !isCameraMovedAutomatically {
            isCameraNeedAutoMove = false
        }
        isCameraMovedAutomatically = false
    }
}
