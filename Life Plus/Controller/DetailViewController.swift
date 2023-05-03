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
    
    var tvShows:[TVShow]?
    var tvShowsList = [TVShow]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goBackButton.layer.masksToBounds = true
        goBackButton.layer.cornerRadius = 12
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let tvShow = tvShows {
            tvShowsList = tvShow
        }
        refreshPage()
    }
    
    @IBAction func goBackButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func refreshPage() {
        if let posterImageURL = tvShowsList[0].image?.original {
            let url = URL(string: posterImageURL)!
            posterImageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "person"))
        }
        if let showName = tvShowsList[0].name {
            nameLabel.text = showName
        }
        if let network = tvShowsList[0].network?.name {
            networkLabel.text = network
        }
        if let time = tvShowsList[0].schedule?.time, let schedule = tvShowsList[0].schedule?.days {
            if schedule.count != 0 {
                scheduleLabel.text = "\(time), \(schedule[0])"
            } else {
                scheduleLabel.text = "No Date Found"
            }
        }
    }
}
