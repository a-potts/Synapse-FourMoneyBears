//
//  SaverBearGameOneViewController.swift
//  FourMoneyBears
//
//  Created by Austin Potts on 7/7/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class SaverBearGameOneViewController: UIViewController {
    
    //Outlets
    @IBOutlet var orangeStatus: UIView!
    @IBOutlet var answerView: UIView!
    @IBOutlet var choiceViewOne: UIView!
    @IBOutlet var choiceViewTwo: UIView!
    @IBOutlet var choiceViewThree: UIView!
    @IBOutlet var choiceViewFour: UIView!
    @IBOutlet var choiceViewFive: UIView!
    @IBOutlet var checkAnswerButton: UIButton!
    
    @IBOutlet var whiteStatus: UIView!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpMiscViews()
        setUpAnswerViews()

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
    
    
    

 //Actions
    
    @IBAction func xTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func checkAnswerTapped(_ sender: Any) {
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
