//
//  RegistrationViewController.swift
//  Life Plus
//
//  Created by Habibur Rahman on 5/2/23.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var phoneTextField: UITextField!
    @IBOutlet var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Registration"
        registerButton.layer.masksToBounds = true
        registerButton.layer.cornerRadius = 12
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}
