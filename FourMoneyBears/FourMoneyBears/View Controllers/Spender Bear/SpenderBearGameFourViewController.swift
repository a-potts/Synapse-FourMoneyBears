//
//  SpenderBearGameFourViewController.swift
//  FourMoneyBears
//
//  Created by Austin Potts on 7/4/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import SCLAlertView

class SpenderBearGameFourViewController: UIViewController {
    
    @IBOutlet var statusBar: UIView!
    @IBOutlet var orangeStatus: UIView!
    @IBOutlet var yesButton: UIButton!
    @IBOutlet var noButton: UIButton!
    @IBOutlet var checkAnswerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpMiscViews()
    }
    
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
              self.orangeStatus.layer.frame.size.width += 15
              
             
            })
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
    
    
    @IBAction func checkAnswerTapped(_ sender: Any) {
        
    }
    
    @IBAction func yesTapped(_ sender: Any) {
       SCLAlertView().showError("Wrong Answer", subTitle: "Try Again!")
    }
    
    @IBAction func noTapped(_ sender: Any) {
         SCLAlertView().showCustom("Congrats!", subTitle: "You won!", color: UIColor.white, icon: UIImage(systemName: "flame.fill")!)
        
        
        
        animateStatusBar()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.performSegue(withIdentifier: "unwindSegue", sender: self)
            
        }
        
    }
    
}
