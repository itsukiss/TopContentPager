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
        prepare()
    }
    
    func prepare() {
        topViewLabel.text = "山路を登りながら、こう考えた。智に働けば角が立つ。情に棹させば流される。意地を通せば窮屈だ。とかくに人の世は住みにくい。住みにくさが高じると、安い所へ引き越したくなる。"
        updateLayout()
    }
}
