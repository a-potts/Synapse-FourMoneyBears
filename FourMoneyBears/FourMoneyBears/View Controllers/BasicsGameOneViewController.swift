//
//  BasicsGameOneViewController.swift
//  FourMoneyBears
//
//  Created by Austin Potts on 7/13/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BasicsGameOneViewController: UIViewController {

    
    
   
    @IBOutlet var moneyOne: UIImageView!
    @IBOutlet var moneyTwo: UIImageView!
    @IBOutlet var piggyBankView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
     @IBAction func handlePanView(_ sender: UIPanGestureRecognizer) {
            let translation = sender.translation(in: self.view)

            if let viewToDrag = sender.view {
                viewToDrag.center = CGPoint(x: viewToDrag.center.x + translation.x,
                    y: viewToDrag.center.y + translation.y)
                sender.setTranslation(CGPoint(x: 0, y: 0), in: viewToDrag)
                
   
            }
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
