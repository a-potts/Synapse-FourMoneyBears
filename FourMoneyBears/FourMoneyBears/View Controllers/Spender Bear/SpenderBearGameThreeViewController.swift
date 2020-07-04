//
//  SpenderBearGameTwoViewController.swift
//  FourMoneyBears
//
//  Created by Austin Potts on 7/2/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class SpenderBearGameThreeViewController: UIViewController {
    
    
    @IBOutlet var checkAnswer: UIButton!
    @IBOutlet var answerViewOne: UIView!
    @IBOutlet var answerViewTwo: UIView!
    @IBOutlet var answerViewThree: UIView!
    @IBOutlet var answerViewFour: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpMiscViews()
        setUpAnswerViews()
    }
    
    func setUpMiscViews(){
        checkAnswer.layer.cornerRadius = 15
    }
    
    func setUpAnswerViews(){
        answerViewOne.layer.cornerRadius = 15
        answerViewTwo.layer.cornerRadius = 15
        answerViewThree.layer.cornerRadius = 15
        answerViewFour.layer.cornerRadius = 15
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
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func checkAnswerTapped(_ sender: Any) {
    }
    
    
    @IBAction func answerViewTwoTapped(_ sender: Any) {
        showCorrectAlert()
    }
    
}