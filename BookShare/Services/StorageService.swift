//
//  StorageService.swift
//  BookShare
//
//  Created by Octave Muhirwa on 3/28/18.
//  Copyright © 2018 Octave Muhirwa. All rights reserved.
//

import Foundation
import Firebase

let STORAGE_BASE = Storage.storage().reference()

class StorageService {
    static let ss = StorageService()
    private var _REF_IMAGES = STORAGE_BASE.child("book_images")
    var REF_IMAGES: StorageReference {
        return _REF_IMAGES
    }
    
    // [START upload image to storage]
    func uploadImageToStorage(imageUUID: String, image: UIImage) -> StorageUploadTask {
        // Convert image to jpg
        var data = Data()
        data = UIImageJPEGRepresentation(image, 0.8)!
        
        // Create storage reference to image to upload
        let imageRef = REF_IMAGES.child(imageUUID + ".jpg")
        
        // Create file metadata
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"        
        
        // Upload file and metadata
        let uploadTask = imageRef.putData(data, metadata: metadata)
        
        return uploadTask
    }
    // [END upload image to storage]
    
    func generateImageURL(bookUUID: String) -> String {
        let path = "book_images/" + bookUUID + ".jpg"
        let imageRef = STORAGE_BASE.child(path)
        var returnVal = ""
        imageRef.downloadURL { url, error in
            if let error = error {
                print("BookShare: Download error snag \(error)")
            } else {
                returnVal = (url?.absoluteString)!
                print("OCTAVE SCREAMING: \(url)")
            }
        }
        return returnVal
    }
}
