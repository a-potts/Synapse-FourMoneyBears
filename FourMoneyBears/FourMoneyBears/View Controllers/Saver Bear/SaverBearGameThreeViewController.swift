//
//  SaverBearGameThreeViewController.swift
//  FourMoneyBears
//
//  Created by Austin Potts on 7/9/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import SCLAlertView

class SaverBearGameThreeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMiscViews()

    }
    
    @IBOutlet var orangeStatus: UIView!
    @IBOutlet var statusBar: UIView!
    @IBOutlet var checkAnswerButton: UIButton!
    @IBOutlet var yesButton: UIButton!
    @IBOutlet var noButton: UIButton!

    
    
    func setUpMiscViews() {
          statusBar.layer.cornerRadius = 9
          orangeStatus.layer.cornerRadius = 9
          yesButton.layer.cornerRadius = 20
          noButton.layer.cornerRadius = 20
          checkAnswerButton.layer.cornerRadius = 15
      }
      
      func animateStatusBar(){
            UIView.animate(withDuration: 2, animations: {
                 // self.orangeStatus.frame.origin.x -= 70
                self.orangeStatus.translatesAutoresizingMaskIntoConstraints = false
                self.orangeStatus.layer.frame.size.width += 73
                
               
              })
        }
    
    @IBAction func yesTapped(_ sender: Any) {
        SCLAlertView().showSuccess("Good Job!", subTitle: "Next")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.performSegue(withIdentifier: "CorrectAnswerThree", sender: self)
        }
        animateStatusBar()
    }
    
    @IBAction func noTapped(_ sender: Any) {
        SCLAlertView().showError("Wrong Answer", subTitle: "Try Again!")
    }
    
    

    @IBAction func checkAnswerTapped(_ sender: Any) {
        
       
    }
    
    @IBAction func xTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindSegue", sender: nil)
    }
    
    
    
    
}
