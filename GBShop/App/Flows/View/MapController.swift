//
//  MapController.swift
//  GBShop
//
//  Created by Игорь Андрианов on 15.05.2022.
//

import UIKit
import GoogleMaps

class MapController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    var route: GMSPolyline?
    var routePath: GMSMutablePath?
    
    var locationManager: CLLocationManager!
    var currentLocation: CLLocationCoordinate2D? {
        locationManager.location?.coordinate
    }
    
    //used to check that camera moved by user actions and to disable / enable automatic tracking of the camera for the current location
    var isCameraNeedAutoMove = true
    var isCameraMovedAutomatically = true
    
    let defaultLocation = CLLocationCoordinate2D(latitude: 59.939095, longitude: 30.315868)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLocationManager()
        configureMap()
    }
    
    @IBAction func locationTapped(_ sender: Any) {
        isCameraNeedAutoMove = true
        isCameraMovedAutomatically = true
        mapView.animate(toLocation: currentLocation ?? defaultLocation)
    }
    @IBAction func drawLineTapped(_ sender: Any) {
        route?.map = nil
        route = GMSPolyline()
        routePath = GMSMutablePath()
        route?.strokeWidth = 2
        
        route?.map = mapView
    }
}

// MARK: LocationManager Delegate
extension MapController: CLLocationManagerDelegate {
    private func configureLocationManager() {
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        if isCameraNeedAutoMove {
            isCameraMovedAutomatically = true
            mapView.animate(toLocation: location.coordinate)
        }
        routePath?.add(location.coordinate)
        route?.path = routePath
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

// MARK: MapView Delegate
extension MapController: GMSMapViewDelegate {
    private func configureMap() {
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        locationManager.startUpdatingLocation()
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
