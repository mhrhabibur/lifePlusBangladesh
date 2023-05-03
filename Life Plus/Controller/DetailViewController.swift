//
//  DetailViewController.swift
//  Life Plus
//
//  Created by Habibur Rahman on 5/2/23.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var networkLabel: UILabel!
    @IBOutlet var scheduleLabel: UILabel!
    @IBOutlet var goBackButton: UIButton!
    
    var imageURL: String?
    var showName: String?
    var indexPath: Int?
    var name: String?
    var network: String?
    var schedule: [String]?
    var time: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goBackButton.layer.masksToBounds = true
        goBackButton.layer.cornerRadius = 12
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .plain, target: self, action: #selector(refreshPage))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refreshPage()
    }
    @IBAction func goBackButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func refreshPage() {
        if let imageURL = imageURL {
            let url = URL(string: imageURL)!
            posterImageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "person"))
        }
        if let name = name {
            nameLabel.text = "\(name)"
            navigationItem.title = "\(name)"
        }
        if let network = network {
            networkLabel.text = "\(network)"
        }
        
        if let  time = time {
            scheduleLabel.text = "\(time)"
        }
        
        if schedule?.count != 0 {
            scheduleLabel.text = "\(time!), \(schedule![0])"
        } else {
            scheduleLabel.text = "No Date Found"
        }
    }
}
