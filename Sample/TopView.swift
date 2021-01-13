//
//  TopView.swift
//  Sample
//
//  Created by 田中厳貴 on 2021/01/13.
//

import UIKit
import TopContentPager

class TopView: UIView, ContentTopProtocol {
    static func tabViewHeight() -> CGFloat {
        44
    }
    
    static func estimateHeight() -> CGFloat {
        300
    }
    
    var tabView: PagerItemsView! = PagerItemsView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .blue
        tabView.itemViewHeight = TopView.tabViewHeight()
        tabView.autoresizingMask = .flexibleWidth
        tabView.frame = CGRect(x: 0, y: self.frame.height - TopView.tabViewHeight(), width: self.frame.width, height: TopView.tabViewHeight())
        self.addSubview(tabView)
    }
}
