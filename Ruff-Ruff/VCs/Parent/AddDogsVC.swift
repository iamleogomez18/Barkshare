//
//  AddDogsVC.swift
//  Ruff-Ruff
//
//  Created by Likhon Gomes on 7/6/18.
//  Copyright © 2018 ruffRuff. All rights reserved.
//

import UIKit
import Firebase

class AddDogsVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    

    @IBOutlet weak var dogName: UITextField!
    @IBOutlet weak var dogAge: UITextField!
    @IBOutlet weak var dogBreed: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var imageView5: UIImageView!
    @IBOutlet weak var imageView6: UIImageView!
    
    var dogImage: Array<UIImage> = []
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func doneClicked(_ sender: Any) {
        let newDog:dog = dog()
        newDog.setDogName(dogName: dogName.text!)
        newDog.setDogBreed(dogBreed: dogBreed.text!)
        newDog.setDogAge(dogAge: dogAge.text!)
        newDog.setDogImage(dogImage: dogImage)
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
        dogImage.append(image)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func imageClicked(_ sender: Any) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        present(controller,animated: true,completion: nil)
    }
    
    
}
