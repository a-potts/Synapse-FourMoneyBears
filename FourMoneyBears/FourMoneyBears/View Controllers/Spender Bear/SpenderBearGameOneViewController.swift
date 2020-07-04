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
    
    var viewOrigin: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpMiscViews()
        setUpAnswerViews()
        viewOrigin = choiceViewOne.frame.origin
        viewOrigin = choiceViewTwo.frame.origin
        viewOrigin = choiceViewThree.frame.origin
        viewOrigin = choiceViewFour.frame.origin
        
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
    
    
    @IBAction func checkAnswerTapped(_ sender: Any) {
        // Need to find out if viewFour is the view selected
        // If so, correct answer else wrong
        if choiceViewFour.frame.intersects(answerView.frame){
            showCorrectAlert()
        } else {
            showCorrectAlert()
        }
    }
    
    //MARK: - ALERT
          func showCorrectAlert(){
              
              
              
          let alert = UIAlertController(title: "That's Correct!", message: "You should only spend 20 percent of your savings.", preferredStyle: .alert)
            
          // alert.addAction(UIAlertAction(title: "Next", style: .destructive, handler: nil))
            
            
            alert.addAction(UIAlertAction(title: "Yay", style: .default, handler: { (action) in
                self.performSegue(withIdentifier: "CorrectAnswerSegue", sender: self)
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

}
