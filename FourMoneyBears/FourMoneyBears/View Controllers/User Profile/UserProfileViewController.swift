//
//  UserProfileViewController.swift
//  FourMoneyBears
//
//  Created by Austin Potts on 7/18/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import Firebase
import Macaw

class UserProfileViewController: UIViewController {
    
    
    @IBOutlet var usersImage: UIImageView!
    @IBOutlet var imageViewCircle: UIView!
    @IBOutlet var usersName: UILabel!
    @IBOutlet var usersAge: UILabel!
    @IBOutlet var userRankLabel: UILabel!
    @IBOutlet var userStreakLabel: UILabel!
    @IBOutlet var usersHealthLabel: UILabel!
    @IBOutlet var usersEmail: UILabel!
    @IBOutlet var macawChart: MacawChartView!
    @IBOutlet var rankView: UIView!
    @IBOutlet var healthView: UIView!
    @IBOutlet var streakView: UIView!
    
     var users: Users? {
           didSet {
               updateViews()
           }
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        macawChart.contentMode = .scaleAspectFit
        macawChart.layer.cornerRadius = 20
        MacawChartView.playAnimations()
        
        
        macawChart.layer.shadowOffset = CGSize(width: 2, height: 2)
        macawChart.layer.shadowRadius = 2
        macawChart.layer.shadowOpacity = 1.0
        
        rankView.layer.cornerRadius = 20
        healthView.layer.cornerRadius = 20
        streakView.layer.cornerRadius = 20
        
        rankView.layer.shadowOffset = CGSize(width: 3, height: 3)
        rankView.layer.shadowRadius = 3
        rankView.layer.shadowOpacity = 1.0
        
        healthView.layer.shadowOffset = CGSize(width: 3, height: 3)
        healthView.layer.shadowRadius = 3
        healthView.layer.shadowOpacity = 1.0
        
        streakView.layer.shadowOffset = CGSize(width: 3, height: 3)
        streakView.layer.shadowRadius = 3
        streakView.layer.shadowOpacity = 1.0
        
        imageViewCircle.layer.cornerRadius = imageViewCircle.frame.height / 2
        imageViewCircle.layer.masksToBounds = false
        imageViewCircle.clipsToBounds = true
        


        
        
          
    }
    
    
    func updateViews(){
        let uid = Auth.auth().currentUser?.uid

          Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            
                  
                  if let dictionary = snapshot.value as? [String: AnyObject] {
                    self.userRankLabel.text = dictionary["rank"] as? String
                    self.userStreakLabel.text = dictionary["streak"] as? String
                    self.usersHealthLabel.text = dictionary["health"] as? String
                    self.usersName.text = dictionary["name"] as? String
                    self.usersEmail.text = dictionary["email"] as? String
                    self.usersAge.text = dictionary["age"] as? String
                    let profileImageURL = dictionary["profileImageURL"] as? String
                    self.usersImage.loadImageViewUsingCacheWithUrlString(urlString: profileImageURL!)
                    self.usersImage.layer.cornerRadius = self.usersImage.frame.height / 2
                    self.usersImage.layer.masksToBounds = false
                    self.usersImage.clipsToBounds = true
                  }
                  print(snapshot)
              }, withCancel: nil)
        
      
                    
//        usersImage.loadImageViewUsingCacheWithUrlString(urlString: profileImageURL)
                    
                    //            let url = URL(string: profileImageUrl)
                    //
                    //            URLSession.shared.dataTask(with: url!) { (data, response, error) in
                    //
                    //                if let error = error {
                    //                    print("Error getting image: \(error)")
                    //                    return
                    //                }
                    //
                    //                DispatchQueue.main.async {
                    //                     cell.imageView?.image = UIImage(data: data!)
                    //                }
                    //
                    //
                    //            }.resume()
                    
                
    }
    
    
    
    @IBAction func xTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
   //MARK: -  Macaw Graph
    

}
