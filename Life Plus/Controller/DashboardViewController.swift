//
//  LogInViewController.swift
//  Life Plus
//
//  Created by Habibur Rahman on 5/2/23.
//

import UIKit
import SDWebImage

class DashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var tableView: UITableView!
    
    let tvShowManager = TVShowManager()
    var tvShows = [TVShow]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Dashboard"
        searchTextField.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "View Profile", style: .done, target: self, action: #selector(viewUserProfile))
        tableView.delegate = self
        tableView.dataSource = self
        searchButton.layer.masksToBounds = true
        searchButton.layer.cornerRadius = 12
        searchTextField.addTarget(self, action: #selector(searchTvShow(_:)), for: .editingChanged)
    }
    
    @objc func viewUserProfile() {
        let userProfileVC = storyboard?.instantiateViewController(withIdentifier: "UserProfileVC") as! UserProfileViewController
        navigationController?.pushViewController(userProfileVC, animated: true)
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        let searchText = searchTextField.text
        tvShowManager.fetchTVShowData(name: searchText ?? "") { tvShow, error in
            if let tvShowList = tvShow {
                self.tvShows = [tvShowList]
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return tvShows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TVShowTableViewCell
        cell.tvShows = tvShows[indexPath.row]
        if let urlString = cell.tvShows?.image?.original {
            let url = URL(string: urlString)!
            cell.poster.sd_setImage(with: url, placeholderImage: UIImage(systemName: "person"))
        }
        if let tvShowName = cell.tvShows?.name {
            cell.name.text = tvShowName
        }
        if let networkName = cell.tvShows?.network?.name {
            cell.network.text = networkName
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as? DetailViewController {
            detailVC.tvShows = tvShows[indexPath.row]
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    @IBAction func searchTvShow(_ sender: UITextField) {
        if let searchText = searchTextField.text {
            DispatchQueue.global().async {
                self.tvShowManager.fetchTVShowData(name: searchText) { tvShow, error in
                    if let tvShowList = tvShow {
                        self.tvShows = [tvShowList]
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
}
