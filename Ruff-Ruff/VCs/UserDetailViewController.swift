//
//  UserDetailViewController.swift
//  Ruff-Ruff
//
//  Created by Likhon Gomes on 6/18/18.
//  Copyright © 2018 ruffRuff. All rights reserved.
//

import UIKit
import Firebase

class UserDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var userFullName: UITextField!
    @IBOutlet weak var userImage: UIImageView!
    let data = userData()
    
    var ref:DatabaseReference! = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userImage.layer.cornerRadius = userImage.frame.size.width/2
        userImage.clipsToBounds = true
    }
    
    
    @IBAction func chooseImage(_ sender: Any) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        present(controller,animated: true,completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        userImage.image = image
        data.setUserImage(image: userImage.image!)
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneClicked(_ sender: Any) {
        self.ref.child("users/\(Auth.auth().currentUser?.uid)/userFullName").setValue(userFullName.text)
    }
    
    
}
