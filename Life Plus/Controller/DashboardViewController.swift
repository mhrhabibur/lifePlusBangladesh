//
//  LogInViewController.swift
//  Life Plus
//
//  Created by Habibur Rahman on 5/2/23.
//

import UIKit

class DashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    let tvShowManager = TVShowManager()
    var tvShows = [TVShow]()
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var tableView: UITableView!
    
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
        cell.name.text = "\(tvShows[indexPath.row].name ?? "")"
        cell.network.text = "\(tvShows[indexPath.row].network?.name ?? "")"
        let urlString = tvShows[indexPath.row].image?.original
        if let urlString = urlString {
            let url = URL(string: urlString)!
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            cell.poster.image = image
                        }
                    }
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as? DetailViewController {
            detailVC.posterImage = tvShows[indexPath.row].image?.original
            detailVC.name = tvShows[indexPath.row].name
            detailVC.network = tvShows[indexPath.row].network?.name
            detailVC.schedule = tvShows[indexPath.row].schedule?.days?[0]
            detailVC.time = tvShows[indexPath.row].schedule?.time
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
