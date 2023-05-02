//
//  DetailViewController.swift
//  Life Plus
//
//  Created by Habibur Rahman on 5/2/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var networkLabel: UILabel!
    @IBOutlet var scheduleLabel: UILabel!
    @IBOutlet var goBackButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Detail Page"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrowshape.turn.up.right"), style: .plain, target: self, action: #selector(shareContent))
        goBackButton.layer.masksToBounds = true
        goBackButton.layer.cornerRadius = 12
    }
    
    @objc func shareContent() {
        let shareText = "Hello, world!"

            let vc = UIActivityViewController(activityItems: [shareText], applicationActivities: [])
            present(vc, animated: true)
    }
    
    @IBAction func goBackButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}
