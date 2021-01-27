//
//  TimelineTableCell.swift
//  Sample
//
//  Created by 田中厳貴 on 2021/01/27.
//

import UIKit

class TimelineTableCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView! {
        didSet {
            profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
            profileImageView.clipsToBounds = true
        }
    }
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var postImageView: UIImageView! {
        didSet {
            postImageView.contentMode = .scaleAspectFill
        }
    }
    @IBOutlet weak var postNoteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func prepare(image: UIImage) {
        profileImageView.image = UIImage(named: "noman")
        userNameLabel.text = "Elyane Bent Caillot"
        postImageView.image = image
        postNoteLabel.text = "This is my favorite place.\nI went there in last summer.\n#summer #sea #favorite"
    }
}
