//
//  CountryDetailsViewController.swift
//  Countries
//
//  Created by Akshay Kulkarni on 15/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import UIKit

class CountryDetailsViewController: UIViewController {

    @IBOutlet weak var countryDetailTableView: UITableView! {
        didSet {
            countryDetailTableView.delegate = self
            countryDetailTableView.dataSource = self
            countryDetailTableView.register(UINib(nibName: "CountryDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "CountryDetailsTableViewCell")
            countryDetailTableView.register(UINib(nibName: "FlagTableViewCell", bundle: nil), forCellReuseIdentifier: "FlagTableViewCell")
            countryDetailTableView.rowHeight = UITableView.automaticDimension
            countryDetailTableView.estimatedRowHeight = 44
        }
    }
    var configurator: CountryDetailsConfigurator!
    var presenter: CountryDetailsPresenter?
    var imageToSave: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()

        configurator.configure(viewcontroller: self)
        // Do any additional setup after loading the view.
        presenter?.prepareFields()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = presenter?.getSelectedCountry().name
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
        
        if NetworkConnectivity.sharedInstance.isConnectedToInternet() {
            navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
        countryDetailTableView.register(UINib(nibName: "FlagHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "FlagHeaderView")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func saveTapped() {
        if let selectedCountry = presenter?.getSelectedCountry() {
            presenter?.saveCountry(country: selectedCountry, with: imageToSave!)
        }
    }

}

extension CountryDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getNumberOfDetails() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CountryDetailsTableViewCell", for: indexPath) as? CountryDetailsTableViewCell {
            if let detail = presenter?.getDetails(at: indexPath.row) {
                cell.configureCell(with: detail.cellValue ?? "", label: detail.cellContentType?.rawValue ?? "")
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableView.frame.width / 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FlagTableViewCell") as? FlagTableViewCell {
            if let country = presenter?.getSelectedCountry() {
                cell.configureImage(from: country)
                imageToSave = cell.flagImage.image
            }
            return cell
        }
        return UIView()
    }
}
