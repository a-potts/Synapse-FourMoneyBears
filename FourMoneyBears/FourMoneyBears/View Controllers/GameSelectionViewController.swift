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
        if Auth.auth().currentUser?.uid == nil {
            handleLogout()
           // self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        }

       setUpViews()
    }
    
    
    func setUpViews() {
        basicsView.contentMode = .scaleAspectFill
        basicsView.layer.cornerRadius = basicsView.frame.height / 2
        basicsView.layer.masksToBounds = false
        basicsView.clipsToBounds = true
        
        spenderBear.contentMode = .scaleAspectFill
        spenderBear.layer.cornerRadius = spenderBear.frame.height / 2
        spenderBear.layer.masksToBounds = false
        spenderBear.clipsToBounds = true
        
        saverBear.contentMode = .scaleAspectFill
        saverBear.layer.cornerRadius = saverBear.frame.height / 2
        saverBear.layer.masksToBounds = false
        saverBear.clipsToBounds = true
        
        investorBear.contentMode = .scaleAspectFill
        investorBear.layer.cornerRadius = investorBear.frame.height / 2
        investorBear.layer.masksToBounds = false
        investorBear.clipsToBounds = true
        
        giverBear.contentMode = .scaleAspectFill
        giverBear.layer.cornerRadius = basicsView.frame.height / 2
        giverBear.layer.masksToBounds = false
        giverBear.clipsToBounds = true
        
        
        
    }
    
    
    
    
// MARK: - Log Out Function (FIXME: Create Hamburger Menu to Hide)
    @IBAction func logoutTapped(_ sender: Any) {
        handleLogout()
        
    }
    
    func handleLogout(){
        do {
            try Auth.auth().signOut()
        } catch let logoutError{
            print(logoutError)
        }
        
        //  let loginController = LoginViewController()
        
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }


}
