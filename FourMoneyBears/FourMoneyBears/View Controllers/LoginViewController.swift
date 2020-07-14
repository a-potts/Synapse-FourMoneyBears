//
//  LoginViewController.swift
//  FourMoneyBears
//
//  Created by Austin Potts on 6/6/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import Firebase
import EMTNeumorphicView
import SCLAlertView

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViews()
        neumorhpicButton()
      
    
        
    }
    
    @IBOutlet var usernameText: UITextField!
    @IBOutlet var passwordText: UITextField! // FIXME: EMAIL TEXT FIELD
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var credentialView: UIView!
    
 
    
    func setUpViews(){
        loginButton.layer.cornerRadius = 15
        credentialView.layer.cornerRadius = 15
        passwordText.isSecureTextEntry = true
        
    }
    
   @IBAction func unwind( _ seg: UIStoryboardSegue) {
       
   }
    
    func animateLogin() {
        UIView.animate(withDuration: 0.5, animations: {               //45 degree rotation. USE RADIANS
                self.loginButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 0.1).concatenating(CGAffineTransform(scaleX: 1.2, y: 1.2))
                
            }) { (_) in //Is finished
                
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.loginButton.transform = .identity
                })
                
                
            }
    }
    
    // MARK: - FIXME: 
    func neumorhpicButton() {
        //let button = EMTNeumorphicButton(type: .custom)
        let button = EMTNeumorphicButton(type: loginButton.buttonType)
        //loginButton.addSubview(button)
           button.setImage(UIImage(named: "heart-outline"), for: .normal)
           button.setImage(UIImage(named: "heart-solid"), for: .selected)
           button.contentVerticalAlignment = .fill
           button.contentHorizontalAlignment = .fill
           button.imageEdgeInsets = UIEdgeInsets(top: 126, left: 124, bottom: 122, right: 124)
           button.addTarget(self, action: #selector(tapped(_:)), for: .touchUpInside)
           button.translatesAutoresizingMaskIntoConstraints = false
           
           button.neumorphicLayer?.elementBackgroundColor = view.backgroundColor?.cgColor as! CGColor
        
        
    }
    @objc func tapped(_ button: EMTNeumorphicButton) {
        // isSelected property changes neumorphicLayer?.depthType automatically
        button.isSelected = !button.isSelected
    }
    
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
    
    func showAlert(){
            
        SCLAlertView().showError("Wrong Email or Password", subTitle: "Try Again!")
            
        }
    
    
    
    @IBAction func noAccountButtonTapped(_ sender: Any) {
    }
    
    
    @IBAction func fogotPasswordTapped(_ sender: Any) {
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        animateLogin()
        handleLogIn()
    }
    
}
