//
//  RegisterViewController.swift
//  FourMoneyBears
//
//  Created by Austin Potts on 6/6/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import Firebase

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
    
    
    
    func handleRegister() {
           
           guard let email = emailText.text, let password = passwordText.text, let name = usernameText.text else { return }
           
           Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
               if let error = error {
                   print("Error: \(error)")
                   return
               }
               
               guard let uid = user?.user.uid else { return }
               
               let imageName = NSUUID().uuidString
               
               let storageRef = Storage.storage().reference().child("\(imageName).png")
               
               
               
               if let uploadData = self.imager.image?.pngData() {
                   
                   storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                       if let error = error {
                           print("Error uploading image data: \(error)")
                           return
                       }
                       
                       storageRef.downloadURL { (url, error) in
                           if let error = error {
                               print("Error downloading URL: \(error)")
                               return
                           }
                           
                           if let profileImageUrl = url?.absoluteString {
                               let values = ["name": name, "email": email, "profileImageURL": profileImageUrl ]
                               
                               self.registerUserIntoDatabaseWithUID(uid: uid, values: values as [String : AnyObject])
                           }
                           
                       }
                      // print(metadata)
                   }
                   
               }
               
           }
       }
    
    

}
