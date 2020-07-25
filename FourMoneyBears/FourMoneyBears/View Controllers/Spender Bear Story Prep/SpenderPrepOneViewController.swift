//
//  SpenderPrepOneViewController.swift
//  FourMoneyBears
//
//  Created by Austin Potts on 7/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class SpenderPrepOneViewController: UIViewController {

    
    
    @IBOutlet var seeExampleButton: UIButton!
    
    @IBOutlet var hintText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpMiscViews()
    }
    
    func setUpMiscViews() {
        seeExampleButton.layer.cornerRadius = 20
    }
    

    func animateText() {
        UIView.animate(withDuration:0.5, animations: {               //45 degree rotation. USE RADIANS
            self.hintText.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 0.1).concatenating(CGAffineTransform(scaleX: 1.2, y: 1.2))
            
        }) { (_) in //Is finished
            
            
            UIView.animate(withDuration: 0.3, animations: {
                self.hintText.transform = .identity
            })
            
            
        }
    }


}
