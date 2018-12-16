//
//  dog.swift
//  Ruff-Ruff
//
//  Created by Likhon Gomes on 6/15/18.
//  Copyright © 2018 ruffRuff. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class dog{
    
    let ref:DatabaseReference = Database.database().reference()
    let storageRef = Storage.storage().reference()
    
    
    
    var dogName:String
    var dogAge:String
    var dogBreed:String
    var dogVaccination:Array<String>
    var dogImage: Array<UIImage>
    var dogImageRef:Array<String>
    var tipsTricks: Array<String> /// the logo should be similar to a bone.
    
    init(dogName:String,dogAge:String,dogBreed:String,dogVaccination:Array<String>?,dogImage:Array<UIImage>?,dogImageRef:Array<String>,tipsTricks:Array<String>?) {
        self.dogName = dogName
        self.dogAge = dogAge
        self.dogBreed = dogBreed
        self.dogVaccination = dogVaccination!
        self.dogImage = dogImage!
        self.tipsTricks = tipsTricks!
        self.dogImageRef = dogImageRef
        
    }
    
    init() {
        self.dogName = ""
        self.dogAge = ""
        self.dogBreed = ""
        self.dogVaccination = []
        self.dogImage = []
        self.tipsTricks = []
        self.dogImageRef = []
    }
    
    func getDogName() -> String {
        return self.dogName
    }
    
    func getDogAge() -> String {
        
        return dogAge
    }
    
    
    func setDogName(dogName:String) -> Void {
        self.dogName = dogName
        self.ref.child("users/\(Auth.auth().currentUser!.uid)/dogs/\(dogName)/name").setValue(dogName)
    }
    
    
    func setDogAge(dogAge:String) -> Void {
        self.ref.child("users/\(Auth.auth().currentUser!.uid)/dogs/\(dogName)/age").setValue(dogAge)
    }
    
    
    func setDogBreed(dogBreed:String) -> Void {
        self.dogBreed = dogBreed
        self.ref.child("users/\(Auth.auth().currentUser!.uid)/dogs/\(dogName)/breed").setValue(dogName)
    }
    
    
    func setDogImage(dogImage:Array<UIImage>) -> Void {
        
        var count:Int = 0
        for image in dogImage{
            //let imagesRef = storageRef.child("\(Auth.auth().currentUser?.uid)/DogImage/\(dogName)")
            guard let imageData = UIImageJPEGRepresentation(image, 1) else {return}
            let imageName = NSUUID().uuidString
            let riversRef = storageRef.child("/Dogs/\(dogName)/\(imageName).jpg")
            self.ref.child("users/\(Auth.auth().currentUser!.uid)/dogs/\(dogName)/dogImage\(count)").setValue(imageName)
            // Upload the file to the path "images/rivers.jpg"
            let uploadTask = riversRef.putData(imageData, metadata: nil) { (metadata, error) in
                guard let metadata = metadata else {
                    // Uh-oh, an error occurred!
                    return
                }
                // Metadata contains file metadata such as size, content-type.
                let size = metadata.size
                // You can also access to download URL after upload.
                self.storageRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        // Uh-oh, an error occurred!
                        return
                    }
                }
            }
            count += 1
        }
    }
    
    
    func getDogImage() -> Array<UIImage> {
        return dogImage
    }
    
}
