//
//  LeaderboardsTableViewController.swift
//  FourMoneyBears
//
//  Created by Austin Potts on 7/18/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import Firebase

class LeaderboardsTableViewController: UITableViewController {
    
    //MARK: - Properties
    var users = [Users]()
    var moreThan = [Users]()

    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

      fetchUsers()

    }

        //MARK: - Fetch User From Database
        func fetchUsers() {
            Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    let user = Users()
                    
                    //App will crash if Class properties don't exactly match up with the Firebase Dictionary Keys
                    user.setValuesForKeys(dictionary)
                    
                    if Int(user.rank ?? "") ?? 0 >= 10 {
                        
                    self.users.append(user)
                        
                    }
    
                    DispatchQueue.main.async {
                         self.tableView.reloadData()
                    }
                }
                print(snapshot)
            }, withCancel: nil)
        }
    

    // MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return  users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "UsersCell", for: indexPath) as? UserTableViewCell else {return UITableViewCell()}
             
        cell.users = users[indexPath.row]
        cell.usersImage.layer.cornerRadius = cell.usersImage.frame.height / 2
        cell.usersImage.layer.masksToBounds = false
        cell.usersImage.clipsToBounds = true
        return cell
    }
    
    //MARK: - Interface Action
    @IBAction func xTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
