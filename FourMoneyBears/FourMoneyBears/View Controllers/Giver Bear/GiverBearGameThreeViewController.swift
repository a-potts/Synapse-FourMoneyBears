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

      //Outlets
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
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpMiscViews()
        setUpAnswerViews()
        let uid = Auth.auth().currentUser?.uid
        
        Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                self.userHealthLabel.text = dictionary["health"] as? String
            }
            print(snapshot)
        }, withCancel: nil)

         }
         
         func setUpMiscViews(){
             orangeStatus.layer.cornerRadius = 9
             whiteStatus.layer.cornerRadius = 9
             checkAnswerButton.layer.cornerRadius = 20
             
         }
         
         func setUpAnswerViews(){
             answerView.layer.cornerRadius = 5
             choiceViewOne.layer.cornerRadius = 5
             choiceViewTwo.layer.cornerRadius = 5
             choiceViewThree.layer.cornerRadius = 5
             choiceViewFour.layer.cornerRadius = 5
             choiceViewFive.layer.cornerRadius = 5
         }
         
         func animateStatusBar(){
               UIView.animate(withDuration: 2, animations: {
                    // self.orangeStatus.frame.origin.x -= 70
                   self.orangeStatus.translatesAutoresizingMaskIntoConstraints = false
                   self.orangeStatus.layer.frame.size.width += 73
                   
                  
                 })
           }
         
         

      //Actions
         
         @IBAction func xTapped(_ sender: Any) {
             self.performSegue(withIdentifier: "unwindSegue", sender: nil)
         }
         
         
         @IBAction func checkAnswerTapped(_ sender: Any) {
             if choiceViewFive.frame.intersects(answerView.frame){
                SCLAlertView().showSuccess("Good Job!", subTitle: "Next")
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.performSegue(withIdentifier: "correctAnswerThreeSegue", sender: self)
                }
                 animateStatusBar()
                 } else {
                     SCLAlertView().showError("Wrong Answer", subTitle: "Try Again!")
                 }
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
         
     }
