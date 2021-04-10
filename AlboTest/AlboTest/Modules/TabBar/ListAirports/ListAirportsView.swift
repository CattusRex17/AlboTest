//
//  ListAirportsView.swift
//  AlboTest
//
//  Created by Mauricio Rodriguez on 09/04/21.
//

import UIKit

class ListAirportsView: UIViewController {

    // MARK: - Public properties
    @IBOutlet weak var airportsTableView: UITableView!
    var data: ResponseAirport?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    // MARK: - Init components
    func setUpView(){
        airportsTableView.delegate = self
        airportsTableView.dataSource = self
    }
}

// MARK: - Extension TableView
extension ListAirportsView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (data?.items.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AirportViewCell", for: indexPath) as! AirportViewCell
        cell.isSelected = false
        cell.nameLabel.text = data?.items[indexPath.row].name
        cell.codeLabel.text = data?.items[indexPath.row].iata
        cell.coordinatesLabel.text = String((data?.items[indexPath.row].location.lat)!) + ", " + String((data?.items[indexPath.row].location.lon)!)
        return cell
    }
}

// MARK: - TableViewCell
class AirportViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var coordinatesLabel: UILabel!
}
