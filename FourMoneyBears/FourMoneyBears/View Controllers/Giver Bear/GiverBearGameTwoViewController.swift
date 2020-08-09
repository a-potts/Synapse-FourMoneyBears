//
//  GiverBearGameTwoViewController.swift
//  FourMoneyBears
//
//  Created by Austin Potts on 7/12/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import SCLAlertView
import Firebase
import AVFoundation

class GiverBearGameTwoViewController: UIViewController {

   
       override func viewDidLoad() {
               super.viewDidLoad()
        setUpMiscViews()
        fetchUser()
        
        audioPlayer()
        
    }
    
    
    
    @IBOutlet var orangeStatus: UIView!
    @IBOutlet var statusBar: UIView!
    @IBOutlet var yesButton: UIButton!
    @IBOutlet var noButton: UIButton!
    @IBOutlet var userHealthLabel: UILabel!
    @IBOutlet var audioPlayerView: UIView!
    @IBOutlet var giverBearImage: UIImageView!
    
    var player: AVAudioPlayer = AVAudioPlayer()
    
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
                           // print("Health HERE: \(values)")
                           guard let uid = Auth.auth().currentUser?.uid else { return }
                           self.createCopyForUserHealth(uid: uid,values: values as [String : AnyObject])
                           
                           SCLAlertView().showError("Out of Health", subTitle: "You must wait 24 hours for more Health")
                           DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                               self.performSegue(withIdentifier: "unwindSegue", sender: nil)
                           }
                           
                       } else if health > 0 {
                       
                       let newHealth = health - 1
                       
                       
                       
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
    
           
           
           func setUpMiscViews() {
                 statusBar.layer.cornerRadius = 9
                 orangeStatus.layer.cornerRadius = 9
                 yesButton.layer.cornerRadius = 20
                 noButton.layer.cornerRadius = 20
            audioPlayerView.layer.cornerRadius = 20
            giverBearImage.layer.cornerRadius = 50
                 
             }
             
             func animateStatusBar(){
                   UIView.animate(withDuration: 2, animations: {
                        // self.orangeStatus.frame.origin.x -= 70
                       self.orangeStatus.translatesAutoresizingMaskIntoConstraints = false
                       self.orangeStatus.layer.frame.size.width += 67
                       
                      
                     })
               }
    
    func audioPlayer(){
               
               do {
                   let audioPath = Bundle.main.path(forResource: "sniper", ofType: "mp3")
                   try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
               } catch {
                   
               }
               
           }
         
         @IBAction func playButtonTapped(_ sender: Any) {
             player.play()
         }
           
           @IBAction func yesTapped(_ sender: Any) {
               SCLAlertView().showSuccess("Good Job!", subTitle: "Next")
               DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                   self.performSegue(withIdentifier: "correctAnswerTwo", sender: self)
               }
               animateStatusBar()
           }
           
           @IBAction func noTapped(_ sender: Any) {
               decHealthUser()
               SCLAlertView().showError("Wrong Answer", subTitle: "Try Again!")
           }
           
           

           
           @IBAction func xTapped(_ sender: Any) {
               self.performSegue(withIdentifier: "unwindSegue", sender: nil)
           }

    }
