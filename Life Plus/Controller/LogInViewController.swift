//
//  LogInViewController.swift
//  Life Plus
//
//  Created by Habibur Rahman on 5/2/23.
//

import UIKit

class LogInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Log In"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "View Profile", style: .done, target: self, action: #selector(viewUserProfile))
    }
    
    @objc func viewUserProfile() {
        let userProfileVC = storyboard?.instantiateViewController(withIdentifier: "UserProfileVC") as! UserProfileViewController
        navigationController?.pushViewController(userProfileVC, animated: true)
    }
    
}
