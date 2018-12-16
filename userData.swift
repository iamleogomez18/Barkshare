//
//  File.swift
//  Ruff-Ruff
//
//  Created by Likhon Gomes on 6/15/18.
//  Copyright © 2018 ruffRuff. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorageUI


class FirebaseImporter {
    
    var user:userData?
    init() {
        
        Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!).observe(.childAdded) { (snapshot) in
            //print("asdfasdfafadasdfa")
            //print(snapshot)
            let value = snapshot.value as? NSDictionary
            let username = value?["userFullName"] as? String ?? ""
            self.user?.emailAddress = value?["emailAddress"] as? String ?? ""
            self.user?.description = value?["description"] as? String ?? ""
            self.user?.userName = value?["userName"] as? String ?? ""

            //print(self.user.use)
            //self.users.append(user)
        }
    }
}

class userData{
    
    var userName:String
    var emailAddress:String
    var password:String
    var description:String
    //var userAge:Int = 0
    var userImage:UIImage
    var dogData:Array<dog>
    
    
    
    init() {
        
        
                
        self.userName = ""
        self.emailAddress = ""
        self.password = ""
        self.description = ""
        //self.userAge = 0
        self.userImage = UIImage()
        self.dogData = []
        //fire.getDataFromFirebase()
        
        Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!).observe(.childAdded) { (snapshot) in
            //print("asdfasdfafadasdfa")
            //print(snapshot)
            let value = snapshot.value as? NSDictionary
            let userFullName = value?["userFullName"] as? String ?? ""
            let emailAddress = value?["email"] as? String ?? ""
            self.description = value?["description"] as? String ?? ""
            let userName = value?["username"] as? String ?? ""
            
            print(userName)
            //self.users.append(user)
        }
    }
        

    func setUserName(){
        
    }
    
    func setEmailAddress(){
        
    }
    
    func setDescription(description:String) -> Void {
        var ref:DatabaseReference
        ref = Database.database().reference()
        ref.child("users").childByAutoId().setValue(description)

    }
    
    /*
    func setUserAge(uAge:Int) -> Void {
        userAge = uAge
    }*/
    
    func setUserImage(image:UIImage) -> Void  {
        
        //self.userImage = image
    }
    
    

    
    func getUserName() -> String{
        return self.userName
    }
    
    func getEmailAddress() -> String{
        return self.emailAddress
    }
    
    func getDescription() -> String {
        return self.description
    }
    
    /*
    func getUserAge() -> Int {
        return self.userAge
    }8*/
    
    func getUserImage() -> UIImage {
        
        return self.userImage
    }
 
}
