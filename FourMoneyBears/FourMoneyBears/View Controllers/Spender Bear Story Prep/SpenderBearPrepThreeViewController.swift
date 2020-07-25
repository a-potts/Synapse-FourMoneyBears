//
//  SpenderBearPrepThreeViewController.swift
//  FourMoneyBears
//
//  Created by Austin Potts on 7/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class SpenderBearPrepThreeViewController: UIViewController {

        
        
        @IBOutlet var blueBearText: UITextView!
        @IBOutlet var spenderBearText: UITextView!
        @IBOutlet var readyButton: UIButton!
        
        @IBOutlet var blueBearBubble1: UIView!
        @IBOutlet var blueBearBubble2: UIView!
        @IBOutlet var spenderBubble1: UIView!
        @IBOutlet var spenderBubble2: UIView!
        
        
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
           setUpMiscViews()
            blueBearText.isHidden = true
            spenderBearText.isHidden = true
            
            blueBearBubble1.isHidden = true
            blueBearBubble2.isHidden = true
            spenderBubble1.isHidden = true
            spenderBubble2.isHidden = true
            
            
            setUpBubbleViews()
            animateText()
        }
        
        func setUpMiscViews(){
            blueBearText.layer.cornerRadius = 20
            spenderBearText.layer.cornerRadius = 20
            readyButton.layer.cornerRadius = 20
            readyButton.layer.shadowColor = UIColor.black.cgColor
            readyButton.layer.shadowOffset = CGSize(width: 5, height: 5)
            readyButton.layer.shadowRadius = 5
            readyButton.layer.shadowOpacity = 1.0
        }

        func setUpBubbleViews(){
            self.blueBearBubble1.layer.cornerRadius = self.blueBearBubble1.frame.height / 2
            self.blueBearBubble1.layer.masksToBounds = false
            self.blueBearBubble1.clipsToBounds = true
            
            self.spenderBubble1.layer.cornerRadius = self.spenderBubble1.frame.height / 2
            self.spenderBubble1.layer.masksToBounds = false
            self.spenderBubble1.clipsToBounds = true
            
            self.blueBearBubble2.layer.cornerRadius = self.blueBearBubble2.frame.height / 2
            self.blueBearBubble2.layer.masksToBounds = false
            self.blueBearBubble2.clipsToBounds = true
            
            self.spenderBubble2.layer.cornerRadius = self.spenderBubble2.frame.height / 2
            self.spenderBubble2.layer.masksToBounds = false
            self.spenderBubble2.clipsToBounds = true
            
            
        }
        
        
        
        func animateText() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                self.blueBearBubble1.isHidden = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                self.blueBearBubble2.isHidden = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.9) {
                self.spenderBubble1.isHidden = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.7) {
                self.spenderBubble2.isHidden = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                self.blueBearText.isHidden = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.spenderBearText.isHidden = false
            }
        }

    }


