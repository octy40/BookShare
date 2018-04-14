//
//  BookCell.swift
//  BookShare
//
//  Created by Octave Muhirwa on 1/29/18.
//  Copyright © 2018 Octave Muhirwa. All rights reserved.
//

import UIKit
import Firebase

class BookTableViewCell: UITableViewCell {
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookOwner: UILabel!
    @IBOutlet weak var bookAvailability: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(book: Book, img: UIImage?){
        bookTitle.text = book.title
        bookOwner.text = book.owner
        bookAvailability.text = book.available
        
        if let img = img {
            self.bookImage.image = img
        } else {
            //downoload image and add it to cache
            let imgRef = StorageService.ss.REF_IMAGES.child(book.bookUUID + ".jpg")
            imgRef.getData(maxSize: 4 * 1024 * 1024, completion: { (data, error) in
                if let error = error {
                    print("BookShare: Error downloading image \(error)")
                } else {
                    if let imgData = data {
                        if let img = UIImage(data: imgData) {
                            self.bookImage.image = img
                            BookshelfViewController.imageCache.setObject(img, forKey: book.imageURL as NSString)
                        }
                    }
                }
            })
        }
    }

}
