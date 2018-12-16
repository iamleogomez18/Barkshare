//
//  ParentMainViewController.swift
//  Ruff-Ruff
//
//  Created by Likhon Gomes on 7/6/18.
//  Copyright © 2018 ruffRuff. All rights reserved.
//

import UIKit
import Firebase
import KeychainSwift


class ParentMainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    let storageRef = Storage.storage().reference()
    @IBOutlet weak var collectionView: UICollectionView!
    var dogs:Array<dog> = []
    var dogImage:Array<UIImage> = []
    var currentDog:dog = dog()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!).child("dogs").observe(.childAdded) { (snapshot) in
            let dogData = dog()
            let value = snapshot.value as? NSDictionary
            dogData.dogName = value?["name"] as? String ?? ""
            dogData.dogBreed = value?["breed"] as? String ?? ""
            dogData.dogAge = value?["age"] as? String ?? ""
            let dogIm = value?["dogImage0"] as? String ?? ""
            dogData.dogImageRef.append(dogIm)
            print("printing" + dogIm)
            //dogData.dogImage.append(contentsOf: dogImage)
            self.dogs.append(dogData)
            
            
            self.collectionView!.reloadData()
        }
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(dogs.count)
        return self.dogs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var data = self.dogs[indexPath.row]
        currentDog = self.dogs[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let imageView = cell.viewWithTag(1) as! UIImageView
        let nameLabel = cell.viewWithTag(2) as! UILabel
        let locationLabel = cell.viewWithTag(3) as! UILabel
        let ageLabel = cell.viewWithTag(4) as! UILabel
        let distanceLabel = cell.viewWithTag(5) as! UILabel
        let priceLabel = cell.viewWithTag(6) as! UILabel
        
        nameLabel.text = data.dogName
        ageLabel.text = data.dogAge
        
        var image:UIImage?
        print(data.dogImageRef[0])
        print("dong Name\(data.dogName)")
        
        //let islandRef = storageRef.child("/rivers.jpg")
        let islandRef = storageRef.child("Dogs/\(data.dogName)/\(data.dogImageRef[0]).jpg")
        islandRef.getData(maxSize: 10 * 1024 * 1024) { data, error in
            if let error = error {
                print("failed to get image")
            } else {
                print("succeeded")
                image = UIImage(data: data!)!
                self.dogs[indexPath.row].dogImage.append(image!)
                imageView.image = self.dogs[indexPath.row].dogImage[0]
                
            }
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Start", bundle: nil)
        let desVC = mainStoryBoard.instantiateViewController(withIdentifier: "PetDetailsViewController") as! PetDetailsViewController
        desVC.nameData = self.dogs[indexPath.row].dogName
        //desVC.priceData = self.dogs[indexPath.row]
        desVC.ageData = self.dogs[indexPath.row].dogAge
        //desVC.descriptionData = self.dogs[indexPath.row].dogDescriptop
        desVC.dogImage = self.dogs[indexPath.row].dogImage
        self.navigationController?.pushViewController(desVC, animated: true)
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
