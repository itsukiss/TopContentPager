//
//  PagerOptions.swift
//  TopContentPager
//
//  Created by 田中厳貴 on 2021/01/08.
//

import UIKit

final public class PagerOptions {
    var itemHeight: CGFloat = 44
    var indicatorColor: UIColor = UIColor.black
    var backgroundColor: UIColor = UIColor.white
    var lineColor: UIColor = UIColor.white
    var itemColor: UIColor = UIColor.gray
    var activeItemColor: UIColor = UIColor.black
    var contentSideSpace: CGFloat = 0
    var isHideTabView: Bool = false

    public init() {

    }

    public init(itemHeight: CGFloat = 44,
                indicatorColor: UIColor = UIColor.black,
                backgroundColor: UIColor = UIColor.white,
                lineColor: UIColor = UIColor.white,
                itemColor: UIColor = UIColor.gray,
                activeItemColor: UIColor = UIColor.black,
                contentSideSpace: CGFloat = 0,
                isHideTabView: Bool = false) {
        self.itemHeight = itemHeight
        self.indicatorColor = indicatorColor
        self.backgroundColor = backgroundColor
        self.lineColor = lineColor
        self.itemColor = itemColor
        self.activeItemColor = activeItemColor
        self.contentSideSpace = contentSideSpace
        self.isHideTabView = isHideTabView
    }
}
