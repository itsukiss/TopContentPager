//
//  TopContent.swift
//  TopContentPager
//
//  Created by 田中厳貴 on 2021/01/08.
//

import UIKit

public protocol TopContent: UIView {
    var tabViewHeight: CGFloat { get }
    var estimateHeight: CGFloat { get }
    var tabView: PagerItemsView? { get set }
}

public extension TopContent {
    var tabViewHeight: CGFloat {
        tabView?.options.itemHeight ?? 0
    }
    
    var estimateHeight: CGFloat {
        self.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize, withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .defaultLow).height
    }
}
