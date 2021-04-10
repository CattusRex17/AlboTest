//
//  TabBarView.swift
//  AlboTest
//
//  Created by Mauricio Rodriguez on 09/04/21.
//

import UIKit

class TabBarView: UITabBarController, UITabBarControllerDelegate {
    
    // MARK: - Public properties
    var data: ResponseAirport? = nil
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpTabBar(animate: animated)
    }
    
    // MARK: - Init components
    func setUpTabBar(animate: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animate)
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layoutIfNeeded()
    }
    
    func setUpView() {
        self.delegate = self
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.setTabs()
            }
        }
    }

    func setTabs() {
        let story = UIStoryboard(name: "TabBar", bundle: nil)
        let map = story.instantiateViewController(withIdentifier: "MapAirportsView") as! MapAirportsView
        let iconLoc = UITabBarItem(title: "", image: UIImage(named: "Location"), tag: 0)
        map.tabBarItem = iconLoc
        map.data = data
        
        let story1 = UIStoryboard(name: "TabBar", bundle: nil)
        let list = story1.instantiateViewController(withIdentifier: "ListAirportsView") as! ListAirportsView
        let iconMen = UITabBarItem(title: "", image: UIImage(named: "Menu"), tag: 0)
        list.tabBarItem = iconMen
        list.data = data

        self.viewControllers = [map, list]
        self.tabBar.backgroundColor = .clear
        self.tabBar.isTranslucent = true
    }
}
