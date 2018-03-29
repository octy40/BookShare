//
//  AddBookViewController.swift
//  BookShare
//
//  Created by Octave Muhirwa on 3/25/18.
//  Copyright © 2018 Octave Muhirwa. All rights reserved.
//

import UIKit
import Firebase

class AddBookViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bookTitle: UITextField!
    @IBOutlet weak var bookAuthor: UITextField!
    @IBOutlet weak var bookNumberOfPages: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
    }
    
    //Add Image
    @IBAction func chooseImage(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    /*
    // Plan
     * Define a utility that takes the created image and save it in Firebase under same uuid as the book's id
     * FIRST: Get user's uuid
    
    */
    
    @IBAction func addBookBtnPressed(_ sender: Any) {
        let bookUUID = NSUUID().uuidString
        let uid = Auth.auth().currentUser?.uid
        
        // Save image to Storage
        saveImageToStorage(bookUUID: bookUUID, image: imageView.image!)
        // Get imageURL
        let url = StorageService.ss.generateImageURL(bookUUID: bookUUID)
        // Construct userData
        let userData: [String: Any] = ["author":bookAuthor.text!,
                        "available":"yes",
                        "numberOfPages":bookNumberOfPages.text!,
                        "owner":uid!,
                        "title":bookTitle.text!,
                        "imageURL": url]
        // Create database entry
        DataService.ds.createFirebaseDBBook(bookUUID: bookUUID, userData: userData)
        // Show book added success
        let alertController = UIAlertController(title: "Success", message: "Book was added successfully", preferredStyle: UIAlertControllerStyle.alert)

        let action = UIAlertAction.init(title: "Dismiss", style: UIAlertActionStyle.default) { (action) in
            self.performSegue(withIdentifier: "goToBookShelf", sender: nil)
        }
        alertController.addAction(action)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // [START save image to storage and get URL]
    
    // Get StorageUploadTask object and control upload from this view controller
    func saveImageToStorage(bookUUID: String, image: UIImage){
        let uploadTask = StorageService.ss.uploadImageToStorage(imageUUID: bookUUID, image: image)
        
        // Listen for state changes, errors, and completion of the upload.
        uploadTask.observe(.resume) { snapshot in
            // Upload resumed, also fires when the upload starts
        }
        
        uploadTask.observe(.pause) { snapshot in
            // Upload paused
        }
        
        uploadTask.observe(.success) { snapshot in
            // Upload completed successfully
        }
        
        uploadTask.observe(.failure) { snapshot in
            if let error = snapshot.error as NSError? {
                switch (StorageErrorCode(rawValue: error.code)!) {
                case .objectNotFound:
                    // File doesn't exist
                    break
                case .unauthorized:
                    // User doesn't have permission to access file
                    break
                case .cancelled:
                    // User canceled the upload
                    break
                    
                    /* ... */
                    
                case .unknown:
                    // Unknown error occurred, inspect the server response
                    break
                default:
                    // A separate error occurred. This is a good place to retry the upload.
                    break
                }
            }
        }
        
    }
    // [END save image to storage and get URL]

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
