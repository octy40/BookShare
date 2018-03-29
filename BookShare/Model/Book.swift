//
//  Book.swift
//  BookShare
//
//  Created by Octave Muhirwa on 1/27/18.
//  Copyright © 2018 Octave Muhirwa. All rights reserved.
//

import Foundation

class Book{
    private var _title: String!
    private var _author: String!
    private var _owner: String!
    private var _bookImageURL: String!
    private var _numberOfPages: Int!
    private var _availability: Bool!
    
    init(title: String, author: String, owner:String, available: Bool){
        self._title = title
        self._author = author
        self._owner = owner
        self._availability = available
    }
    
    //TODO: Implement a full constructor
    init(title: String,author: String, owner: String, numberOfPages: Int, availability: Bool){
        
    }
    
    //MARK: Getters
    var title: String {
            return self._title
    }
    
    var author: String{
        return self._author
    }
    
    var owner: String{
        get {
            return self._owner
        }
        set(newValue){
            self._owner = newValue
        }
    }
    
    var available: Bool{
        return self._availability
    }
    
    //TODO: Implement setters
}
