//
//  PagerOptions.swift
//  TopContentPager
//
//  Created by 田中厳貴 on 2021/01/08.
//

import UIKit

final public class PagerOptions {
    var itemHeight: CGFloat = 44
    var indicatorHeight: CGFloat = 2
    var indicatorColor: UIColor = UIColor.black
    var activeBackgroundColor: UIColor = UIColor.clear
    var backgroundColor: UIColor = UIColor.white
    var lineColor: UIColor = UIColor.white
    var deactiveLabelColor: UIColor = UIColor.gray
    var activeLabelColor: UIColor = UIColor.black
    var indicatorSideSpace: CGFloat = 0

    init() {

    }

    init(itemHeight: CGFloat = 44,
                indicatorHeight: CGFloat = 2,
                indicatorColor: UIColor = UIColor.black,
                activeBackgroundColor: UIColor = UIColor.clear,
                backgroundColor: UIColor = UIColor.white,
                lineColor: UIColor = UIColor.white,
                deactiveLabelColor: UIColor = UIColor.gray,
                activeLabelColor: UIColor = UIColor.black,
                indicatorSideSpace: CGFloat = 0) {
        self.itemHeight = itemHeight
        self.indicatorHeight = indicatorHeight
        self.indicatorColor = indicatorColor
        self.activeBackgroundColor = activeBackgroundColor
        self.backgroundColor = backgroundColor
        self.lineColor = lineColor
        self.deactiveLabelColor = deactiveLabelColor
        self.activeLabelColor = activeLabelColor
        self.indicatorSideSpace = indicatorSideSpace
    }
}

final public class UpdatePagerOptions {
    var itemHeight: CGFloat?
    var indicatorHeight: CGFloat?
    var indicatorColor: UIColor?
    var activeBackgroundColor: UIColor?
    var backgroundColor: UIColor?
    var lineColor: UIColor?
    var deactiveLabelColor: UIColor?
    var activeLabelColor: UIColor?
    var indicatorSideSpace: CGFloat?
    
    public init() { }
    
    public init(itemHeight: CGFloat? = nil,
                indicatorHeight: CGFloat? = nil,
                indicatorColor: UIColor? = nil,
                activeBackgroundColor: UIColor? = nil,
                backgroundColor: UIColor? = nil,
                lineColor: UIColor? = nil,
                deactiveLabelColor: UIColor? = nil,
                activeLabelColor: UIColor? = nil,
                indicatorSideSpace: CGFloat? = nil) {
        self.itemHeight = itemHeight
        self.indicatorHeight = indicatorHeight
        self.indicatorColor = indicatorColor
        self.activeBackgroundColor = activeBackgroundColor
        self.backgroundColor = backgroundColor
        self.lineColor = lineColor
        self.deactiveLabelColor = deactiveLabelColor
        self.activeLabelColor = activeLabelColor
        self.indicatorSideSpace = indicatorSideSpace
    }
}
