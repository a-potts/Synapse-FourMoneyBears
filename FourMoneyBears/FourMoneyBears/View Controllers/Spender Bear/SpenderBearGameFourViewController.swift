//
//  SpenderBearGameFourViewController.swift
//  FourMoneyBears
//
//  Created by Austin Potts on 7/4/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class SpenderBearGameFourViewController: UIViewController {
    
    @IBOutlet var statusBar: UIView!
    @IBOutlet var orangeStatus: UIView!
    @IBOutlet var yesButton: UIButton!
    @IBOutlet var noButton: UIButton!
    @IBOutlet var checkAnswerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpMiscViews()
    }
    
    func setUpMiscViews() {
        statusBar.layer.cornerRadius = 9
        orangeStatus.layer.cornerRadius = 9
        yesButton.layer.cornerRadius = 20
        noButton.layer.cornerRadius = 20
        checkAnswerButton.layer.cornerRadius = 15
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
    
    @IBAction func yesTapped(_ sender: Any) {
    }
    
    @IBAction func noTapped(_ sender: Any) {
    }
    
}
