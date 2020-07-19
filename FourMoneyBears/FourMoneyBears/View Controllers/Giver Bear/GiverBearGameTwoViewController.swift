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
        let uid = Auth.auth().currentUser?.uid
        
        Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                self.userHealthLabel.text = dictionary["health"] as? String
            }
            print(snapshot)
        }, withCancel: nil)
        
        audioPlayer()
        
    }
    
    @IBOutlet var orangeStatus: UIView!
    @IBOutlet var statusBar: UIView!
    @IBOutlet var yesButton: UIButton!
    @IBOutlet var noButton: UIButton!
    @IBOutlet var userHealthLabel: UILabel!
    @IBOutlet var audioPlayerView: UIView!
    
    var player: AVAudioPlayer = AVAudioPlayer()
    
           
           
           func setUpMiscViews() {
                 statusBar.layer.cornerRadius = 9
                 orangeStatus.layer.cornerRadius = 9
                 yesButton.layer.cornerRadius = 20
                 noButton.layer.cornerRadius = 20
            audioPlayerView.layer.cornerRadius = 20
                 
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
               SCLAlertView().showError("Wrong Answer", subTitle: "Try Again!")
           }
           
           

           
           @IBAction func xTapped(_ sender: Any) {
               self.performSegue(withIdentifier: "unwindSegue", sender: nil)
           }

    }
