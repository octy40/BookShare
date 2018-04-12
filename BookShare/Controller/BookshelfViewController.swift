//
//  BookshelfViewController.swift
//  BookShare
//
//  Created by Octave Muhirwa on 1/23/18.
//  Copyright © 2018 Octave Muhirwa. All rights reserved.
//

import UIKit
import Firebase

class BookshelfViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    private var books = [Book]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
        self.loadBooks()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "BookTableViewCell"
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? BookTableViewCell {
            let book = books[indexPath.row]
            cell.updateUI(book: book)
            
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    //MARK: - Private Methods
    private func loadBooks(){
        // Retrieve data from books_owned
        let uid = Auth.auth().currentUser?.uid        
        DataService.ds.REF_BOOKS_OWNED.child(uid!).observe(DataEventType.value) { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    print("SNAP: \(snap.key)")
                    //snap.key is the bookUUID
                }
            }
        }
        
        
        let book1 = Book(title: "Fire and Fury: Inside the Trump White House", author: "Michael Wolff", owner: "Bert", available: true)
        let book2 = Book(title: "Fire and Fury: Inside the Trump White House", author: "Michael Wolff", owner: "Bert", available: true)
        let book3 = Book(title: "Fire and Fury: Inside the Trump White House", author: "Michael Wolff", owner: "Bert", available: true)
        let book4 = Book(title: "Fire and Fury: Inside the Trump White House", author: "Michael Wolff", owner: "Bert", available: true)
        let book5 = Book(title: "Fire and Fury: Inside the Trump White House", author: "Michael Wolff", owner: "Bert", available: true)
        let book6 = Book(title: "Fire and Fury: Inside the Trump White House", author: "Michael Wolff", owner: "Bert", available: true)
        let book7 = Book(title: "Fire and Fury: Inside the Trump White House", author: "Michael Wolff", owner: "Bert", available: true)
        
        books += [book1, book2, book3, book4, book5, book6, book7]
    }
    
    //TODO: Implement a method that loads books that are in the database for a particular user!
    
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
