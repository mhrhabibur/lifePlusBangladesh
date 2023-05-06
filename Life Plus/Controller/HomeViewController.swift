//
//  ViewController.swift
//  Life Plus
//
//  Created by Habibur Rahman on 5/2/23.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
    
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var logInButton: UIButton!
    @IBOutlet var registrationButton: UIButton!
    
    var users: [NSManagedObject] = []
    var myUserInformation: Set<[String: String]> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logInButton.layer.cornerRadius = 12
        logInButton.layer.masksToBounds = true
        registrationButton.layer.masksToBounds = true
        registrationButton.layer.cornerRadius = 12
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func logInButtonTapped(_ sender: UIButton) {
        let logInVC = storyboard?.instantiateViewController(withIdentifier: "LogInVC") as! DashboardViewController
        guard let userNameText = userNameTextField.text, let passwordText = passwordTextField.text  else {
            return
        }
        guard (!userNameText.isEmpty && !userNameText.hasPrefix(" ")) && (!passwordText.isEmpty && !passwordText.hasPrefix(" ")) else {
            if userNameText.isEmpty && passwordText.isEmpty {
                userNameTextField.placeholder = "Enter You User Name"
                passwordTextField.placeholder = "Enter You Password"
            } else if userNameText.isEmpty {
                userNameTextField.placeholder = "Enter You User Name"
            } else if passwordText.isEmpty {
                passwordTextField.placeholder = "Enter You Password"
            }
            return
        }
        guard (fetchUserNameData() == userNameText) && (fetchPasswordData() == passwordText) else {
            let alert = UIAlertController(title: "Alert", message: "User Name or Password Is Incorrect.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
            present(alert, animated: true)
            return
        }
                logInVC.userID = userNameText
                navigationController?.pushViewController(logInVC, animated: true)
            
        
    }
    
    @IBAction func registrationButtonTapped(_ sender: UIButton) {
        let registrationVC = storyboard?.instantiateViewController(withIdentifier: "RegistrationVC") as! RegistrationViewController
        navigationController?.pushViewController(registrationVC, animated: true)
    }
    
    func fetchUserNameData() -> String{
        var userName: String = ""
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return ""
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        do {
            users = try managedContext.fetch(fetchRequest)
            for user in users {
                myUserInformation.insert([user.value(forKeyPath: "userName") as! String: user.value(forKeyPath: "userName") as! String])
            }
            for info in myUserInformation {
                if let myInfo = info["\(userNameTextField.text!)"] {
                    userName = myInfo
                }
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return userName
    }
    
    private func fetchPasswordData() -> String{
        var passwordText: String = ""
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return ""
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        do {
            users = try managedContext.fetch(fetchRequest)
            for user in users {
                myUserInformation.insert([user.value(forKeyPath: "password") as! String: user.value(forKeyPath: "password") as! String])
            }
            for info in myUserInformation {
                if let myInfo = info["\(passwordTextField.text!)"] {
                    passwordText = myInfo
                }
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return passwordText
    }
}

