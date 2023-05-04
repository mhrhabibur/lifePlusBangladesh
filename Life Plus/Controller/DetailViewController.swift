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
    
    var tvShows: TVShow?

    override func viewDidLoad() {
        super.viewDidLoad()
        goBackButton.layer.masksToBounds = true
        goBackButton.layer.cornerRadius = 12
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refreshPage()
    }
    
    @IBAction func goBackButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func refreshPage() {
        if let posterImageURL = tvShows?.image?.original {
            let url = URL(string: posterImageURL)!
            posterImageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "person"))
        }
        if let showName = tvShows?.name {
            nameLabel.text = showName
        }
        if let network = tvShows?.network?.name {
            networkLabel.text = network
        }
        if let time = tvShows?.schedule?.time, let schedule = tvShows?.schedule?.days {
            if schedule.count != 0 {
                scheduleLabel.text = "\(time), \(schedule[0])"
            } else {
                scheduleLabel.text = "No Date Found"
            }
        }
    }
}
