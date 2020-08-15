//
//  GiverBearGameFourViewController.swift
//  FourMoneyBears
//
//  Created by Austin Potts on 7/12/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import SCLAlertView
import Firebase

class GiverBearGameFourViewController: UIViewController {

    //MARK: - Interface Outlets
    @IBOutlet var answerView1: UIView!
    @IBOutlet var answerView2: UIView!
    @IBOutlet var answerView3: UIView!
    @IBOutlet var answerView4: UIView!
    @IBOutlet var statusBar: UIView!
    @IBOutlet var orangeStatus: UIView!
    @IBOutlet var userHealthLabel: UILabel!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateAnswerViews()
        fetchUser()
    }
    
    //MARK: - Health Timer
    func healthTimer(){
    let duration: TimeInterval = 60 * 60
        let timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: false, block: { timer in
             
           self.addHealthUser()
        })
    }
    
    //MARK: - Add Health To User
    func addHealthUser(){
        var users = [Users]()
        let uid = Auth.auth().currentUser?.uid
        
        Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                self.userHealthLabel.text = dictionary["health"] as? String
                let user = Users()
                              
                user.setValuesForKeys(dictionary)
                users.append(user)
                
                for user in users {
                    let health = Int(user.health ?? "") ?? 0
                    
                    if health == 0 {
                        
                        let values = ["health": "\(health + 3)"]
                        guard let uid = Auth.auth().currentUser?.uid else { return }
                        self.createCopyForUserHealth(uid: uid,values: values as [String : AnyObject])
                        
                    }
                }
            }
        
        }, withCancel: nil)
    }
    
    //MARK: - Fetch User From Database
    func fetchUser(){
           var users = [Users]()
           let uid = Auth.auth().currentUser?.uid
           
           Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
               
               if let dictionary = snapshot.value as? [String: AnyObject] {
                   self.userHealthLabel.text = dictionary["health"] as? String
                   let user = Users()
                                 
                   user.setValuesForKeys(dictionary)
                   users.append(user)
               }
               
           }, withCancel: nil)
       }
       
       //MARK: - Decrement Users Health
       func decHealthUser(){
           var users = [Users]()
           let uid = Auth.auth().currentUser?.uid
           
           Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
               
               if let dictionary = snapshot.value as? [String: AnyObject] {
                   self.userHealthLabel.text = dictionary["health"] as? String
                   let user = Users()
                                 
                   user.setValuesForKeys(dictionary)
                   users.append(user)
                   
                   for user in users {
                       let health = Int(user.health ?? "") ?? 0
                       
                       if health - 1 == 0 {
                           
                           let values = ["health": "\(health - 1)"]
                           self.userHealthLabel.text = "\(0)"
                           guard let uid = Auth.auth().currentUser?.uid else { return }
                           self.createCopyForUserHealth(uid: uid,values: values as [String : AnyObject])
                           
                           self.healthTimer()
                        
                           SCLAlertView().showError("Out of Health", subTitle: "You must wait 24 hours for more Health")
                           DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                               self.performSegue(withIdentifier: "unwindSegue", sender: nil)
                           }
                           
                       } else if health > 0 {
                       
                       let newHealth = health - 1
                       
                       self.userHealthLabel.text = "\(newHealth)"
                       
                       SCLAlertView().showError("Wrong Answer", subTitle: "Try Again!")
                        
                       print("NEW HEALTH::: \(newHealth)")
                       
                       let values = ["health": "\(newHealth)"]
                       guard let uid = Auth.auth().currentUser?.uid else { return }
                       self.createCopyForUserHealth(uid: uid,values: values as [String : AnyObject])
                       }
                   }
               }
               
               
           }, withCancel: nil)
       }
       

        //MARK: - Create Values For User
        func createCopyForUserHealth(uid: String, values: [String: AnyObject]) {
            var ref: DatabaseReference!
                
                ref = Database.database().reference(fromURL: "https://fourbears-63cd1.firebaseio.com/")
                
                let userRef = ref.child("users").child(uid)
                
                userRef.updateChildValues(values) { (error, refer) in
                    if let error = error {
                        print("ERROR CHILD values: \(error)")
                        return
                    }
              }
        }
        
    
    
    //MARK:- Update Users Rank
    func updateData(){
         guard let uid = Auth.auth().currentUser?.uid else { return }
         
         var userRank = 40
         
         let values = ["rank": "\(userRank)"]
         
         self.createCopyForUserRank(uid: uid,values: values as [String : AnyObject])
     }
         
    func createCopyForUserRank(uid: String, values: [String: AnyObject]) {
        var ref: DatabaseReference!
            
            ref = Database.database().reference(fromURL: "https://fourbears-63cd1.firebaseio.com/")
            
            let userRef = ref.child("users").child(uid)
            
           
            
            userRef.updateChildValues(values) { (error, refer) in
                if let error = error {
                    print("ERROR CHILD values: \(error)")
                    return
                }
         }
    }
        
        //MARK: - Set Up Answer Views
        func updateAnswerViews() {
            
            // View Corner Radius
            answerView1.layer.cornerRadius = 20
            answerView2.layer.cornerRadius = 20
            answerView3.layer.cornerRadius = 20
            answerView4.layer.cornerRadius = 20
            
            // View Borders
            answerView1.layer.borderWidth = 5
            answerView1.layer.borderColor = UIColor.gray.cgColor
            answerView2.layer.borderWidth = 5
            answerView2.layer.borderColor = UIColor.gray.cgColor
            answerView3.layer.borderWidth = 5
            answerView3.layer.borderColor = UIColor.gray.cgColor
            answerView4.layer.borderWidth = 5
            answerView4.layer.borderColor = UIColor.gray.cgColor
            
            statusBar.layer.cornerRadius = 9
            orangeStatus.layer.cornerRadius = 9
            
        }
        
        
        //MARK: - Exit Game
        @IBAction func xTapped(_ sender: Any) {
            
            self.performSegue(withIdentifier: "unwindSegue", sender: nil)
            
        }
        
        //MARK: - Set Up Status Bar Animation
        func animateStatusBar(){
            UIView.animate(withDuration: 2, animations: {
                self.orangeStatus.translatesAutoresizingMaskIntoConstraints = false
                self.orangeStatus.layer.frame.size.width += 15
            })
        }
        
        //MARK: - Interface Actions
        @IBAction func answerView1Tapped(_ sender: Any) {
          decHealthUser()
        
        }
        
                
        @IBAction func answerView2Tapped(_ sender: Any) {
            let alertViewResponder: SCLAlertViewResponder = SCLAlertView().showCustom("Good job, you won!", subTitle: "Reward: 10 Crowns", color: UIColor.white, icon: UIImage(named: "Crown-fill.png")!)
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4){
                alertViewResponder.close()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.performSegue(withIdentifier: "unwindSegue", sender: self)
                self.updateData()
                NotificationCenter.default.post(name: .onDidReceiveDataGiver, object: nil)
                                   
            }
            animateStatusBar()
        }
        
        
        @IBAction func answerView3Tapped(_ sender: Any) {
            decHealthUser()
        }
        
        
        @IBAction func answerView4Tapped(_ sender: Any) {
            decHealthUser()
        }
        
        
    }
