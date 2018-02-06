//
//  PostCell.swift
//  Instagram
//
//  Created by Jonathan Grider on 2/5/18.
//  Copyright © 2018 Jonathan Grider. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PostCell: UITableViewCell {
  
  @IBOutlet weak var postImageView: PFImageView!
  @IBOutlet weak var usernameLabel: UILabel!
  @IBOutlet weak var profilePictureImageView: UIImageView!
  @IBOutlet weak var captionLabel: UILabel!
  
  var post: Post! {
    didSet {
      self.postImageView.file = self.post.media
      self.postImageView.loadInBackground()
      self.usernameLabel.text = self.post.author.username
      self.captionLabel.text = self.post.caption
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
//    self.profilePictureImageView.layer.cornerRadius = self.profilePictureImageView.bounds.width/2
//    self.profilePictureImageView.clipsToBounds = true
//    self.selectionStyle = .none
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
