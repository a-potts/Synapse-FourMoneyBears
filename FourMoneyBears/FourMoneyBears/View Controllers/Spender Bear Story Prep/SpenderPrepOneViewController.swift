//
//  SpenderPrepOneViewController.swift
//  FourMoneyBears
//
//  Created by Austin Potts on 7/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class SpenderPrepOneViewController: UIViewController {

    //MARK: - Interface Outlets
    @IBOutlet var seeExampleButton: UIButton!
    @IBOutlet var hintText: UITextView!
    @IBOutlet var mamaBearText: UITextView!
    @IBOutlet var kidBearText: UITextView!
    @IBOutlet var mamaBearBubble1: UIView!
    @IBOutlet var mamaBearBubble2: UIView!
    @IBOutlet var kidBearBubble1: UIView!
    @IBOutlet var kidBearBubble2: UIView!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpMiscViews()
        animateTextBear()
        setUpBubbleViews()
    }
    
    //MARK: - Set Up Views
    func setUpMiscViews() {
        mamaBearText.layer.cornerRadius = 20
        kidBearText.layer.cornerRadius = 20
        seeExampleButton.layer.cornerRadius = 20
        seeExampleButton.layer.shadowColor = UIColor.black.cgColor
        seeExampleButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        seeExampleButton.layer.shadowRadius = 5
        seeExampleButton.layer.shadowOpacity = 1.0
    }
    
    //MARK: - Set Up Bubble Views
    func setUpBubbleViews(){
          self.mamaBearBubble1.layer.cornerRadius = self.mamaBearBubble1.frame.height / 2
          self.mamaBearBubble1.layer.masksToBounds = false
          self.mamaBearBubble1.clipsToBounds = true
          
          self.kidBearBubble1.layer.cornerRadius = self.kidBearBubble1.frame.height / 2
          self.kidBearBubble1.layer.masksToBounds = false
          self.kidBearBubble1.clipsToBounds = true
          
          self.mamaBearBubble2.layer.cornerRadius = self.mamaBearBubble2.frame.height / 2
          self.mamaBearBubble2.layer.masksToBounds = false
          self.mamaBearBubble2.clipsToBounds = true
          
          self.kidBearBubble2.layer.cornerRadius = self.kidBearBubble2.frame.height / 2
          self.kidBearBubble2.layer.masksToBounds = false
          self.kidBearBubble2.clipsToBounds = true
          
          
      }
    
    //MARK: - Set Up Text Bubble Animations
    func animateTextBear() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            self.mamaBearBubble1.isHidden = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            self.mamaBearBubble2.isHidden = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.9) {
            self.kidBearBubble1.isHidden = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.7) {
            self.kidBearBubble2.isHidden = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.mamaBearText.isHidden = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.kidBearText.isHidden = false
        }
    }

    //MARK: - Animate Text
    func animateText() {
        UIView.animate(withDuration:0.5, animations: {       
            self.hintText.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 0.1).concatenating(CGAffineTransform(scaleX: 1.2, y: 1.2))
            
        }) { (_) in //Is finished
            
            UIView.animate(withDuration: 0.3, animations: {
                self.hintText.transform = .identity
            })
        }
    }

}
