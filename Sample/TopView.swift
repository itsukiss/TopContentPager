//
//  TopView.swift
//  Sample
//
//  Created by 田中厳貴 on 2021/01/13.
//

import UIKit
import TopContentPager

class TopView: UIView, ContentTopProtocol {
    var tabViewHeight: CGFloat = 44
    var estimateHeight: CGFloat = 300
    var tabView: PagerItemsView! = PagerItemsView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tabView.update(pagerOptions: .init(itemHeight: tabViewHeight))
        tabView.autoresizingMask = .flexibleWidth
        tabView.frame = CGRect(x: 0, y: self.frame.height - tabViewHeight, width: self.frame.width, height: tabViewHeight)
        self.addSubview(tabView)
    }
}
