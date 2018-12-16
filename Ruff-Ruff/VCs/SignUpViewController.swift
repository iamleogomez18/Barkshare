//
//  SignUpViewController.swift
//  Ruff-Ruff
//
//  Created by Likhon Gomes on 5/31/18.
//  Copyright © 2018 ruffRuff. All rights reserved.
//

import UIKit
import Firebase
import KeychainSwift

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmpasswordTextField: UITextField!
    
    //Auth - KeyChain
    
    override func viewDidAppear(_ animated: Bool) {
        let keyChain = DataSerivce().keyChain
        if keyChain.get("uid") != nil{
            performSegue(withIdentifier: "moreDetails", sender: nil)
        }
    }
    
    func completeSignIn(id: String){
        let key = DataSerivce().keyChain
        key.set(id, forKey: "uid")
    }
    
    //END of KeyChain Auth
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    //View Loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //Memory
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func dismissOnClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    @IBAction func signUpButton(_ sender: Any) {
        if(passwordTextField.text == confirmpasswordTextField.text){
            
            if let email = emailTextField.text, let password = passwordTextField.text, let username = usernameTextField.text { //Setting pass and email to variables
               
                Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in  //Creating User
                         if error != nil {                                  // If Error is not null
                            print("cant sign in user")
                            }
                         else {                                                 //Else User Creation
                                guard let uid = user?.user.uid
                                    else{
                                            return
                                            }
                            let values = ["username": username, "email": email]
                            registerUserIntoDatabaseWithUID(uid: uid, values: values as [String : AnyObject])
          
                        }//End of Else
                            
                    })//Setting email,pass,username to variable 2nd if
            
        } //End of password check 1st if
        
    } //End Of SignUpButton Method
        
         func registerUserIntoDatabaseWithUID(uid: String, values: [String: AnyObject]){
            //Saving user in DataBase Name and Email
            let ref = Database.database().reference(fromURL: "https://ruff-ruff.firebaseio.com/")
            let usersFolder = ref.child("users").child((uid)) //creates users folder and inside of that creates another folder of users UID
            
            usersFolder.updateChildValues(values, withCompletionBlock: { (err, ref) in //means that update name and email inside the users/UID folder
                if err != nil {
                    print(err!)  ///If there is an error
                    return
                }
                //User Saved in DB
                print("User Saved in Database")
            })
            //Ends here for that
            self.completeSignIn(id: uid)
            self.dismiss(animated: true, completion: nil)
        }
    

    }
}

