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
    
    static var imageCache: NSCache<NSString, UIImage> = NSCache()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
        self.loadBooks()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "BookTableViewCell"
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? BookTableViewCell {
            let book = books[indexPath.row]
            if let img = BookshelfViewController.imageCache.object(forKey: book.imageURL as NSString){
                cell.updateUI(book: book, img: img)
            } else {
                cell.updateUI(book: book, img: nil)
            }
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
                    //snap.key is the bookUUID
                    DataService.ds.REF_BOOKS.child(snap.key).observe(DataEventType.value, with: { (bookSnapshot) in
                        let bookDict = bookSnapshot.value as? [String : AnyObject] ?? [:]
                        let bookData: [String: String] = ["title" : bookDict["title"] as? String ?? "",
                                                          "author" : bookDict["author"] as? String ?? "",
                                                          "owner" : (Auth.auth().currentUser?.displayName)!,
                                                          "numberOfPages" : bookDict["numberOfPages"] as? String ?? "",
                                                          "availability" : bookDict["available"] as? String ?? "",
                                                          "imageURL" : bookDict["imageURL"] as? String ?? "",
                                                          "bookUUID" : snap.key]
                        
                        self.books.append(Book(bookData: bookData))
                    })
                }
            }
        }
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
