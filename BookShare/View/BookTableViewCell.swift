//
//  BookCell.swift
//  BookShare
//
//  Created by Octave Muhirwa on 1/29/18.
//  Copyright © 2018 Octave Muhirwa. All rights reserved.
//

import UIKit

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
    
    func updateUI(book: Book){
        bookTitle.text = book.title
        bookOwner.text = book.owner
        if(book.available){
            bookAvailability.text = "Yes"
        }else{
            bookAvailability.text = "No"
        }
        
        //TODO: Configure the book's image
    }

}
