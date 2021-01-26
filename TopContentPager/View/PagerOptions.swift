//
//  PagerOptions.swift
//  TopContentPager
//
//  Created by 田中厳貴 on 2021/01/08.
//

import UIKit

final public class PagerOptions {
    public var itemHeight: CGFloat = 44
    public var indicatorHeight: CGFloat = 2
    public var indicatorColor: UIColor = UIColor.black
    public var activeBackgroundColor: UIColor = UIColor.clear
    public var backgroundColor: UIColor = UIColor.white
    public var lineColor: UIColor = UIColor.white
    public var deactiveLabelColor: UIColor = UIColor.gray
    public var activeLabelColor: UIColor = UIColor.black
    public var indicatorSideSpace: CGFloat = 0

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
    public var itemHeight: CGFloat?
    public var indicatorHeight: CGFloat?
    public var indicatorColor: UIColor?
    public var activeBackgroundColor: UIColor?
    public var backgroundColor: UIColor?
    public var lineColor: UIColor?
    public var deactiveLabelColor: UIColor?
    public var activeLabelColor: UIColor?
    public var indicatorSideSpace: CGFloat?
    
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
