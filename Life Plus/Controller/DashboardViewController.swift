//
//  LogInViewController.swift
//  Life Plus
//
//  Created by Habibur Rahman on 5/2/23.
//

import UIKit

class DashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tvShowManager = TVShowManager()
    var tvShows = [TVShow]()
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Dashboard"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "View Profile", style: .done, target: self, action: #selector(viewUserProfile))
        tableView.delegate = self
        tableView.dataSource = self
        searchButton.layer.masksToBounds = true
        searchButton.layer.cornerRadius = 12
        tvShowManager.fetchTVShowData { tvShow, error in
            if let tvShowList = tvShow {
                self.tvShows = [tvShowList]
        }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func viewUserProfile() {
        let userProfileVC = storyboard?.instantiateViewController(withIdentifier: "UserProfileVC") as! UserProfileViewController
        navigationController?.pushViewController(userProfileVC, animated: true)
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvShows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
        cell.textLabel?.text = "\(tvShows[indexPath.row].name ?? "")"
        cell.detailTextLabel?.text = "\(tvShows[indexPath.row].network?.name ?? "")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailViewController
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
