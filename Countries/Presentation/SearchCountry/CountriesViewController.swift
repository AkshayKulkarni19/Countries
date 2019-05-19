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
    func showIndicator()
    func hideIndicator()
}

class CountriesViewController: UIViewController {

    @IBOutlet weak var countryTableView: UITableView! {
        didSet {
            countryTableView.delegate = self
            countryTableView.dataSource = self
            countryTableView.register(UINib(nibName: "CountryTableViewCell", bundle: nil), forCellReuseIdentifier: "CountryTableViewCell")
            countryTableView.register(UINib(nibName: "NoCountryTableViewCell", bundle: nil), forCellReuseIdentifier: "NoCountryTableViewCell")
        }
    }
    var presenter: CountriesPresenter?
    var router: CountriesRouter?
    private let configurator = CountriesConfiguratorImpl()
    private let searchController = UISearchController(searchResultsController: nil)
    private var selectedCountry: CountryInfo?
    private var activityIndicator: UIActivityIndicatorView?
    private var numberOfCountries: Int = 0
    
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
        if !NetworkConnectivity.sharedInstance.isConnectedToInternet() {
            presenter?.fetchCountriesFromDB()
        }
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: (countryTableView.frame.width/2), y: (countryTableView.frame.height/2), width: 20, height: 20))
        activityIndicator?.style = .gray
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectedCountry = selectedCountry {
            router?.prepare(for: segue, sender: sender, country: selectedCountry)
        }
    }
}

extension CountriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        numberOfCountries = presenter?.getNumberOfCountries() ?? 0
        if numberOfCountries > 0 {
            return numberOfCountries
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if numberOfCountries == 0{
            return tableView.frame.height
        }
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if numberOfCountries == 0 {
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "NoCountryTableViewCell", for: indexPath) as? NoCountryTableViewCell {
                if let searchtext = searchController.searchBar.text, searchController.isActive && !searchtext.isEmpty {
                    cell.configure(message: String(format: "Search.NoCountyFound.message".localized, searchtext))
                } else {
                    cell.configure(message: "Search.Initial.message".localized)
                }
                return cell
            }
            return UITableViewCell()
        }
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CountryTableViewCell", for: indexPath) as? CountryTableViewCell {
            
            if let country = presenter?.getCountry(at: indexPath.row) {
                cell.configure(with: country)
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if numberOfCountries != 0{
            if let country = presenter?.getCountry(at: indexPath.row) {
                selectedCountry = country
                tableView.deselectRow(at: indexPath, animated: true)
                performSegue(withIdentifier: "showCountryDetails", sender: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}

extension CountriesViewController: CountriesView {
    func reloadData() {
        countryTableView.reloadData()
    }
    
    func showIndicator() {
        activityIndicator?.startAnimating()
        if let indicator = activityIndicator {
            countryTableView.addSubview(indicator)
        }
    }
    
    func hideIndicator() {
        activityIndicator?.stopAnimating()
        activityIndicator?.removeFromSuperview()
    }
}

extension CountriesViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        if !searchText.isEmpty {
            if NetworkConnectivity.sharedInstance.isConnectedToInternet() {
                presenter?.fetchCountries(with: searchText)
            }else {
                presenter?.fetchCountriesOffline(with: searchText)
            }
        } else {
            if NetworkConnectivity.sharedInstance.isConnectedToInternet() {
                presenter?.clearCountries()
            } else {
                presenter?.fetchCountriesOffline(with: searchText)
            }
        }
    }
}
