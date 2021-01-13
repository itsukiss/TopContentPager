//
//  PagerItemView.swift
//  TopContentPager
//
//  Created by 田中厳貴 on 2021/01/08.
//

import UIKit

final public class PagerItemView: UIView {

    @IBOutlet public weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = UIFont.boldSystemFont(ofSize: 13)
            titleLabel.textColor = UIColor.black
        }
    }
    @IBOutlet public weak var badgeView: UIView! {
        didSet {
            badgeView.isHidden = true
            badgeView.layer.cornerRadius = badgeView.frame.width / 2
            badgeView.backgroundColor = UIColor.red
        }
    }
    public var isSelected: Bool = false {
        didSet {
            if isSelected {
                titleLabel.textColor = UIColor.black
            } else {
                titleLabel.textColor = UIColor.black
            }
        }
    }

    public func configure(with res: PagerItem) {
        self.titleLabel.text = res.title
    }

    public func badge(isHidden: Bool) {
        self.badgeView.isHidden = isHidden
    }
}

