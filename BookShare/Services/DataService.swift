//
//  DataService.swift
//  BookShare
//
//  Created by Octave Muhirwa on 3/24/18.
//  Copyright © 2018 Octave Muhirwa. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

class DataService {
    
    static let ds = DataService()
    
    private var _REF_USERS = DB_BASE.child("users")
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }

}
