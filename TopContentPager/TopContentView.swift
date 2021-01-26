//
//  TopContentView.swift
//  TopContentPager
//
//  Created by 田中厳貴 on 2021/01/26.
//

import UIKit

protocol TopContentViewDelegate: AnyObject {
    func needsReload()
}

public protocol TopContentViewDataSource: AnyObject {
    func topContentViewHeight(_ view: TopContentView) -> CGFloat?
}

open class TopContentView: UIView {
    
    open var isHideTabView: Bool {
        false
    }
    
    public weak var dataSource: TopContentViewDataSource?
    public var tabView: PagerItemsView?
    
    weak var delegate: TopContentViewDelegate?
    var tabViewHeight: CGFloat {
        tabView?.options.itemHeight ?? 0
    }
    var estimateHeight: CGFloat {
        if let height = dataSource?.topContentViewHeight(self) {
            return height
        } else {
            return self.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize, withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .defaultLow).height
        }
    }
    
    private var tabViewHeightConstraint: NSLayoutConstraint?
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        if !isHideTabView {
            tabView = .init()
            setupTab()
        }
    }
    
    public func updateTab(options: UpdatePagerOptions) {
        tabView?.update(pagerOptions: options)
        tabViewHeightConstraint?.constant = tabViewHeight
        updateLayout()
    }
    
    public func updateLayout() {
        UIView.animate(withDuration: 0) {
            self.removeFromSuperview()
            self.layoutIfNeeded()
            self.delegate?.needsReload()
        }
    }
    
    private func setupTab() {
        guard let tabView = tabView else { return }
        tabView.update(pagerOptions: .init())
        tabView.autoresizingMask = .flexibleWidth
        tabView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tabView)
        tabViewHeightConstraint = tabView.heightAnchor.constraint(equalToConstant: tabViewHeight)
        NSLayoutConstraint.activate([
            tabView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tabView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tabView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tabViewHeightConstraint!
        ])
    }
}
