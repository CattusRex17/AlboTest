//
//  SliderRouter.swift
//  AlboTest
//
//  Created by Mauricio Rodriguez on 09/04/21.
//

import UIKit

class SliderRouter: SliderRouterProtocol {
    // MARK: - Methods
    func pushToTabBar(from view: UIViewController, data: ResponseAirport) {
        let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
        let countriesViewController = storyboard.instantiateViewController(withIdentifier: "TabBarView") as! TabBarView
        countriesViewController.data = data
        view.navigationController?.pushViewController(countriesViewController, animated: true)
    }

    // MARK: - Create VIPER Module
    class func createModule(countriesRef: SliderView) {
        let presenter: SliderPresenterProtocol & SliderOutputInteractorProtocol = SliderPresenter()
        countriesRef.presenter = presenter
        countriesRef.presenter?.router = SliderRouter()
        countriesRef.presenter?.view = countriesRef
        countriesRef.presenter?.interactor = SliderInteractor()
        countriesRef.presenter?.interactor?.presenter = presenter
    }
}
