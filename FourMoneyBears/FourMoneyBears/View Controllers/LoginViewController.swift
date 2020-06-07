//
//  LoginViewController.swift
//  FourMoneyBears
//
//  Created by Austin Potts on 6/6/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViews()
        
    }
    
    @IBOutlet var usernameText: UITextField!
    @IBOutlet var passwordText: UITextField!
    
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var credentialView: UIView!
    
 
    
    func setUpViews(){
        loginButton.layer.cornerRadius = 15
        credentialView.layer.cornerRadius = 15
    }
    
    
    
    
    @IBAction func noAccountButtonTapped(_ sender: Any) {
    }
    
    
    @IBAction func fogotPasswordTapped(_ sender: Any) {
    }
    
    @IBAction func loginTapped(_ sender: Any) {
    }
}
