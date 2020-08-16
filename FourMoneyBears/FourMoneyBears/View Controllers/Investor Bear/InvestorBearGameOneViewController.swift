//
//  InvestorBearGameOneViewController.swift
//  FourMoneyBears
//
//  Created by Austin Potts on 7/10/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import SCLAlertView
import Firebase
import AVFoundation

class InvestorBearGameOneViewController: UIViewController {

    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMiscViews()
        fetchUser()
        audioPlayer()
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
                            // print("Health HERE: \(values)")
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
    //MARK: - Interface Outlets
    @IBOutlet var orangeStatus: UIView!
    @IBOutlet var statusBar: UIView!
    @IBOutlet var yesButton: UIButton!
    @IBOutlet var noButton: UIButton!
    @IBOutlet var audioPlayerView: UIView!
    @IBOutlet var investorBearImage: UIImageView!
    @IBOutlet var userHealthLabel: UILabel!
    
    //MARK: - Property
    var player: AVAudioPlayer = AVAudioPlayer()
       
    //MARK: - Set Up Views
    func setUpMiscViews() {
        statusBar.layer.cornerRadius = 9
        orangeStatus.layer.cornerRadius = 9
        yesButton.layer.cornerRadius = 20
        noButton.layer.cornerRadius = 20
        audioPlayerView.layer.cornerRadius = 20
        investorBearImage.layer.cornerRadius = 50
    }
         
    //MARK: - Set Up Status Bar Animation
    func animateStatusBar(){
        UIView.animate(withDuration: 2, animations: {
            self.orangeStatus.translatesAutoresizingMaskIntoConstraints = false
            self.orangeStatus.layer.frame.size.width += 46
        })
    }
    
    //MARK: - Audio Player
    func audioPlayer(){
            do {
                let audioPath = Bundle.main.path(forResource: "InvestorBear", ofType: "mp3")
                try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            } catch {
                
            }
            
        }
      
      //MARK: - Interface Actions
      @IBAction func playButtonTapped(_ sender: Any) {
          player.play()
      }
       
       @IBAction func yesTapped(_ sender: Any) {
           SCLAlertView().showSuccess("Good Job!", subTitle: "Next")
           DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
               self.performSegue(withIdentifier: "answerOneSegue", sender: self)
           }
           animateStatusBar()
       }
       
       @IBAction func noTapped(_ sender: Any) {
           decHealthUser()  
       }
       
       @IBAction func xTapped(_ sender: Any) {
           self.performSegue(withIdentifier: "unwindSegue", sender: nil)
       }

}
