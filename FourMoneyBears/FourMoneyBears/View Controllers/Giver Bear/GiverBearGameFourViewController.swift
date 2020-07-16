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

    
    @IBOutlet var answerView1: UIView!
    @IBOutlet var answerView2: UIView!
    @IBOutlet var answerView3: UIView!
    @IBOutlet var answerView4: UIView!
    @IBOutlet var statusBar: UIView!
    @IBOutlet var orangeStatus: UIView!
    @IBOutlet var userHealthLabel: UILabel!
    
        override func viewDidLoad() {
            super.viewDidLoad()
            updateAnswerViews()
            let uid = Auth.auth().currentUser?.uid
            
            Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    self.userHealthLabel.text = dictionary["health"] as? String
                }
                print(snapshot)
            }, withCancel: nil)
        }
        
    
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
        
        
        // MARK: - Navigation
        
        // In a storyboard-based application, you will often want to do a little preparation before navigation
        //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        if segue.identifier == "CorrectAnswerOneSegue" {
        //            if let detailVC = segue.destination as? SpenderBearGameOneViewController {
        //
        //            }
        //        }
        //    }
        
        @IBAction func xTapped(_ sender: Any) {
            
            self.performSegue(withIdentifier: "unwindSegue", sender: nil)
            
        }
        
        func animateStatusBar(){
            UIView.animate(withDuration: 2, animations: {
                // self.orangeStatus.frame.origin.x -= 70
                self.orangeStatus.translatesAutoresizingMaskIntoConstraints = false
                self.orangeStatus.layer.frame.size.width += 15
                
                
            })
        }
        
        
        @IBAction func answerView1Tapped(_ sender: Any) {
            
           SCLAlertView().showError("Wrong Answer", subTitle: "Try Again!")
        
        }
        
        
        //MARK: - ALERT
        func showCorrectAlert(){
            
            
            
            let alert = UIAlertController(title: "That's Correct!", message: "You should only spend 20 percent of your savings.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Yay", style: .default, handler: { (action) in
                self.performSegue(withIdentifier: "CorrectAnswerTwoSegue", sender: self)
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
        
        @IBAction func answerView2Tapped(_ sender: Any) {
            let alertViewResponder: SCLAlertViewResponder = SCLAlertView().showCustom("Good job, You won!", subTitle: "Reward: 10xp", color: UIColor.white, icon: UIImage(named: "Crown-fill.png")!)
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4){
                alertViewResponder.close()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.performSegue(withIdentifier: "unwindSegue", sender: self)
                self.updateData()
                
            }
            animateStatusBar()
                   
            
        }
        
        
        @IBAction func answerView3Tapped(_ sender: Any) {
            SCLAlertView().showError("Wrong Answer", subTitle: "Try Again!")
        }
        
        
        @IBAction func answerView4Tapped(_ sender: Any) {
            SCLAlertView().showError("Wrong Answer", subTitle: "Try Again!")
        }
        
        
    }
