//
//  TopView.swift
//  Sample
//
//  Created by 田中厳貴 on 2021/01/13.
//

import UIKit
import TopContentPager

class TopView: TopContentView {
    
    @IBOutlet weak var profileImageView: UIImageView! {
        didSet {
            profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
            profileImageView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.numberOfLines = 0
            descriptionLabel.lineBreakMode = .byClipping
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepare()
    }
    
    func prepare() {
        profileImageView.image = UIImage(named: "noman")
        userNameLabel.text = "Elyane Bent Caillot"
        descriptionLabel.text = "Universed inside you.\nFounder & Designer & Creative Director.\nFrom France."
        updateLayout()
    }
}
