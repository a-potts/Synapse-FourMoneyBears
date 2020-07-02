//
//  SpenderBearGameOneViewController.swift
//  FourMoneyBears
//
//  Created by Austin Potts on 6/21/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class SpenderBearGameOneViewController: UIViewController {
    
    @IBOutlet var statusBar: UIView!
    @IBOutlet var orangeStatus: UIView!
    @IBOutlet var answerView: UIView!
    @IBOutlet var choiceViewOne: UIView!
    @IBOutlet var choiceViewTwo: UIView!
    @IBOutlet var choiceViewThree: UIView!
    @IBOutlet var choiceViewFour: UIView!
    @IBOutlet var checkAnswerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpMiscViews()
        setUpAnswerViews()
    }
    
    @IBAction func xTapped(_ sender: Any) {
           
           self.dismiss(animated: true, completion: nil)
           
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
    
    
    @IBAction func checkAnswerTapped(_ sender: Any) {
        
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
