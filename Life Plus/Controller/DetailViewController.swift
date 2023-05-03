//
//  DetailViewController.swift
//  Life Plus
//
//  Created by Habibur Rahman on 5/2/23.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    var imageURL: String?
    var name: String?
    var network: String?
    var schedule: [String]?
    var time: String?
    
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var networkLabel: UILabel!
    @IBOutlet var scheduleLabel: UILabel!
    @IBOutlet var goBackButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goBackButton.layer.masksToBounds = true
        goBackButton.layer.cornerRadius = 12
        
        if let posterImage = imageURL {
            let url = URL(string: posterImage)!
            posterImageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "person"))
        }
        if let name = name {
            nameLabel.text = "Show Name: \(name)"
            navigationItem.title = "\(name)"
        }
        if let network = network {
            networkLabel.text = "Available At: \(network)"
        }
        
        if let  time = time {
            scheduleLabel.text = "\(time)"
        }
        
        if schedule?.count != 0 {
            scheduleLabel.text = "Schedule: \(time!), On \(schedule![0])"
        } else {
            scheduleLabel.text = "No Date Found"
        }
    }
    @IBAction func goBackButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
