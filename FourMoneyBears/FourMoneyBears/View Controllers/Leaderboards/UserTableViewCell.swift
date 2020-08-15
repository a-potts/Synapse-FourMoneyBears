//
//  UserTableViewCell.swift
//  FourMoneyBears
//
//  Created by Austin Potts on 7/18/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    //MARK: - User Property Observer
    var users: Users? {
        didSet {
            updateViews()
        }
    }
  
    //MARK: - Interface Outlets
    @IBOutlet var usersImage: UIImageView!
    @IBOutlet var usersName: UILabel!
    @IBOutlet var usersRank: UILabel!
    
    //MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK: - Update Views Once Property Is Observed
    func updateViews(){

        usersName.text = users?.name
        usersRank.text = users?.rank
        
        if let profileImageUrl = users!.profileImageURL {
                 
                 usersImage.loadImageViewUsingCacheWithUrlString(urlString: profileImageUrl)
                 
        }
    }
    
    //MARK: - Cell Selection
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
