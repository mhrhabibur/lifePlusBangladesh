//
//  ViewController.swift
//  Life Plus
//
//  Created by Habibur Rahman on 5/2/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var logInButton: UIButton!
    @IBOutlet var registrationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logInButton.layer.cornerRadius = 12
        logInButton.layer.masksToBounds = true
        registrationButton.layer.masksToBounds = true
        registrationButton.layer.cornerRadius = 12
    }
    
    @IBAction func logInButtonTapped(_ sender: UIButton) {
        let logInVC = storyboard?.instantiateViewController(withIdentifier: "LogInVC") as! DashboardViewController
        navigationController?.pushViewController(logInVC, animated: true)
    }
    
    @IBAction func registrationButtonTapped(_ sender: UIButton) {
        let registrationVC = storyboard?.instantiateViewController(withIdentifier: "RegistrationVC") as! RegistrationViewController
        navigationController?.pushViewController(registrationVC, animated: true)
    }
}

