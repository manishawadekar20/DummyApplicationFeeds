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
    
    var currentMediaURL = ""
    var currentProfileURL = ""
    
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
    
    func configureCell(feed: FeedElement) {
        self.imgProfile.image = UIImage(named:"avataar")
        self.imgMedia.image = UIImage(named:"placeholder")
        self.lblComments.text = AppHelper.getNumberInKFormat(inpNumber:Double(feed.comments)) + " " + "Comments"
        self.lblLikes.text = AppHelper.getNumberInKFormat(inpNumber:Double(feed.likes)) + " " + "Likes"
        self.lblDesc.text = feed.content
        self.lblTime.text = AppHelper.getTime(strDate: feed.createdAt)
        
        if feed.user.count > 0 {
            self.currentProfileURL = feed.user[0].avatar
            self.lblUserName.text = feed.user[0].name
            self.lblUserDesignation.text = feed.user[0].designation
            
            if let image = cache.object(forKey: feed.user[0].avatar as NSString) {
                self.imgProfile.image = image
            }
            else
            {
                FeedViewModel.downloadImage(url: feed.user[0].avatar) { (image, imagePath, error) in
                    DispatchQueue.main.async{
                        if error == nil {
                            if self.currentProfileURL.lowercased() == imagePath.lowercased() {
                                self.imgProfile.image = UIImage(data: image!)
                            }
                        }
                    }
                }
            }
        }
        
        if feed.media.count > 0 {
            self.currentMediaURL = feed.media[0].image
            if let image = cache.object(forKey: feed.media[0].image as NSString) {
                self.imgMedia.image = image
            }
            else
            {
                FeedViewModel.downloadImage(url: feed.media[0].image) { (image, imagepath, error) in
                    DispatchQueue.main.async{
                        if error == nil {
                            if self.currentMediaURL.lowercased() == imagepath.lowercased() {
                                self.imgMedia.image = UIImage(data: image!)
                            }
                        }
                    }
                }
            }
        }
    }
}
