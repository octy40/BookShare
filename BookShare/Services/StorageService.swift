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
        
//        // TODO: Implement error handling if file fails to upload
//        // Listen for state changes, errors, and completion of the upload.
//        uploadTask.observe(.resume) { snapshot in
//            // Upload resumed, also fires when the upload starts
//        }
//
//        uploadTask.observe(.pause) { snapshot in
//            // Upload paused
//        }
//
//        uploadTask.observe(.success) { snapshot in
//            // Upload completed successfully
//        }
//
//        uploadTask.observe(.failure) { snapshot in
//            if let error = snapshot.error as NSError? {
//                switch (StorageErrorCode(rawValue: error.code)!) {
//                case .objectNotFound:
//                    // File doesn't exist
//                    break
//                case .unauthorized:
//                    // User doesn't have permission to access file
//                    break
//                case .cancelled:
//                    // User canceled the upload
//                    break
//
//                    /* ... */
//
//                case .unknown:
//                    // Unknown error occurred, inspect the server response
//                    break
//                default:
//                    // A separate error occurred. This is a good place to retry the upload.
//                    break
//                }
//            }
//        }
        
    }
    
    func generateImageURL(bookUUID: String) -> String {
        let imageRef = REF_IMAGES.child(bookUUID + ".jpg")
        var returnVal = ""
        imageRef.downloadURL { (url, error) in
            if let error = error {
                print("BookShare: Download error snag \(error)")
            } else {
                returnVal = (url?.absoluteString)!
            }
        }
        return returnVal
    }
    
}
