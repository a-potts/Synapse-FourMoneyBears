//
//  SaverBearGameTwoViewController.swift
//  FourMoneyBears
//
//  Created by Austin Potts on 7/9/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import SCLAlertView

class SaverBearGameTwoViewController: UIViewController {
    
    @IBOutlet var orangeStatus: UIView!
    @IBOutlet var statusBar: UIView!
    @IBOutlet var checkAnswerButton: UIButton!
    @IBOutlet var choiceViewOne: UIView!
    @IBOutlet var choiceViewTwo: UIView!
    @IBOutlet var choiceViewThree: UIView!
    @IBOutlet var choiceViewFour: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpMiscViews()
        setUpAnswerViews()
    }
    
    func setUpMiscViews(){
           checkAnswerButton.layer.cornerRadius = 15
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
    
    @IBAction func answerViewTwoTapped(_ sender: Any) {
         SCLAlertView().showError("Wrong Answer", subTitle: "Try Again!")
    }
    
    
    @IBAction func answerViewOneTapped(_ sender: Any) {
        SCLAlertView().showError("Wrong Answer", subTitle: "Try Again!")
    }
    @IBAction func answerViewThreeTapped(_ sender: Any) {
        SCLAlertView().showError("Wrong Answer", subTitle: "Try Again!")
    }
    
    @IBAction func answerViewFourTapped(_ sender: Any) {
        SCLAlertView().showSuccess("Good Job!", subTitle: "Next")
                     DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                         self.performSegue(withIdentifier: "CorrectAnswerThreeSegue", sender: self)
                     }
                  animateStatusBar()
    }
    
    
 

}
