//
//  MainScreenVC.swift
//  Ruff-Ruff
//
//  Created by Nikhil on 6/9/18.
//  Copyright © 2018 ruffRuff. All rights reserved.
//

import UIKit
import Firebase
import KeychainSwift

class MainScreenVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let storage = Storage.storage().reference()
    
    // Get a reference to the storage service using the default Firebase App
    //let storage = FIRStorage.storage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
       
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 8
    }
    
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath )
        let imageCell = cell.viewWithTag(1) as! UIImageView
        
        
        
        /*
        let storageRef = storage.reference()
        //storageRef.child(filename)
        
        let downloadFile = storageRef.child("images.jpeg")
        
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        downloadFile.data(withMaxSize: 1000000, completion: { (data, error) in
            if error != nil {
                print(" we couldnt download the img")
            } else {
                if let imgData = data {
                    if let img = UIImage(data: imgData) {
                        //imageCell.image = img
                    }
                }
            }
            
        })*/

        
        //let data = userData()
        //imageCell.image = UIImage(named: "dog1")
        
        
        //var fb = FirebaseImporter()
        let data = userData()
        //imageCell.image = fb.getDataFromFirebase()
        imageCell.image = data.getUserImage()
        //data.setDescription(description: "Yo wassup ?")
        return cell
    }
     

    @IBAction func logoutClicked(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do{
            try firebaseAuth.signOut()
        } catch let signOutError as NSError{
            print("Sign Out error: %@", signOutError )
        }
        DataSerivce().keyChain.delete("uid")
        dismiss(animated: true, completion: nil)
        //performSegue(withIdentifier: "backToSignIn", sender: (Any).self)
        
    }
    
    
    

}
