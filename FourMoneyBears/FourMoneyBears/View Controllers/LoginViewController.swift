//
//  LoginViewController.swift
//  FourMoneyBears
//
//  Created by Austin Potts on 6/6/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViews()
        
    
        
    }
    
    @IBOutlet var usernameText: UITextField!
    @IBOutlet var passwordText: UITextField! // FIXME: EMAIL TEXT FIELD
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var credentialView: UIView!
    
 
    
    func setUpViews(){
        loginButton.layer.cornerRadius = 15
        credentialView.layer.cornerRadius = 15
    }
    
    func handleLogIn() {
         
         guard let email = usernameText.text, let password = passwordText.text else { return }
         
         Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
             if let error = error {
                 // MARK: - TODO Add Notification to user that the login failed
                 print("Error signing in: \(error)")
                 return
             }
             
             self.performSegue(withIdentifier: "LogInSegue", sender: self)
         }
         
     }
    
    
    
    @IBAction func noAccountButtonTapped(_ sender: Any) {
    }
    
    
    @IBAction func fogotPasswordTapped(_ sender: Any) {
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        handleLogIn()
    }
    
}
