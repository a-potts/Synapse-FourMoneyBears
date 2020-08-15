//
//  GameSelectionViewController.swift
//  FourMoneyBears
//
//  Created by Austin Potts on 4/8/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import Firebase
import SCLAlertView

class GameSelectionViewController: UIViewController {

    @IBOutlet var basicsView: UIView!
    
    // Four Money Bears
    @IBOutlet var spenderBear: UIImageView!
    @IBOutlet var saverBear: UIImageView!
    @IBOutlet var investorBear: UIImageView!
    @IBOutlet var giverBear: UIImageView!
    
    //User Attributes
    @IBOutlet var userRankLabel: UILabel!
    @IBOutlet var userRankImage: UIImageView!
    @IBOutlet var userHealthLabel: UILabel!
    @IBOutlet var streakLabel: UILabel!
    
    // Bear Check Marks if Game Completed
    @IBOutlet var spenderBearCheckMark: UIImageView!
    @IBOutlet var saverBearCheckMark: UIImageView!
    @IBOutlet var investorBearCheckMark: UIImageView!
    @IBOutlet var giverBearCheckMark: UIImageView!
    
    // Bear Buttons To Hide
    @IBOutlet var spenderBearButton: UIButton!
    
    @IBOutlet var saverBearButton: UIButton!
    @IBOutlet var investorBearButton: UIButton!
    @IBOutlet var giverBearButton: UIButton!
    
    //Bear Locks
    @IBOutlet var saverBearLock: UIImageView!
    
    @IBOutlet var giverBearLock: UIImageView!
    @IBOutlet var investorBearLock: UIImageView!
    
    // Custom Tab Bar
    
    @IBOutlet var usersProfileButton: UIButton!
    
    @IBOutlet var leaderboardButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUser()
        
            //Check Bear Locks
        checkSaverBearLocks()
         
    // Bear Check Marks Notifications
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: .didReceiveData, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveDataSaver(_:)), name: .onDidReceiveDataSaver, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveDataGiver(_:)), name: .onDidReceiveDataGiver, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveDataInvestor(_:)), name: .onDidReceiveDataInvestor, object: nil)
        
        let uid = Auth.auth().currentUser?.uid
       
        Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                self.userRankLabel.text = dictionary["rank"] as? String
                self.streakLabel.text = dictionary["streak"] as? String
                self.userHealthLabel.text = dictionary["health"] as? String
            }
            
        }, withCancel: nil)
        
       setUpViews()
    }
    
    
    //MARK: - Health Timer
    func healthTimer(){
        let duration: TimeInterval = 100 * 60
        let timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: false, block: { timer in
             
           self.addHealthUser()
            
            let alertViewResponder: SCLAlertViewResponder = SCLAlertView().showCustom("You have regained health!", subTitle: "Game Restrictions Lifted", color: UIColor.white, icon: UIImage(systemName:"heart.fill")!)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4){
                alertViewResponder.close()
            }
        
           print("FIRE!!!")
        })
    }
    
    func addHealthUser(){
        var users = [Users]()
        let uid = Auth.auth().currentUser?.uid
        
        Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                self.userHealthLabel.text = dictionary["health"] as? String
                let user = Users()
                              
                user.setValuesForKeys(dictionary)
                users.append(user)
                
                for user in users {
                    let health = Int(user.health ?? "") ?? 0
                    
                    if health == 0 {
                        self.userHealthLabel.text = "\(health + 3)"
                        
                        self.fetchUser()
                        
                        let values = ["health": "\(health + 3)"]
    
                        // print("Health HERE: \(values)")
                        guard let uid = Auth.auth().currentUser?.uid else { return }
                        self.createCopyForUserHealth(uid: uid,values: values as [String : AnyObject])
                        
                        
                    }
                    
                    self.spenderBearButton.isHidden = false
                    
                    self.saverBearButton.isHidden = false
                    
                    self.investorBearButton.isHidden = false
                    
                    self.giverBearButton.isHidden = false
                }
            }
            
            
        }, withCancel: nil)
    }
    
    
    func createCopyForUserHealth(uid: String, values: [String: AnyObject]) {
        var ref: DatabaseReference!
            
            ref = Database.database().reference(fromURL: "https://fourbears-63cd1.firebaseio.com/")
            
            let userRef = ref.child("users").child(uid)
            
           
            
            userRef.updateChildValues(values) { (error, refer) in
                if let error = error {
                    print("ERROR CHILD values: \(error)")
                    return
                }
         }
    }

    
    func fetchUser(){
        var users = [Users]()
        let uid = Auth.auth().currentUser?.uid
        
        Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                self.userHealthLabel.text = dictionary["health"] as? String
                let user = Users()
                              
                user.setValuesForKeys(dictionary)
                users.append(user)
                
            }
            
            for user in users {
                let health = Int(user.health ?? "") ?? 0
                if health == 0 {
                    self.healthTimer()
                    
                    self.spenderBearButton.isHidden = true
                    
                    self.saverBearButton.isHidden = true
                
                    self.investorBearButton.isHidden = true
                
                    self.giverBearButton.isHidden = true
                    
                } else if health > 0 {
                  
                    self.spenderBearButton.isHidden = false
                    
                    self.saverBearButton.isHidden = false
                    
                    self.investorBearButton.isHidden = false
                
                    self.giverBearButton.isHidden = false
                }
            }
            
            
        }, withCancel: nil)
    }
    
    
    
    func checkSaverBearLocks() {
        if spenderBearCheckMark.isHidden == true {
            saverBearLock.isHidden = false
            saverBear.layer.opacity = 0.5
            saverBearButton.isHidden = true
            
            investorBearLock.isHidden = false
            investorBear.layer.opacity = 0.5
            investorBearButton.isHidden = true
            
            giverBearLock.isHidden = false
            giverBear.layer.opacity = 0.5
            giverBearButton.isHidden = true
        } else if spenderBearCheckMark.isHidden == false {
            saverBearLock.isHidden = true
            saverBear.layer.opacity = 1
            saverBearButton.isHidden = false
            
            investorBearLock.isHidden = false
            investorBear.layer.opacity = 0.5
            investorBearButton.isHidden = true
            
            giverBearLock.isHidden = false
            giverBear.layer.opacity = 0.5
            giverBearButton.isHidden = true
        }
    }
    
    func checkInvestorBearLock(){
        if saverBearCheckMark.isHidden == false {
            investorBearLock.isHidden = true
            investorBear.layer.opacity = 1
            investorBearButton.isHidden = false
            
            saverBearButton.isHidden = true
            saverBear.layer.opacity = 0.5
        }
    }
    
    func checkGiverBearLock(){
          if investorBearCheckMark.isHidden == false {
              giverBearLock.isHidden = true
              giverBear.layer.opacity = 1
              giverBearButton.isHidden = false
              
              investorBearButton.isHidden = true
              investorBear.layer.opacity = 0.5
          }
      }
    
    func finalLockCheck() {
        if giverBearCheckMark.isHidden == false {
            giverBearButton.isHidden = true
            giverBear.layer.opacity = 0.5
        }
    }
    
    
    
    //MARK:- Actions for Notification Observer
    @objc func onDidReceiveData(_ notification:Notification) {
        spenderBear.layer.opacity = 0.5
        spenderBearCheckMark.isHidden = false
        spenderBearButton.isHidden = true
        
    }
    @objc func onDidReceiveDataSaver(_ notification:Notification) {
        saverBear.layer.opacity = 0.5
        saverBearCheckMark.isHidden = false
        saverBearButton.isHidden = true
    }

    @objc func onDidReceiveDataGiver(_ notification:Notification) {
        giverBear.layer.opacity = 0.5
        giverBearCheckMark.isHidden = false
        giverBearButton.isHidden = true
    }

    @objc func onDidReceiveDataInvestor(_ notification:Notification) {
        investorBear.layer.opacity = 0.5
        investorBearCheckMark.isHidden = false
        investorBearButton.isHidden = true
    }

    
   
    
    //MARK: - View Will Appear needed to Refresh Current Users State
    override func viewWillAppear(_ animated: Bool) {
          let uid = Auth.auth().currentUser?.uid
             
              Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                  
                  if let dictionary = snapshot.value as? [String: AnyObject] {
                      self.userRankLabel.text = dictionary["rank"] as? String
                      self.streakLabel.text = dictionary["streak"] as? String
                      self.userHealthLabel.text = dictionary["health"] as? String
                  }
                 
              }, withCancel: nil)
        
        checkSaverBearLocks()
        checkInvestorBearLock()
        checkGiverBearLock()
        finalLockCheck()
        fetchUser()
    }
    
    
    //MARK: - Rank Set Up -
    // Step 1. We need to fetch the Current User. (CHECK)
    // Step 2. Fetch Current User Rank (CHECK)
    // Step 3. Diplay Rank in Rank Label (CHECK)
    // Step 4. On the last Game, after winning, Rank += 10
//    private var authUser : User? {
//           return Auth.auth().currentUser
//       }
    
      
    
    
    
    
    
    func setUpViews() {
        basicsView.contentMode = .scaleAspectFill
        basicsView.layer.cornerRadius = basicsView.frame.height / 2
        basicsView.layer.masksToBounds = false
        basicsView.clipsToBounds = true
        basicsView.layer.borderWidth = 1
        basicsView.layer.borderColor = UIColor.black.cgColor
        
        
        //Bears
        spenderBear.contentMode = .scaleAspectFill
        spenderBear.layer.cornerRadius = spenderBear.frame.height / 2
        spenderBear.layer.masksToBounds = false
        spenderBear.clipsToBounds = true
        spenderBear.layer.borderWidth = 1
        spenderBear.layer.borderColor = UIColor.black.cgColor
        
        saverBear.contentMode = .scaleAspectFill
        saverBear.layer.cornerRadius = saverBear.frame.height / 2
        saverBear.layer.masksToBounds = false
        saverBear.clipsToBounds = true
        saverBear.layer.borderWidth = 1
        saverBear.layer.borderColor = UIColor.black.cgColor
        
        investorBear.contentMode = .scaleAspectFill
        investorBear.layer.cornerRadius = investorBear.frame.height / 2
        investorBear.layer.masksToBounds = false
        investorBear.clipsToBounds = true
        investorBear.layer.borderWidth = 1
        investorBear.layer.borderColor = UIColor.black.cgColor
        
        giverBear.contentMode = .scaleAspectFill
        giverBear.layer.cornerRadius = basicsView.frame.height / 2
        giverBear.layer.masksToBounds = false
        giverBear.clipsToBounds = true
        giverBear.layer.borderWidth = 1
        giverBear.layer.borderColor = UIColor.black.cgColor
        
        
        
        
    }
    
    //MARK: - Bear Animations
    func animateSpenderBear() {
        UIView.animate(withDuration:0.2, animations: {               //45 degree rotation. USE RADIANS
            self.spenderBear.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 0.1).concatenating(CGAffineTransform(scaleX: 0.8, y: 0.8))
            
        }) { (_) in //Is finished
            
            
            UIView.animate(withDuration: 0.01, animations: {
                self.spenderBear.transform = .identity
            })
            
            
        }
    }
    
    func animateSaverBear() {
        UIView.animate(withDuration: 0.2, animations: {               //45 degree rotation. USE RADIANS
            self.saverBear.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 0.1).concatenating(CGAffineTransform(scaleX: 0.8, y: 0.8))
            
        }) { (_) in //Is finished
            
            
            UIView.animate(withDuration: 0.01, animations: {
                self.saverBear.transform = .identity
            })
            
            
        }
    }
    
    func animateInvestorBear(){
        UIView.animate(withDuration: 0.2, animations: {               //45 degree rotation. USE RADIANS
            self.investorBear.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 0.1).concatenating(CGAffineTransform(scaleX: 0.8, y: 0.8))
            
        }) { (_) in //Is finished
            
            
            UIView.animate(withDuration: 0.01, animations: {
                self.investorBear.transform = .identity
            })
            
            
        }
    }
    
    func animateGiverBear(){
         UIView.animate(withDuration: 0.2, animations: {               //45 degree rotation. USE RADIANS
             self.giverBear.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 0.1).concatenating(CGAffineTransform(scaleX: 0.8, y: 0.8))
             
         }) { (_) in //Is finished
             
             
             UIView.animate(withDuration: 0.01, animations: {
                 self.giverBear.transform = .identity
             })
             
             
         }
     }
    //MARK: - Custom Tab Bar
    
    @IBAction func leaderboardsButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "LeaderboardsSegue", sender: nil)
    }
    
    @IBAction func usersProfileTapped(_ sender: Any) {
        performSegue(withIdentifier: "UserProfileSegue", sender: nil)
    }
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
        
    }
    
   
    @IBAction func basicsTapped(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.performSegue(withIdentifier: "BasicsSegue", sender: nil)
        }
    }
    
    @IBAction func spenderBearTapped(_ sender: Any) {
        animateSpenderBear()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.performSegue(withIdentifier: "SpenderBearSegue", sender: nil)
        }
    }
    
    @IBAction func saverBearTapped(_ sender: Any) {
        animateSaverBear()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.performSegue(withIdentifier: "SaverBearSegue", sender: nil)
        }
        
    }
    
    @IBAction func investorBearTapped(_ sender: Any) {
        animateInvestorBear()
               DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                   self.performSegue(withIdentifier: "investorBearSegue", sender: nil)
               }
    }
    
    @IBAction func giverBearTapped(_ sender: Any) {
        animateGiverBear()
                     DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                         self.performSegue(withIdentifier: "GiverBearSegue", sender: nil)
                     }
    }
    
    
    
    
// MARK: - Log Out Function (FIXME: Create Hamburger Menu to Hide)
//    @IBAction func logoutTapped(_ sender: Any) {
//        handleLogout()
//
//    }
    
//    func handleLogout(){
//        do {
//            try Auth.auth().signOut()
//        } catch let logoutError{
//            print(logoutError)
//        }
//
//        //  let loginController = LoginViewController()
//
//        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
//    }


}

