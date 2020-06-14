//
//  RegisterViewController.swift
//  FourMoneyBears
//
//  Created by Austin Potts on 6/6/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

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
            
            
            
            if let uploadData = self.userImage.image?.pngData() {
                
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
    
    
    
    
    private func registerUserIntoDatabaseWithUID(uid: String, values: [String: AnyObject]) {
        // Successfully Registered Value
        var ref: DatabaseReference!
        
        ref = Database.database().reference(fromURL: "https://fourbears-63cd1.firebaseio.com/")
        
        let userRef = ref.child("users").child(uid)
        
        //             let values = ["name": name, "email": email, "profileImageURL": metadata.downloadURL()]
        
        userRef.updateChildValues(values) { (error, refer) in
            if let error = error {
                print("ERROR CHILD values: \(error)")
                return
            }
            
            self.performSegue(withIdentifier: "RegisterSegue", sender: self)
            print("Saved user successfully into firebase db")
        }
    }
    
    func showAlert(){
               
           let alert = UIAlertController(title: "Your Account has been created!", message: "Plase Sign In", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               present(alert, animated: true)
               
           }
    
    
    //MARK: - Actions
    
    
    @IBAction func registerTapped(_ sender: Any) {
        showAlert()
        handleRegister()
    }
    
    @IBAction func cameraButtonTapped(_ sender: Any) {
         let picker = UIImagePickerController()
                   picker.allowsEditing = false
                   picker.delegate = self
                   picker.sourceType = .photoLibrary
                   present(picker, animated: true)
     }
    
    

}


extension RegisterViewController {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: true)
            guard let image = info[.originalImage] as? UIImage else {
                return
            }
            
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 227, height: 227), true, 2.0)
            image.draw(in: CGRect(x: 0, y: 0, width: 414, height: 326))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            
            let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
            var pixelBuffer : CVPixelBuffer?
            let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(newImage.size.width), Int(newImage.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
            guard (status == kCVReturnSuccess) else {
                return
            }
            
            CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
            let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)
            
            let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
            let context = CGContext(data: pixelData, width: Int(newImage.size.width), height: Int(newImage.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue) //3
            
            context?.translateBy(x: 0, y: newImage.size.height)
            context?.scaleBy(x: 1.0, y: -1.0)
            
            UIGraphicsPushContext(context!)
            newImage.draw(in: CGRect(x: 0, y: 0, width: newImage.size.width, height: newImage.size.height))
            UIGraphicsPopContext()
            CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
            userImage.image = newImage
    
             
        }
    
    
    
    
}
