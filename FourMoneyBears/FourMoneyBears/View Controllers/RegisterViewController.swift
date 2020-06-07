//
//  RegisterViewController.swift
//  FourMoneyBears
//
//  Created by Austin Potts on 6/6/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
 
        setUpViews()
    }
    
    @IBOutlet var credView: UIView!
    
    @IBOutlet var usernameText: UITextField!
    @IBOutlet var emailText: UITextField!
    @IBOutlet var passwordText: UITextField!
    @IBOutlet var ageText: UITextField!
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var registerButton: UIButton!
    
    
    func setUpViews(){
        credView.layer.cornerRadius = 15
        registerButton.layer.cornerRadius = 15
    }
    

}
