//
//  SliderInteractor.swift
//  AlboTest
//
//  Created by Mauricio Rodriguez on 09/04/21.
//

import UIKit

class SliderInteractor: SliderInteractorProtocol, URL_SessionDelegate {
    
    // MARK: - Public properties
    weak var presenter: SliderOutputInteractorProtocol?
    
    // MARK: - Methods
    func getAirportsRequest(from view: UIViewController, data: RequestAirportsStruct) {
        let networkManager = URL_Session()
        networkManager.delegate = self
        networkManager.executeAirports(parameters: RequestAirportsStruct(lat: data.lat, lon: data.lon, limit: data.limit, radius: data.limit, flight: data.flight))
    }
    
    func connectionFinishSuccessfull(session: URL_Session, response: ResponseAirport) {
        self.presenter?.receiveAirports(data: response)
    }
    
    func connectionFinishWithError(session: URL_Session, error: Error) {
        self.presenter?.reciveError(data: error.localizedDescription)
    }
}
