//
//  DetailViewController.swift
//  Life Plus
//
//  Created by Habibur Rahman on 5/2/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    var posterImage: String?
    var name: String?
    var network: String?
    var schedule: String?
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
        if let posterImage = posterImage {
            let url = URL(string: posterImage)!
            DispatchQueue.global().async { [weak self] in
                        if let data = try? Data(contentsOf: url) {
                            if let image = UIImage(data: data) {
                                DispatchQueue.main.async {
                                    self?.posterImageView.image = image
                                }
                            }
                        }
                    }
        }
        if let name = name {
            nameLabel.text = "Show Name: \(name)"
            navigationItem.title = "\(name)"
        }
        if let network = network {
            networkLabel.text = "Available At: \(network)"
        }
        if let schedule = schedule , let time = time {
            scheduleLabel.text = "Schedule: \(time), On \(schedule)"
        }
        
    }
    @IBAction func goBackButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}
