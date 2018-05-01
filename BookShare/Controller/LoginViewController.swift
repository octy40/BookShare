//
//  LoginViewController.swift
//  BookShare
//
//  Created by Octave Muhirwa on 1/22/18.
//  Copyright © 2018 Octave Muhirwa. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import SwiftKeychainWrapper

class LoginViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Check if there's a keychain
        let retrievedString: String? = KeychainWrapper.standard.string(forKey: KEY_UID)
        if let _ = retrievedString {
            print("BookShare: Data retrieved from keychain")
            //If there is, perform segue
            performSegue(withIdentifier: "goToHomeView", sender: nil)
        }
    }
    
    
    
    // Implementation of GIDSignInDelegate
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        
        if let error = error {
            print("BookShare: GoogleSignIn Error \(error)")
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        self.firebaseAuth(credential)
        
        // ...
    }
    
    func firebaseAuth(_ credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil {
                print("BookShare: Unable to authenticate with Firebase")
            } else {
                print("BookShare: Successfully authenticated with Firebase")
                if let user = user {
                    // [START save credential to keychain]
                    let _: Bool = KeychainWrapper.standard.set(user.uid, forKey: KEY_UID)
                    // [END save credential to keychain]
                    let userData = ["provider": credential.provider,
                                    "name":user.displayName!,
                                    "email":user.email!]
                    self.completeSignIn(id: user.uid, userData: userData)
                    self.performSegue(withIdentifier: "goToHomeView", sender: nil)
                }
            }
        }
    }
    
    func completeSignIn(id: String, userData: Dictionary<String, String>){
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // TODO: Implement sign-out
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // GoogleSignIn instance to handle URL after authentication process
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any])
        -> Bool {
            return GIDSignIn.sharedInstance().handle(url,
                                                     sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                     annotation: [:])
    }

}
