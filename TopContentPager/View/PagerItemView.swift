//
//  PagerItemView.swift
//  TopContentPager
//
//  Created by 田中厳貴 on 2021/01/08.
//

import UIKit

public protocol PagerItemView: UIView {
    var activeColor: UIColor { get set }
    var deactiveColor: UIColor { get set }
    var activeBackgroundColor: UIColor { get set }
    var isSelected: Bool { get set }
    
    func badge(isHidden: Bool)
}
