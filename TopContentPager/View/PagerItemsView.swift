//
//  PagerItemsView.swift
//  TopContentPager
//
//  Created by 田中厳貴 on 2021/01/08.
//

import UIKit

public enum PagerItem {
    case text(TextItem)
    case image(ImageItem)
    case textAndImage(text: TextItem, image: ImageItem)
    case custom(PagerItemView)
    
    public struct TextItem {
        let title: String
        let font: UIFont
        
        public init(title: String, font: UIFont = UIFont.boldSystemFont(ofSize: 13)) {
            self.title = title
            self.font = font
        }
    }

    public struct ImageItem {
        let image: UIImage?
        let size: CGSize
        let cornerRadius: CGFloat
        
        public init(image: UIImage?, size: CGSize = CGSize(width: 24, height: 24), cornerRadius: CGFloat = 0) {
            self.image = image
            self.size = size
            self.cornerRadius = cornerRadius
        }
    }
    
    
}



final public class PagerItemsView: UIView {

    private var indicatorHeight: CGFloat = 2.0
    private var indicatorMinWidth: CGFloat = 0
    private var itemViewHeight: CGFloat = 20.0
    private var lineHeight: CGFloat = 2.0
    private var indicatorSideSpace: CGFloat = 0

    public var items: [PagerItem] = []
    public var itemViews: [PagerItemView] = []
    public private(set) var options: PagerOptions = .init()

    private var indicator: UIView!
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
    
    public func update(pagerOptions: UpdatePagerOptions) {
        options.itemHeight = pagerOptions.itemHeight ?? options.itemHeight
        options.indicatorHeight = pagerOptions.indicatorHeight ?? options.indicatorHeight
        options.indicatorColor = pagerOptions.indicatorColor ?? options.indicatorColor
        options.activeBackgroundColor = pagerOptions.activeBackgroundColor ?? options.activeBackgroundColor
        options.backgroundColor = pagerOptions.backgroundColor ?? options.backgroundColor
        options.lineColor = pagerOptions.lineColor ?? options.lineColor
        options.deactiveLabelColor = pagerOptions.deactiveLabelColor ?? options.deactiveLabelColor
        options.activeLabelColor = pagerOptions.activeLabelColor ?? options.activeLabelColor
        options.indicatorSideSpace = pagerOptions.indicatorSideSpace ?? options.indicatorSideSpace
        updateView()
    }

    func updateView() {
        self.frame.size.height = options.itemHeight
        self.itemViewHeight = options.itemHeight
        self.indicatorHeight = options.indicatorHeight
        self.lineHeight = options.indicatorHeight
        self.backgroundColor = options.backgroundColor
        self.indicatorSideSpace = options.indicatorSideSpace
        self.lineView.backgroundColor = options.lineColor
        self.indicator.backgroundColor = options.indicatorColor
        itemViews.forEach { itemView in
            itemView.activeColor = options.activeLabelColor
            itemView.deactiveColor = options.deactiveLabelColor
            itemView.activeBackgroundColor = options.activeBackgroundColor
        }
    }

    func addItem(item: PagerItem) {
        self.items.append(item)
        switch item {
        case .text, .image, .textAndImage:
            let itemView = DefaultPagerItemView(frame: CGRect(x: 0, y: 0, width: self.indicatorMinWidth, height: self.bounds.height))
            itemView.configure(with: item)
            self.itemViews.append(itemView)
            self.addSubview(itemView)
        case .custom(let itemView):
            itemView.frame = CGRect(x: 0, y: 0, width: self.indicatorMinWidth, height: self.bounds.height)
            self.itemViews.append(itemView)
            self.addSubview(itemView)
        }
        
        self.setNeedsLayout()
        updateView()
    }

    func adjustIndicator() {
        self.indicator.frame.size.width = self.indicatorWidth - (self.indicatorSideSpace * 2)
    }

    func adjustSelected(page: Int) {
        self.itemViews.forEach {
            $0.isSelected = false
        }
        self.itemViews[safe: page]?.isSelected = true
        UIView.animate(withDuration: 0.1, delay: 0, options: .beginFromCurrentState, animations: {
            self.indicator.frame.origin.x = (CGFloat(page) * self.indicatorWidth) + self.indicatorSideSpace
        }, completion: nil)
    }

    public func updatebadge(index: Int, isHidden: Bool) {
        self.itemViews[safe: index]?.badge(isHidden: isHidden)
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        for (i, view) in self.itemViews.enumerated() {
            let itemMaxWidth: CGFloat = self.frame.size.width / max(CGFloat(self.items.count), 1)
            view.frame = CGRect(x: itemMaxWidth * CGFloat(i), y: 0, width: self.indicatorWidth, height: itemViewHeight - lineHeight)
        }

        self.frontView.frame = self.bounds

        self.indicator.frame = CGRect(
            x: 0, y: self.frame.size.height - self.indicatorHeight,
            width: self.indicatorWidth, height: self.indicatorHeight
        )
        self.lineView.frame = CGRect(x: 0, y: self.frame.size.height - lineHeight, width: self.frame.width, height: lineHeight)
        self.maskLayer.frame = CGRect(x: 0, y: self.frame.size.height - lineHeight, width: self.frame.width, height: lineHeight)
        self.adjustIndicator()
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
                x: 0, y: self.frame.size.height - self.indicatorHeight,
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
