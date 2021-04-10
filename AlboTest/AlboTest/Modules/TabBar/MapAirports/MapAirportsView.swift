//
//  MapAirportsView.swift
//  AlboTest
//
//  Created by Mauricio Rodriguez on 09/04/21.
//

import UIKit
import CoreLocation
import MapKit

class MapAirportsView: UIViewController, CLLocationManagerDelegate {

    // MARK: - Public properties
    @IBOutlet weak var airportsMapView: MKMapView!
    var data: ResponseAirport?
    var locationManager: CLLocationManager!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMapView()
        setUpMarket()
    }

    // MARK: - Init components
    func setUpMapView() {
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            airportsMapView.showsUserLocation = true
        }
    }
    
    func setUpMarket(){
        for item in self.data!.items {
            let mark: CLLocationCoordinate2D = CLLocationCoordinate2DMake(item.location.lat, item.location.lon)
            let annotation = MKPointAnnotation ()
            annotation.coordinate = mark
            annotation.title = item.name
            airportsMapView.addAnnotation(annotation)
        }
    }
    
    // MARK: - Methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let region = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: CLLocationDistance(exactly: 10000)!, longitudinalMeters: CLLocationDistance(exactly: 10000)!)
        airportsMapView.setRegion(region, animated: true)
    }
        
    func followUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: CLLocationDistance(exactly: 3000)!, longitudinalMeters: CLLocationDistance(exactly: 3000)!)
            airportsMapView.setRegion(region, animated: true)
        }
    }
}
