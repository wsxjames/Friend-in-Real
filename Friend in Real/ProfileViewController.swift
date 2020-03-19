//
//  ProfileViewController.swift
//  Friend in Real
//
//  Created by 吴世欣 on 3/18/20.
//  Copyright © 2020 James Wu. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    @IBOutlet var userProfile: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        userProfile.text=Auth.auth().currentUser?.email
    }
    
    
    
    
    @IBAction func logout(_ sender: Any) {
        
        do
        {
            try Auth.auth().signOut()
        }
        catch let error as NSError
        {
            print (error.localizedDescription)
        }
        
        let storyboard = UIStoryboard(name: "LoginSignUp", bundle: nil)
        let homeViewController = (storyboard.instantiateViewController(identifier: "LoginSignUpViewController") as? UINavigationController)!
        
        self.view.window?.rootViewController = homeViewController
        self.view.window?.makeKeyAndVisible()
    }
}
