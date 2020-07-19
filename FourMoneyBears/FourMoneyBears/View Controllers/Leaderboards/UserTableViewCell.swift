//
//  UserTableViewCell.swift
//  FourMoneyBears
//
//  Created by Austin Potts on 7/18/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    var users: Users? {
        didSet {
            updateViews()
        }
    }

    @IBOutlet var usersImage: UIImageView!
    
    @IBOutlet var usersName: UILabel!
    
    @IBOutlet var usersRank: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateViews(){
        
        usersName.text = users?.name
        usersRank.text = users?.rank
        
    
        
        if let profileImageUrl = users!.profileImageURL {
                 
                 usersImage.loadImageViewUsingCacheWithUrlString(urlString: profileImageUrl)
                 
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
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
