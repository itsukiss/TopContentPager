//
//  TopView.swift
//  Sample
//
//  Created by 田中厳貴 on 2021/01/13.
//

import UIKit
import TopContentPager

class TopView: TopContentView {
    @IBOutlet weak var topViewLabel: UILabel! {
        didSet {
            topViewLabel.numberOfLines = 0
        }
    }
    @IBOutlet weak var bottomSpace: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.topViewLabel.text = "ajkldajflkfjajfdklajdfjklsjfkajdjflafdjkfjlajfdkljalfjdksafjdlkafjkafjladfjdlakfkjf"
            self.bottomSpace.constant = 300
            self.updateLayout()
        }
        
    }
}
