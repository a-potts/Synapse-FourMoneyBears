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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        statusBar.layer.cornerRadius = 8
        orangeStatus.layer.cornerRadius = 8
    }
    
    @IBAction func xTapped(_ sender: Any) {
           
           self.dismiss(animated: true, completion: nil)
           
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
