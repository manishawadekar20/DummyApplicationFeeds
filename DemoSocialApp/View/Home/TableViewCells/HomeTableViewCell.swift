//
//  HomeTableViewCell.swift
//  DemoSocialApp
//
//  Created by Manisha Wadekar on 6/19/20.
//  Copyright © 2020 Manisha Wadekar. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    //MARK: - Declarations
    @IBOutlet fileprivate weak var imgProfile:UIImageView!
    @IBOutlet fileprivate weak var imgMedia:UIImageView!
    @IBOutlet fileprivate weak var lblUserName:UILabel!
    @IBOutlet fileprivate weak var lblUserDesignation:UILabel!
    @IBOutlet fileprivate weak var lblDesc:UILabel!
    @IBOutlet fileprivate weak var lblLikes:UILabel!
    @IBOutlet fileprivate weak var lblComments:UILabel!
    @IBOutlet fileprivate weak var lblTime:UILabel!
    
    @IBOutlet weak var lcMediaHeight:NSLayoutConstraint!
    
    //MARK: -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imgProfile.layer.cornerRadius = self.imgProfile.frame.size.width/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
