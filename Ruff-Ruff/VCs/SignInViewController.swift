//
//  SignInViewController.swift
//  Ruff-Ruff
//
//  Created by Likhon Gomes on 5/31/18.
//  Copyright © 2018 ruffRuff. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import KeychainSwift

class SignInViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!

    
    //Logs in already logged in user
    override func viewDidAppear(_ animated: Bool) {
        let keyChain = DataSerivce().keyChain
        if keyChain.get("uid") != nil{
            let user  = User()
            user.uid = keyChain.get("uid")
            print("This is the uid of the user \(user.uid!)")
            performSegue(withIdentifier: "option", sender: nil)
        }
    }
    //End
    
    //Setting keychain UID
    func completeSignIn(id: String){
        let key = DataSerivce().keyChain
        key.set(id, forKey: "uid")
    }
    //END
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    ///////VIEW LOADED
    
    
    @IBAction func signInClicked(_ sender: Any) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {  //Setting variables equal to text passed in
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {               //if there is no error
                    self.completeSignIn(id: Auth.auth().currentUser!.uid)
                    print("Signed IN")
                    self.performSegue(withIdentifier: "option", sender: nil)
                }
             })
        }//End of 1st if
        
    }//End of signInClicked
    
    
    
    
    @IBAction func signUpClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "signUpClicked", sender: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    
    
}//End of Class
