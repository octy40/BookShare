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
    private var _numberOfPages: String!
    private var _availability: String!
    
    //TODO: Implement a full constructor
    init(bookData: Dictionary<String, String>){
        self._title = bookData["title"]
        self._author = bookData["author"]
        self._owner = bookData["owner"]
        self._numberOfPages = bookData["numberOfPages"]
        self._availability = bookData["availability"]
        self._bookImageURL = bookData["imageURL"]
    }
    
    //MARK: Getters
    var title: String {
            return self._title
    }
    
    var author: String {
        return self._author
    }
    
    var owner: String {
        get {
            return self._owner
        }
        set(newValue){
            self._owner = newValue
        }
    }
    
    var available: String {
        return self._availability
    }
}
