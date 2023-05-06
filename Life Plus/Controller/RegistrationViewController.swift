//
//  RegistrationViewController.swift
//  Life Plus
//
//  Created by Habibur Rahman on 5/2/23.
//

import UIKit
import CoreData

class RegistrationViewController: UIViewController {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var phoneTextField: UITextField!
    @IBOutlet var registerButton: UIButton!
    
    var users: [NSManagedObject] = []
    var userData: Set<[String: String]> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Registration"
        registerButton.layer.masksToBounds = true
        registerButton.layer.cornerRadius = 12
    }

    @IBAction func registerButtonTapped(_ sender: UIButton) {
        guard let nameText = nameTextField.text, let userNameText = userNameTextField.text, let passwordText = passwordTextField.text, let phoneNumber = phoneTextField.text else {
            return
        }
        guard !nameText.isEmpty && !nameText.hasPrefix(" ") && !userNameText.isEmpty && !userNameText.hasPrefix(" ") && !passwordText.isEmpty && !passwordText.hasPrefix(" ") && !phoneNumber.isEmpty && !phoneNumber.hasPrefix(" ") else {
            let alert = UIAlertController(title: "Alert", message: "All Fields Are Mandatory To Fill.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
            present(alert, animated: true)
            return
        }
        if fetchUserNameData() != userNameText {
            save(name: nameText, userName: userNameText, password: passwordText, phone: phoneNumber)
            navigationController?.popViewController(animated: true)
        }
        else {
            let alert = UIAlertController(title: "Alert", message: "User Name Already Exists.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { _ in
                self.userNameTextField.text = ""
                self.userNameTextField.placeholder = "Enter User Name Here"
            }))
            present(alert, animated: true)
        }
    }
    
    func save(name: String, userName: String, password: String, phone: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
        let user = NSManagedObject(entity: entity, insertInto: managedContext)
        user.setValue(userName, forKey: "userName")
        user.setValue(name, forKey: "name")
        user.setValue(password, forKey: "password")
        user.setValue(phone, forKey: "phone")
        do{
            try managedContext.save()
            users.append(user)
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func fetchUserNameData() -> String {
        var userName: String = ""
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return ""
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        do {
            users = try managedContext.fetch(fetchRequest)
            for user in users {
                userData.insert([user.value(forKeyPath: "userName") as! String: user.value(forKeyPath: "userName") as! String])
            }
            for info in userData {
                if let myInfo = info["\(userNameTextField.text!)"] {
                    userName = myInfo
                }
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return userName
    }
}
