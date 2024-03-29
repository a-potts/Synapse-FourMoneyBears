//
//  GiverBearGameThreeViewController.swift
//  FourMoneyBears
//
//  Created by Austin Potts on 7/12/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import SCLAlertView
import Firebase

class GiverBearGameThreeViewController: UIViewController {

    //MARK: - Interface Outlets
    @IBOutlet var orangeStatus: UIView!
    @IBOutlet var answerView: UIView!
    @IBOutlet var choiceViewOne: UIView!
    @IBOutlet var choiceViewTwo: UIView!
    @IBOutlet var choiceViewThree: UIView!
    @IBOutlet var choiceViewFour: UIView!
    @IBOutlet var choiceViewFive: UIView!
    @IBOutlet var checkAnswerButton: UIButton!
    @IBOutlet var userHealthLabel: UILabel!
    @IBOutlet var whiteStatus: UIView!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpMiscViews()
        setUpAnswerViews()
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
       
       //MARK: - Decrement User Health
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
         
         //MARK: - Set Up Views
         func setUpMiscViews(){
             orangeStatus.layer.cornerRadius = 9
             whiteStatus.layer.cornerRadius = 9
             checkAnswerButton.layer.cornerRadius = 20
             
         }
         
         //MARK: - Set Up Answer Views
         func setUpAnswerViews(){
             answerView.layer.cornerRadius = 5
             choiceViewOne.layer.cornerRadius = 5
             choiceViewTwo.layer.cornerRadius = 5
             choiceViewThree.layer.cornerRadius = 5
             choiceViewFour.layer.cornerRadius = 5
             choiceViewFive.layer.cornerRadius = 5
         }
         
        //MARK: - Set Up Status Bar Animation
         func animateStatusBar(){
               UIView.animate(withDuration: 2, animations: {
                    // self.orangeStatus.frame.origin.x -= 70
                   self.orangeStatus.translatesAutoresizingMaskIntoConstraints = false
                   self.orangeStatus.layer.frame.size.width += 73
                   
                 })
           }
         
   
         //MARK: - Exit Game
         @IBAction func xTapped(_ sender: Any) {
             self.performSegue(withIdentifier: "unwindSegue", sender: nil)
         }
         
         //MARK: - Interface Actions
         @IBAction func checkAnswerTapped(_ sender: Any) {
             if choiceViewFive.frame.intersects(answerView.frame){
                SCLAlertView().showSuccess("Good Job!", subTitle: "Next")
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.performSegue(withIdentifier: "correctAnswerThreeSegue", sender: self)
                }
                 animateStatusBar()
                 } else {
                     decHealthUser()
                 }
         }
         
             @IBAction func panView(_ sender: UIPanGestureRecognizer) {
                 let translation = sender.translation(in: self.view)

                 if let viewToDrag = sender.view {
                     viewToDrag.center = CGPoint(x: viewToDrag.center.x + translation.x,
                         y: viewToDrag.center.y + translation.y)
                     sender.setTranslation(CGPoint(x: 0, y: 0), in: viewToDrag)
                     
                 }
             }
         
     }
