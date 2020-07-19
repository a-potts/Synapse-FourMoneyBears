//
//  SpenderBearGameTwoViewController.swift
//  FourMoneyBears
//
//  Created by Austin Potts on 7/2/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import SCLAlertView
import Firebase

class SpenderBearGameThreeViewController: UIViewController {
    
    
   
    @IBOutlet var answerViewOne: UIView!
    @IBOutlet var answerViewTwo: UIView!
    @IBOutlet var answerViewThree: UIView!
    @IBOutlet var answerViewFour: UIView!
    @IBOutlet var statusBar: UIView!
     @IBOutlet var orangeStatus: UIView!
    @IBOutlet var userHealthLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
       
        statusBar.layer.cornerRadius = 9
        orangeStatus.layer.cornerRadius = 9
    }
    
    func setUpAnswerViews(){
        answerViewOne.layer.cornerRadius = 15
        answerViewTwo.layer.cornerRadius = 15
        answerViewThree.layer.cornerRadius = 15
        answerViewFour.layer.cornerRadius = 15
    }
    
    func animateStatusBar(){
          UIView.animate(withDuration: 2, animations: {
               // self.orangeStatus.frame.origin.x -= 70
              self.orangeStatus.translatesAutoresizingMaskIntoConstraints = false
              self.orangeStatus.layer.frame.size.width += 73
              
             
            })
      }
    
    //MARK: - ALERT
    func showCorrectAlert(){
        
        
        
        let alert = UIAlertController(title: "That's Correct!", message: "You should only spend 20 percent of your savings.", preferredStyle: .alert)
        
        // alert.addAction(UIAlertAction(title: "Next", style: .destructive, handler: nil))
        
        
        alert.addAction(UIAlertAction(title: "Yay", style: .default, handler: { (action) in
            self.performSegue(withIdentifier: "CorrectAnswerThreeSegue", sender: self)
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
    @IBAction func xTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindSegue", sender: nil)
    }
    
  
    
    
    @IBAction func answerViewTwoTapped(_ sender: Any) {
          SCLAlertView().showSuccess("Good Job!", subTitle: "Next")
              DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                  self.performSegue(withIdentifier: "CorrectAnswerThreeSegue", sender: self)
              }
           animateStatusBar()
    }
    
    
    @IBAction func answerViewOneTapped(_ sender: Any) {
        SCLAlertView().showError("Wrong Answer", subTitle: "Try Again!")
    }
    @IBAction func answerViewThreeTapped(_ sender: Any) {
        SCLAlertView().showError("Wrong Answer", subTitle: "Try Again!")
    }
    
    @IBAction func answerViewFourTapped(_ sender: Any) {
        SCLAlertView().showError("Wrong Answer", subTitle: "Try Again!")
    }
}
