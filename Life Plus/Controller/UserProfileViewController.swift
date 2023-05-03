//
//  UserProfileViewController.swift
//  Life Plus
//
//  Created by Habibur Rahman on 5/2/23.
//

import UIKit

class UserProfileViewController: UIViewController {

    @IBOutlet var goBackButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Profile Details"
        goBackButton.layer.masksToBounds = true
        goBackButton.layer.cornerRadius = 12
    }
    
    @IBAction func goBackButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
