//
//  SliderProtocols.swift
//  AlboTest
//
//  Created by Mauricio Rodriguez on 09/04/21.
//

import UIKit

protocol SliderViewProtocol: class {
    // PRESENTER -> VIEW
    func returnError(data: String)
}

protocol SliderPresenterProtocol: class {
    //View -> Presenter
    var interactor: SliderInteractorProtocol? {get set}
    var view: SliderViewProtocol? {get set}
    var router: SliderRouterProtocol? {get set}

    func getDataAirports(parameters: RequestAirportsStruct)
}

protocol SliderInteractorProtocol: class {
    var presenter: SliderOutputInteractorProtocol? {get set}
    //Presenter -> Interactor
    func getAirportsRequest(from view: UIViewController, data: RequestAirportsStruct)
}

protocol SliderOutputInteractorProtocol: class {
//  Interactor -> PresenterOutput
    func receiveAirports(data: ResponseAirport)
    func reciveError(data: String)
}

protocol SliderRouterProtocol: class {
    //Presenter -> Wireframe
    static func createModule(countriesRef: SliderView)
    func pushToTabBar(from view: UIViewController, data: ResponseAirport)
}

