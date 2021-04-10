//
//  SliderPresenter.swift
//  AlboTest
//
//  Created by Mauricio Rodriguez on 09/04/21.
//

import UIKit

class SliderPresenter: SliderPresenterProtocol {

    // MARK: - Public properties
    var router: SliderRouterProtocol?
    var view: SliderViewProtocol?
    var interactor: SliderInteractorProtocol?
    var presenter: SliderPresenterProtocol?
    
    // MARK: - Methods
    func getDataAirports(parameters: RequestAirportsStruct) {
        let data = parameters
        interactor?.getAirportsRequest(from: view as! UIViewController, data: data)
    }
}

// MARK: - Extensions
extension SliderPresenter: SliderOutputInteractorProtocol {
    func reciveError(data: String) {
        view?.returnError(data: data)
    }
    
    func receiveAirports(data: ResponseAirport) {
        if data.items.count > 0 {
            router?.pushToTabBar(from: view as! UIViewController, data: data)
        } else {
            view?.returnError(data: "No hay aeropuertos cercanos a tu posición, incrementa el radio de busqueda.")
        }
    }
}
