//
//  GiverBearStoryPrepThreeViewController.swift
//  FourMoneyBears
//
//  Created by Austin Potts on 7/31/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class GiverBearStoryPrepThreeViewController: UIViewController {

    //MARK: - Interface Outlets
    @IBOutlet var mamaBearText: UITextView!
    @IBOutlet var kidBearText: UITextView!
    @IBOutlet var seeNextExampleButton: UIButton!
    @IBOutlet var mamaBearBubble1: UIView!
    @IBOutlet var mamaBearBubble2: UIView!
    @IBOutlet var kidBearBubble1: UIView!
    @IBOutlet var kidBearBubble2: UIView!
    
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMiscViews()
        mamaBearText.isHidden = true
        kidBearText.isHidden = true
        mamaBearBubble1.isHidden = true
        mamaBearBubble2.isHidden = true
        kidBearBubble1.isHidden = true
        kidBearBubble2.isHidden = true
        
        setUpBubbleViews()
        animateText()
    }
    
    //MARK: Set Up for Views
    func setUpMiscViews(){
        mamaBearText.layer.cornerRadius = 20
        kidBearText.layer.cornerRadius = 20
        seeNextExampleButton.layer.cornerRadius = 20
        seeNextExampleButton.layer.shadowColor = UIColor.black.cgColor
        seeNextExampleButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        seeNextExampleButton.layer.shadowRadius = 5
        seeNextExampleButton.layer.shadowOpacity = 1.0
    }
    
    
    //MARK: Set Up Text Bubbles
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
    
    
    //MARK: - Animate Text Bubbles
    func animateText() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            self.kidBearBubble1.isHidden = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            self.kidBearBubble2.isHidden = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.9) {
            self.mamaBearBubble1.isHidden = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.7) {
            self.mamaBearBubble2.isHidden = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.kidBearText.isHidden = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.mamaBearText.isHidden = false
        }
     }
    
}
