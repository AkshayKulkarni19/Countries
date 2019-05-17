//
//  CountriesViewController.swift
//  Countries
//
//  Created by Akshay Kulkarni on 15/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import UIKit

protocol CountriesView {
    func reloadData()
}

class CountriesViewController: UIViewController {

    @IBOutlet weak var countryTableView: UITableView! {
        didSet {
            countryTableView.delegate = self
            countryTableView.dataSource = self
            countryTableView.register(UINib(nibName: "CountryTableViewCell", bundle: nil), forCellReuseIdentifier: "CountryTableViewCell")
        }
    }
    var presenter: CountriesPresenter?
    private let configurator = CountriesConfiguratorImpl()
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configurator.configurator(viewcontroller: self)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search.PlaceHolder".localized
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Navigation.Title".localized
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CountriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getNumberOfCountries() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CountryTableViewCell", for: indexPath) as? CountryTableViewCell {
            
            if let country = presenter?.getCountry(at: indexPath.row) {
                cell.configure(with: country)
            }
            return cell
        }
        return UITableViewCell()
    }
    
}

extension CountriesViewController: CountriesView {
    func reloadData() {
        countryTableView.reloadData()
    }
}

extension CountriesViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        presenter?.fetchCountries(with: searchText)
    }
}
