//
//  ViewController.swift
//  BookShare
//
//  Created by Octave Muhirwa on 1/22/18.
//  Copyright © 2018 Octave Muhirwa. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class HomePageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signOutBtnTapped(_ sender: Any) {
        //Sign out from Firebase
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print("BookShare: Firebase sign out successful")
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        // [START keychain removal]
        let _: Bool = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        // [END keychain removal]
        //Go to Home Page
        performSegue(withIdentifier: "goToSignIn", sender: nil)    }
    
}

