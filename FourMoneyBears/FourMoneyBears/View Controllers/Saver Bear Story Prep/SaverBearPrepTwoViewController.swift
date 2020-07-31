//
//  SaverBearPrepTwoViewController.swift
//  FourMoneyBears
//
//  Created by Austin Potts on 7/30/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class SaverBearPrepTwoViewController: UIViewController {

    
    @IBOutlet var seeExampleButton: UIButton!
    @IBOutlet var saveBearText: UITextView!
    @IBOutlet var textBubbleOne: UIView!
    @IBOutlet var textBubbleTwo: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animateText()
        setUpMiscViews()
        setUpBubbleViews()
        saveBearText.isHidden = true
        textBubbleOne.isHidden = true
        textBubbleTwo.isHidden = true

    }
    
    func setUpMiscViews(){
        seeExampleButton.layer.cornerRadius = 20
        saveBearText.layer.cornerRadius = 20
        seeExampleButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        seeExampleButton.layer.shadowRadius = 5
        seeExampleButton.layer.shadowOpacity = 1.0
        
    }
    
    func animateText() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            self.textBubbleOne.isHidden = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            self.textBubbleTwo.isHidden = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.saveBearText.isHidden = false
        }
        
    }
    
    func setUpBubbleViews(){
          self.textBubbleOne.layer.cornerRadius = self.textBubbleOne.frame.height / 2
          self.textBubbleOne.layer.masksToBounds = false
          self.textBubbleOne.clipsToBounds = true
        
          
          self.textBubbleTwo.layer.cornerRadius = self.textBubbleTwo.frame.height / 2
          self.textBubbleTwo.layer.masksToBounds = false
          self.textBubbleTwo.clipsToBounds = true
        
      }

}
