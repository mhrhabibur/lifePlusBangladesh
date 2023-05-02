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
        navigationItem.title = "Life Plus"
        logInButton.layer.cornerRadius = 12
        logInButton.layer.masksToBounds = true
        registrationButton.layer.masksToBounds = true
        registrationButton.layer.cornerRadius = 12
    }
    
    @IBAction func logInButtonTapped(_ sender: UIButton) {
        let logInVC = storyboard?.instantiateViewController(withIdentifier: "LogInVC") as! LogInViewController
        navigationController?.pushViewController(logInVC, animated: true)
    }
    
    
    @IBAction func registrationButtonTapped(_ sender: UIButton) {
        
        print("Registration Button Tapped")
        let registrationVC = storyboard?.instantiateViewController(withIdentifier: "RegistrationVC") as! RegistrationViewController
        navigationController?.pushViewController(registrationVC, animated: true)
    }
    


}

