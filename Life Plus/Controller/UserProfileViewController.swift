//
//  UserProfileViewController.swift
//  Life Plus
//
//  Created by Habibur Rahman on 5/2/23.
//

import UIKit
import CoreData

class UserProfileViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var phoneNumberLabel: UILabel!
    @IBOutlet var goBackButton: UIButton!
    
    var userProfileName: String = ""
    var userID: String?
    var users: [NSManagedObject] = []
    var userData: Set<[String: String]> = []
    var myUserData: Set<[String: String]> = []
    var userName: String = ""
    var name: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Profile Details"
        goBackButton.layer.masksToBounds = true
        goBackButton.layer.cornerRadius = 12
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let userID = userID {
            userNameLabel.text = "User Name: \(userID)"
            userProfileName = userID
        }
        let phone = fetchUserNameData(name: userProfileName)
        phoneNumberLabel.text = "Phone Number: \(phone)"
        
        let name = fetchNameData(name: userProfileName)
        nameLabel.text = "Name: \(name)"
    }

    @IBAction func goBackButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func fetchUserNameData(name: String) -> String{
        var userName: String = ""
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return ""
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        do {
            users = try managedContext.fetch(fetchRequest)
            for user in users {
                userData.insert([user.value(forKeyPath: "userName") as! String: user.value(forKeyPath: "phone") as! String])
            }
            for data in userData {
                if let userName1 = data["\(userProfileName)"] {
                    userName = userName1
                }
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return userName
    }
    
    func fetchNameData(name: String) -> String{
        var name: String = ""
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return ""
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        do {
            users = try managedContext.fetch(fetchRequest)
            for user in users {
                myUserData.insert([user.value(forKeyPath: "userName") as! String: user.value(forKeyPath: "name") as! String])
            }
            for info in myUserData {
                if let myInfo = info["\(userProfileName)"] {
                    name = myInfo
                }
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return name
    }
    
}
