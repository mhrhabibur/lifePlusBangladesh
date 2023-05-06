//
//  UserProfileViewController.swift
//  Life Plus
//
//  Created by Habibur Rahman on 5/2/23.
//

import UIKit
import CoreData

class UserProfileViewController: UIViewController {
    
    var userProfileID: String = ""
    var userID: String?
    var users: [NSManagedObject] = []
    var myUserInformation: Set<[String: String]> = []
    var userName: String = ""
    

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var phoneNumberLabel: UILabel!
    @IBOutlet var goBackButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Profile Details"
        goBackButton.layer.masksToBounds = true
        goBackButton.layer.cornerRadius = 12
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let userID = userID {
            userNameLabel.text = userID
            userProfileID = userID
        }
        var name = fetchUserNameData(name: userProfileID)
        print("Here is my phone Number \(name)")
        phoneNumberLabel.text = name
        
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
                myUserInformation.insert([user.value(forKeyPath: "userName") as! String: user.value(forKeyPath: "phone") as! String])
            }
            for info in myUserInformation {
                if let myInfo = info["\(userProfileID)"] {
                    userName = myInfo
                }
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return userName
    }
    
}
