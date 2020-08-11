//
//  SaverBearGameTwoViewController.swift
//  FourMoneyBears
//
//  Created by Austin Potts on 7/9/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import SCLAlertView
import Firebase

class SaverBearGameTwoViewController: UIViewController {
    
    @IBOutlet var orangeStatus: UIView!
    @IBOutlet var statusBar: UIView!
  
    @IBOutlet var choiceViewOne: UIView!
    @IBOutlet var choiceViewTwo: UIView!
    @IBOutlet var choiceViewThree: UIView!
    @IBOutlet var choiceViewFour: UIView!
    @IBOutlet var userHealthLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpMiscViews()
        setUpAnswerViews()
        fetchUser()
    }
    
    //MARK: - Health Timer
    func healthTimer(){
    let duration: TimeInterval = 100 * 60
        let timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false, block: { timer in
             
           self.addHealthUser()
        
           print("FIRE!!!")
        })
    }
    
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
                        // print("Health HERE: \(values)")
                        guard let uid = Auth.auth().currentUser?.uid else { return }
                        self.createCopyForUserHealth(uid: uid,values: values as [String : AnyObject])
                        
                        
                    }
                }
            }
            
            
        }, withCancel: nil)
    }
    
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
                           // print("Health HERE: \(values)")
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
                       
                       print("NEW HEALTH::: \(newHealth)")
                       
                       let values = ["health": "\(newHealth)"]
                            // print("Health HERE: \(values)")
                       guard let uid = Auth.auth().currentUser?.uid else { return }
                       self.createCopyForUserHealth(uid: uid,values: values as [String : AnyObject])
                       }
                   }
               }
               
               
           }, withCancel: nil)
       }
       

        
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
    
    func setUpMiscViews(){
           
           statusBar.layer.cornerRadius = 9
           orangeStatus.layer.cornerRadius = 9
       }
       
       func setUpAnswerViews(){
           choiceViewOne.layer.cornerRadius = 15
           choiceViewTwo.layer.cornerRadius = 15
           choiceViewThree.layer.cornerRadius = 15
           choiceViewFour.layer.cornerRadius = 15
       }
    
    func animateStatusBar(){
        UIView.animate(withDuration: 2, animations: {
             // self.orangeStatus.frame.origin.x -= 70
            self.orangeStatus.translatesAutoresizingMaskIntoConstraints = false
            self.orangeStatus.layer.frame.size.width += 67
            
           
          })
    }
    
    @IBAction func xTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindSegue", sender: nil)
    }
    
    @IBAction func answerViewTwoTapped(_ sender: Any) {
         decHealthUser()
         SCLAlertView().showError("Wrong Answer", subTitle: "Try Again!")
    }
    
    
    @IBAction func answerViewOneTapped(_ sender: Any) {
        decHealthUser()
        SCLAlertView().showError("Wrong Answer", subTitle: "Try Again!")
    }
    @IBAction func answerViewThreeTapped(_ sender: Any) {
        decHealthUser()
        SCLAlertView().showError("Wrong Answer", subTitle: "Try Again!")
    }
    
    @IBAction func answerViewFourTapped(_ sender: Any) {
        SCLAlertView().showSuccess("Good Job!", subTitle: "Next")
                     DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                         self.performSegue(withIdentifier: "CorrectAnswerTwo", sender: self)
                     }
                  animateStatusBar()
    }
    
    
 

}
