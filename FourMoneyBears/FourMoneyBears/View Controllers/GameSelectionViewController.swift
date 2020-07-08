//
//  GameSelectionViewController.swift
//  FourMoneyBears
//
//  Created by Austin Potts on 4/8/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import Firebase

class GameSelectionViewController: UIViewController {

    @IBOutlet var basicsView: UIView!
    
    // Money Bears
    
    @IBOutlet var spenderBear: UIImageView!
    
    @IBOutlet var saverBear: UIImageView!
    
    @IBOutlet var investorBear: UIImageView!
    
    @IBOutlet var giverBear: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - Check if user is singed in FIXME
//        if Auth.auth().currentUser?.uid == nil {
//            handleLogout()
//           // self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
//        }

       setUpViews()
    }
    
    
    func setUpViews() {
        basicsView.contentMode = .scaleAspectFill
        basicsView.layer.cornerRadius = basicsView.frame.height / 2
        basicsView.layer.masksToBounds = false
        basicsView.clipsToBounds = true
        basicsView.layer.borderWidth = 1
        basicsView.layer.borderColor = UIColor.black.cgColor
        
        
        //Bears
        spenderBear.contentMode = .scaleAspectFill
        spenderBear.layer.cornerRadius = spenderBear.frame.height / 2
        spenderBear.layer.masksToBounds = false
        spenderBear.clipsToBounds = true
        spenderBear.layer.borderWidth = 1
        spenderBear.layer.borderColor = UIColor.black.cgColor
        
        saverBear.contentMode = .scaleAspectFill
        saverBear.layer.cornerRadius = saverBear.frame.height / 2
        saverBear.layer.masksToBounds = false
        saverBear.clipsToBounds = true
        saverBear.layer.borderWidth = 1
        saverBear.layer.borderColor = UIColor.black.cgColor
        
        investorBear.contentMode = .scaleAspectFill
        investorBear.layer.cornerRadius = investorBear.frame.height / 2
        investorBear.layer.masksToBounds = false
        investorBear.clipsToBounds = true
        investorBear.layer.borderWidth = 1
        investorBear.layer.borderColor = UIColor.black.cgColor
        
        giverBear.contentMode = .scaleAspectFill
        giverBear.layer.cornerRadius = basicsView.frame.height / 2
        giverBear.layer.masksToBounds = false
        giverBear.clipsToBounds = true
        giverBear.layer.borderWidth = 1
        giverBear.layer.borderColor = UIColor.black.cgColor
        
        
        
        
    }
    
    func animateBear() {
        UIView.animate(withDuration: 1, animations: {               //45 degree rotation. USE RADIANS
            self.spenderBear.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 0.1).concatenating(CGAffineTransform(scaleX: 1.2, y: 1.2))
                
            }) { (_) in //Is finished
                
                
                UIView.animate(withDuration: 1, animations: {
                    self.spenderBear.transform = .identity
                })
                
                
            }
    }
    
    
    @IBAction func spenderBearTapped(_ sender: Any) {
        animateBear()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.performSegue(withIdentifier: "SpenderBearSegue", sender: nil)
        }
    }
    
    @IBAction func saverBearTapped(_ sender: Any) {
        animateBear()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.performSegue(withIdentifier: "SaverBearSegue", sender: nil)
        }
        
    }
    
    
    
    
    
// MARK: - Log Out Function (FIXME: Create Hamburger Menu to Hide)
//    @IBAction func logoutTapped(_ sender: Any) {
//        handleLogout()
//
//    }
    
//    func handleLogout(){
//        do {
//            try Auth.auth().signOut()
//        } catch let logoutError{
//            print(logoutError)
//        }
//
//        //  let loginController = LoginViewController()
//
//        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
//    }


}
