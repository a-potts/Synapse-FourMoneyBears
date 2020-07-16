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
    
    @IBOutlet var userRankLabel: UILabel!
    
    @IBOutlet var userRankImage: UIImageView!
    
    @IBOutlet var userHealthLabel: UILabel!
    
    @IBOutlet var streakLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - Check if user is singed in FIXME
//        if Auth.auth().currentUser?.uid == nil {
//            handleLogout()
//           // self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
//        }

        let uid = Auth.auth().currentUser?.uid
       
        Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                self.userRankLabel.text = dictionary["rank"] as? String
                self.streakLabel.text = dictionary["streak"] as? String
                self.userHealthLabel.text = dictionary["health"] as? String
            }
            print(snapshot)
        }, withCancel: nil)
        
       setUpViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
          let uid = Auth.auth().currentUser?.uid
             
              Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                  
                  if let dictionary = snapshot.value as? [String: AnyObject] {
                      self.userRankLabel.text = dictionary["rank"] as? String
                      self.streakLabel.text = dictionary["streak"] as? String
                      self.userHealthLabel.text = dictionary["health"] as? String
                  }
                  print(snapshot)
              }, withCancel: nil)
    }
    
    
    //MARK: - Rank Set Up -
    // Step 1. We need to fetch the Current User. (CHECK)
    // Step 2. Fetch Current User Rank (CHECK)
    // Step 3. Diplay Rank in Rank Label (CHECK)
    // Step 4. On the last Game, after winning, Rank += 10
    private var authUser : User? {
           return Auth.auth().currentUser
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
    
    //MARK: - Bear Animations
    func animateSpenderBear() {
        UIView.animate(withDuration:0.5, animations: {               //45 degree rotation. USE RADIANS
            self.spenderBear.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 0.1).concatenating(CGAffineTransform(scaleX: 1.2, y: 1.2))
            
        }) { (_) in //Is finished
            
            
            UIView.animate(withDuration: 0.3, animations: {
                self.spenderBear.transform = .identity
            })
            
            
        }
    }
    
    func animateSaverBear() {
        UIView.animate(withDuration: 0.5, animations: {               //45 degree rotation. USE RADIANS
            self.saverBear.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 0.1).concatenating(CGAffineTransform(scaleX: 1.2, y: 1.2))
            
        }) { (_) in //Is finished
            
            
            UIView.animate(withDuration: 0.3, animations: {
                self.saverBear.transform = .identity
            })
            
            
        }
    }
    
    func animateInvestorBear(){
        UIView.animate(withDuration: 0.5, animations: {               //45 degree rotation. USE RADIANS
            self.investorBear.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 0.1).concatenating(CGAffineTransform(scaleX: 1.2, y: 1.2))
            
        }) { (_) in //Is finished
            
            
            UIView.animate(withDuration: 0.3, animations: {
                self.investorBear.transform = .identity
            })
            
            
        }
    }
    
    func animateGiverBear(){
         UIView.animate(withDuration: 0.5, animations: {               //45 degree rotation. USE RADIANS
             self.giverBear.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 0.1).concatenating(CGAffineTransform(scaleX: 1.2, y: 1.2))
             
         }) { (_) in //Is finished
             
             
             UIView.animate(withDuration: 0.3, animations: {
                 self.giverBear.transform = .identity
             })
             
             
         }
     }
    

    @IBAction func unwind( _ seg: UIStoryboardSegue) {
        
    }
    
   
    @IBAction func basicsTapped(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.performSegue(withIdentifier: "BasicsSegue", sender: nil)
        }
    }
    
    @IBAction func spenderBearTapped(_ sender: Any) {
        animateSpenderBear()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.performSegue(withIdentifier: "SpenderBearSegue", sender: nil)
        }
    }
    
    @IBAction func saverBearTapped(_ sender: Any) {
        animateSaverBear()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.performSegue(withIdentifier: "SaverBearSegue", sender: nil)
        }
        
    }
    
    @IBAction func investorBearTapped(_ sender: Any) {
        animateInvestorBear()
               DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                   self.performSegue(withIdentifier: "investorBearSegue", sender: nil)
               }
    }
    
    @IBAction func giverBearTapped(_ sender: Any) {
        animateGiverBear()
                     DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                         self.performSegue(withIdentifier: "GiverBearSegue", sender: nil)
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
