//
//  SliderView.swift
//  AlboTest
//
//  Created by Mauricio Rodriguez on 07/04/21.
//

import UIKit
import CoreLocation

class SliderView: UIViewController, CLLocationManagerDelegate, SliderViewProtocol {

    // MARK: - Public properties
    var presenter: SliderPresenterProtocol?
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var distanceSlider: UISlider!
    @IBOutlet weak var searchButton: UIButton!
    let locationManager = CLLocationManager()
    var initValue: Double = 10.0
    var distance: Int?
    var lat: Double?
    var lon: Double?
    var countries: ResponseAirport?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configVIPER()
        setUpView()
        setUpLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Init components
    func configVIPER() {
        SliderRouter.createModule(countriesRef: self)
    }
    
    func setUpView() {
        distanceSlider.minimumValue = 10
        distanceSlider.maximumValue = 100
        distanceLabel.text = String(initValue)
        distance = 10
    }
    
    func setUpLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // MARK: - Methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            lat = location.coordinate.latitude
            lon = location.coordinate.longitude
        }
    }
    
    @IBAction func sliderValueChanged(_ sender: Any) {
        distanceLabel.text = "\(distanceSlider.value)"
        distance = Int(distanceSlider.value)
    }
    
    @IBAction func searchButton(_ sender: Any) {
        if lat == nil || lon == nil {
            presenter?.getDataAirports(parameters: RequestAirportsStruct(lat: 19.45776253, lon: -99.21536580, limit: 20, radius: distance!, flight: false))
        } else {
            presenter?.getDataAirports(parameters: RequestAirportsStruct(lat: lat!, lon: lon!, limit: 20, radius: distance!, flight: false))
        }
    }
    
    func returnError(data: String) {
        showAlertMessage(titleStr: "Error", messageStr: data)
    }
}
