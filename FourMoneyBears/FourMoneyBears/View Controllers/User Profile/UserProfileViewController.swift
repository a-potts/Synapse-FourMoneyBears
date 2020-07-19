//
//  UserProfileViewController.swift
//  FourMoneyBears
//
//  Created by Austin Potts on 7/18/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import Firebase

class UserProfileViewController: UIViewController {
    
    
    @IBOutlet var usersImage: UIImageView!
    @IBOutlet var usersName: UILabel!
    @IBOutlet var userRankLabel: UILabel!
    @IBOutlet var userStreakLabel: UILabel!
    @IBOutlet var usersHealthLabel: UILabel!
    
     var users: Users? {
           didSet {
               updateViews()
           }
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
          
    }
    
    
    func updateViews(){
        let uid = Auth.auth().currentUser?.uid

          Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            
                  
                  if let dictionary = snapshot.value as? [String: AnyObject] {
                      self.userRankLabel.text = dictionary["rank"] as? String
                      self.userStreakLabel.text = dictionary["streak"] as? String
                      self.usersHealthLabel.text = dictionary["health"] as? String
                    self.usersName.text = dictionary["name"] as? String
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
