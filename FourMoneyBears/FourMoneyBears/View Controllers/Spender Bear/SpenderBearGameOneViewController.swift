//
//  SpenderBearGameOneViewController.swift
//  FourMoneyBears
//
//  Created by Austin Potts on 6/21/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import SCLAlertView
import Firebase

class SpenderBearGameOneViewController: UIViewController {
    
    @IBOutlet var statusBar: UIView!
    @IBOutlet var orangeStatus: UIView!
    @IBOutlet var answerView: UIView!
    @IBOutlet var choiceViewOne: UIView!
    @IBOutlet var choiceViewTwo: UIView!
    @IBOutlet var choiceViewThree: UIView!
    @IBOutlet var choiceViewFour: UIView!
    @IBOutlet var checkAnswerButton: UIButton!
    @IBOutlet var userHealthLabel: UILabel!
    
    var viewOrigin: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpMiscViews()
        setUpAnswerViews()
        viewOrigin = choiceViewOne.frame.origin
        viewOrigin = choiceViewTwo.frame.origin
        viewOrigin = choiceViewThree.frame.origin
        viewOrigin = choiceViewFour.frame.origin
        
       fetchUser()
        
    }
    //MARK: - Health Timer
    func healthTimer(){
    let duration: TimeInterval = 100 * 60
        let timer = Timer.scheduledTimer(withTimeInterval: duration, repeats: false, block: { timer in
             
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
       
    
    @IBAction func xTapped(_ sender: Any) {
           
           self.performSegue(withIdentifier: "unwindSegue", sender: nil)
           
       }
    
    func setUpMiscViews() {
        statusBar.layer.cornerRadius = 8
        orangeStatus.layer.cornerRadius = 8
        checkAnswerButton.layer.cornerRadius = 20
    }
    
    
    func setUpAnswerViews() {
        
        answerView.layer.cornerRadius = 5
        choiceViewOne.layer.cornerRadius = 5
        choiceViewTwo.layer.cornerRadius = 5
        choiceViewThree.layer.cornerRadius = 5
        choiceViewFour.layer.cornerRadius = 5
        
    }
    
    @IBAction func panView(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.view)

        if let viewToDrag = sender.view {
            viewToDrag.center = CGPoint(x: viewToDrag.center.x + translation.x,
                y: viewToDrag.center.y + translation.y)
            sender.setTranslation(CGPoint(x: 0, y: 0), in: viewToDrag)
            
//            switch sender.state {
//            case .began, .changed:
//                choiceViewOne.center = CGPoint(x: choiceViewOne.center.x + translation.x, y: choiceViewOne.center.y + translation.y)
//                sender.setTranslation(CGPoint.zero, in: view)
//                break
//            case .ended:
//                if choiceViewOne.frame.intersects(answerView.frame) {
//
//                    UIView.animate(withDuration: 0.3) {
//
//                    }
//                }
//
//            default:
//                break
//            }
        }
    }
    
    func animateStatusBar(){
          UIView.animate(withDuration: 2, animations: {
               // self.orangeStatus.frame.origin.x -= 70
              self.orangeStatus.translatesAutoresizingMaskIntoConstraints = false
              self.orangeStatus.layer.frame.size.width += 67
              
             
            })
      }
    
    
    @IBAction func checkAnswerTapped(_ sender: Any) {
        // Need to find out if viewFour is the view selected
        // If so, correct answer else wrong
        if choiceViewOne.frame.intersects(answerView.frame){
              SCLAlertView().showSuccess("Good Job!", subTitle: "Next")
                  DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                      self.performSegue(withIdentifier: "CorrectAnswerSegue", sender: self)
                  }
                 animateStatusBar()
        } else {
            decHealthUser()
            SCLAlertView().showError("Wrong Answer", subTitle: "Try Again!")
        }
    }
    
    //MARK: - ALERT
          func showCorrectAlert(){
              
              
              
          let alert = UIAlertController(title: "That's Correct!", message: "You should only spend 20 percent of your savings.", preferredStyle: .alert)
            
          // alert.addAction(UIAlertAction(title: "Next", style: .destructive, handler: nil))
            
            
            alert.addAction(UIAlertAction(title: "Yay", style: .default, handler: { (action) in
                self.performSegue(withIdentifier: "CorrectAnswerSegue", sender: self)
            }))
            
            present(alert, animated: true)
            
           let subview = (alert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
           subview.layer.cornerRadius = 1
           subview.backgroundColor = UIColor.green
           
           
           
              
          }
    
    func showWrongAlert(){
             
             
             
         let alert = UIAlertController(title: "That's Inorrect!", message: "You should only spend 20 percent of your savings.", preferredStyle: .alert)
           
          alert.addAction(UIAlertAction(title: "Next", style: .destructive, handler: nil))
             present(alert, animated: true)
          let subview = (alert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
          subview.layer.cornerRadius = 1
          subview.backgroundColor = UIColor.red
             
         }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
