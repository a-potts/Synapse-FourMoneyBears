//
//  LoginViewController.swift
//  FourMoneyBears
//
//  Created by Austin Potts on 6/6/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import Firebase
import SCLAlertView

class LoginViewController: UIViewController {

    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViews()
    }
    
    //MARK: - Interface Outlets
    @IBOutlet var usernameText: UITextField!
    @IBOutlet var passwordText: UITextField! // FIXME: EMAIL TEXT FIELD
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var credentialView: UIView!
    
 
    //MARK: - Set Up Views
    func setUpViews(){
        loginButton.layer.cornerRadius = 15
        credentialView.layer.cornerRadius = 15
        passwordText.isSecureTextEntry = true
        loginButton.layer.shadowColor = UIColor.black.cgColor
        loginButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        loginButton.layer.shadowRadius = 5
        loginButton.layer.shadowOpacity = 1.0
        
    }
    
   
   @IBAction func unwind( _ seg: UIStoryboardSegue) {
       
   }
    
    //MARK: - Set Up Login Animation
    func animateLogin() {
        UIView.animate(withDuration: 0.2, animations: {               //45 degree rotation. USE RADIANS
            self.loginButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 0.1).concatenating(CGAffineTransform(scaleX: 0.8, y: 0.8))
                
            }) { (_) in //Is finished
                
                
                UIView.animate(withDuration: 0.01, animations: {
                    self.loginButton.transform = .identity
                })
                                
            }
    }

    //MARK: - Set Up User Log In
    func handleLogIn() {
         
         guard let email = usernameText.text, let password = passwordText.text else { return }
         
         Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
             if let error = error {
                 
                self.showAlert()
                 print("Error signing in: \(error)")
                 return
             }
             
             self.performSegue(withIdentifier: "LogInSegue", sender: self)
         }
         
     }
    
    //MARK: - Alert
    func showAlert(){
            
        SCLAlertView().showError("Wrong Email or Password", subTitle: "Try Again!")
            
        }
    
    
    //MARK: - Interface Actions
    @IBAction func noAccountButtonTapped(_ sender: Any) {
    }
    
    
    @IBAction func fogotPasswordTapped(_ sender: Any) {
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        animateLogin()
        handleLogIn()
    }
    
}
