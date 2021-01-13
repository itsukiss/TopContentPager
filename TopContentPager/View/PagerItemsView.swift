//
//  PagerItemsView.swift
//  TopContentPager
//
//  Created by 田中厳貴 on 2021/01/08.
//

import UIKit

public struct PagerItem {

    public private(set) var title: String

    public init(title: String) {
        self.title = title
    }
}

final public class PagerItemsView: UIView {

    public var indicatorHeight: CGFloat = 2.0
    public var indicatorMinWidth: CGFloat = 0
    public var itemViewHeight: CGFloat = 20.0
    public var lineHeight: CGFloat = 2.0

    public var items: [PagerItem] = []
    public var itemViews: [PagerItemView] = []

    private var indicator: UIView!
    private var indicatorPosition: CGFloat = 0.0
    private var frontView: UIView!
    private var lineView: UIView!
    private var maskLayer: CALayer!

    private var indicatorWidth: CGFloat {
        self.frame.size.width / max(CGFloat(self.items.count), 1)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.prepare()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func update(pagerOptions: PagerOptions) {
        self.frame.size.height = pagerOptions.itemHeight
        self.backgroundColor = pagerOptions.backgroundColor
        self.frontView.backgroundColor = pagerOptions.itemColor
        self.lineView.backgroundColor = pagerOptions.lineColor
        self.indicator.backgroundColor = pagerOptions.indicatorColor
    }

    public func addItem(item: PagerItem) {
        self.items.append(item)
        let itemView = PagerItemView.instantiate()
        itemView.frame.size.height = self.bounds.height
        itemView.frame.size.width = self.indicatorMinWidth
        itemView.configure(with: item)
        self.itemViews.append(itemView)
        self.addSubview(itemView)

        self.setNeedsLayout()
    }

    public func adjustIndicator(rate: CGFloat) {
        self.indicatorPosition = rate
        self.indicator.frame.size.width = self.indicatorWidth
    }

    public func adjustSelected(page: Int) {
        self.itemViews.forEach {
            $0.isSelected = false
        }
        self.itemViews[safe: page]?.isSelected = true
        UIView.animate(withDuration: 0.1, delay: 0, options: .beginFromCurrentState, animations: {
            self.indicator.frame.origin.x = CGFloat(page) * self.indicatorWidth
        }, completion: nil)
    }

    public func updatebadge(index: Int, isHidden: Bool) {
        self.itemViews[safe: index]?.badge(isHidden: isHidden)
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        for (i, view) in self.itemViews.enumerated() {
            let itemMaxWidth: CGFloat = self.frame.size.width / max(CGFloat(self.items.count), 1)

            // 座標計算
            view.center.x = itemMaxWidth * CGFloat(i) + itemMaxWidth * 0.5
            view.center.y = self.itemViewHeight * 0.5
        }

        self.frontView.frame = self.bounds

        self.indicator.frame = CGRect(
            x: 0.0, y: self.frame.size.height - self.indicatorHeight,
            width: self.indicatorWidth, height: self.indicatorHeight
        )
        self.lineView.frame = CGRect(x: 0, y: self.frame.size.height - lineHeight, width: self.frame.width, height: lineHeight)
        self.maskLayer.frame = CGRect(x: 0, y: self.frame.size.height - lineHeight, width: self.frame.width, height: lineHeight)
        self.adjustIndicator(rate: self.indicatorPosition)
    }
}

private extension PagerItemsView {

    func prepare() {
        self.frontView = UIView(frame: self.bounds)
        self.addSubview(self.frontView)

        self.lineView = UIView(frame: CGRect(x: 0, y: self.frame.size.height - lineHeight, width: self.frame.width, height: lineHeight))
        self.addSubview(self.lineView)

        self.indicator = UIView(frame:
            CGRect(
                x: 0.0, y: self.frame.size.height - self.indicatorHeight,
                width: self.indicatorWidth, height: self.indicatorHeight
            )
        )
        self.addSubview(self.indicator)

        self.maskLayer = UIView(frame: CGRect(x: 0, y: self.frame.size.height - lineHeight, width: self.frame.width, height: lineHeight)).layer
        self.frontView.layer.mask = self.maskLayer
    }
}

extension Array {
    public subscript(safe index: Int) -> Element? {
        guard index >= 0, index < endIndex else { return nil }
        return self[index]
    }
}
