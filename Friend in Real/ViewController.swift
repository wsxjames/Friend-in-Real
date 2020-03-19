//
//  ViewController.swift
//  Friend in Real
//
//  Created by 吴世欣 on 3/14/20.
//  Copyright © 2020 James Wu. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func testPressed(_ sender: Any) {
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        //        let homeViewController = storyboard.instantiateViewController(identifier: "HomeViewController") as? UITabBarController
        //
        //        self.view.window?.rootViewController = homeViewController
        //        self.view.window?.makeKeyAndVisible()
                var storyboard :UIStoryboard
                var homeViewController: UIViewController
        
        
                if Auth.auth().currentUser == nil {
                    storyboard = UIStoryboard(name: "LoginSignUp", bundle: nil)
                    homeViewController = (storyboard.instantiateViewController(identifier: "LoginSignUpViewController") as? UINavigationController)!
                }else{
                    storyboard = UIStoryboard(name: "Home", bundle: nil)
                    homeViewController = (storyboard.instantiateViewController(identifier: "HomeViewController") as? UITabBarController)!
                }
//        print("current user is: ",Auth.auth().currentUser?.email)
        //        Auth.auth().addStateDidChangeListener { auth, user in
        //          if let user = user {
        //           let storyboard = UIStoryboard(name: "LoginSignUp", bundle: nil)
        //           let homeViewController = (storyboard.instantiateViewController(identifier: "LoginSignUpViewController") as? UINavigationController)!
        //
        //            self.view.window?.rootViewController = homeViewController
        //            self.view.window?.makeKeyAndVisible()
        //          } else {
        //            let storyboard = UIStoryboard(name: "Home", bundle: nil)
        //            let homeViewController = (storyboard.instantiateViewController(identifier: "HomeViewController") as? UITabBarController)!
        //
                    self.view.window?.rootViewController = homeViewController
                    self.view.window?.makeKeyAndVisible()
        //          }
        //        }
        
        
        
        
    }
}

