//
//  WishDetailViewController.swift
//  tapple
//
//  Created by 田中 厳貴 on 2020/11/30.
//  Copyright © 2020 MatchingAgent, Inc. All rights reserved.
//

import UIKit

public final class TopContentPagerViewController: UIViewController, UIGestureRecognizerDelegate {

    public struct PageItem {
        public let title: String
        public let viewController: ContentTableBody
        
        public init(title: String, viewController: ContentTableBody) {
            self.title = title
            self.viewController = viewController
        }
    }

    public struct Input {
        public let topView: ContentTopProtocol
        public let pageItems: [PageItem]
        
        public init(topView: ContentTopProtocol, pageItems: [PageItem]) {
            self.topView = topView
            self.pageItems = pageItems
        }
    }

    public static func create(with input: Input) -> Self {
        let vc = Storyboard.instantiate(self)
        vc.topView = input.topView
        vc.topView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: input.topView.estimateHeight)
        vc.tabHeight = input.topView.tabViewHeight
        vc.headerHeight = input.topView.estimateHeight
        input.pageItems.forEach { item in
            vc.tabBarTitles.append(item.title)
            let contentVC = ContentTableViewController.create(with: .init(topView: input.topView, viewController: item.viewController))
            vc.viewControllers.append(contentVC)
        }
        return vc
    }

    private let scrollView = UIScrollView()
    private let scrollContainerView = UIView()
    public var topView: ContentTopProtocol!
    private let escapeView = UIView()
    private var escapeViewTopConstraint: NSLayoutConstraint?
    private var containerViews: [UIView] = []
    private var viewControllers: [ContentTableViewController] = []
    private var tabBarTitles: [String] = []
    public var selectedIndex: Int = 0 {
        didSet {
            addContentViewToEscapeView()
            topView.tabView?.adjustSelected(page: selectedIndex)
            UIView.animate(withDuration: 0.25, animations: {
                self.scrollView.setContentOffset(CGPoint(x: self.scrollView.bounds.size.width * CGFloat(self.selectedIndex), y: 0), animated: false)
            }) { _ in
                if let constant = self.escapeViewTopConstraint?.constant, -(self.topView.frame.height - self.tabHeight) < constant {
                    self.addContentViewToCell()
                }
            }
        }
    }
    private lazy var setupLayout: Void = {
        tabBarTitles.map { PagerItem(title: $0) }.forEach { topView.tabView?.addItem(item: $0) }
        selectedIndex = 0
        topView.tabView?.adjustSelected(page: selectedIndex)
        topView.tabView?.update(pagerOptions: .init())
        topView.isUserInteractionEnabled = true
        let tabBarTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapTab(_:)))
        tabBarTapRecognizer.delegate = self
        topView.tabView?.addGestureRecognizer(tabBarTapRecognizer)
    }()

    public var selectedViewController: ContentTableViewController {
            viewControllers[selectedIndex]
    }

    public private(set) var tabHeight: CGFloat!
    public private(set) var headerHeight: CGFloat!

    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewControllers.forEach { vc in
            vc.delegate = self
        }
    }

    public override func viewDidLayoutSubviews() {
        super.viewWillLayoutSubviews()
        _ = setupLayout
    }

    private func setup() {
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.scrollsToTop = false
        scrollView.isDirectionalLockEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = false
        scrollView.isScrollEnabled = false
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])

        scrollContainerView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(scrollContainerView)
        NSLayoutConstraint.activate([
            scrollContainerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollContainerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollContainerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollContainerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                                        scrollContainerView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            scrollContainerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: CGFloat(viewControllers.count))
        ])

        viewControllers.enumerated().forEach { index, vc in
            vc.view.translatesAutoresizingMaskIntoConstraints = false
            scrollContainerView.addSubview(vc.view)
            var constraints: [NSLayoutConstraint] = []
            switch index {
            case 0:
                constraints.append(vc.view.leadingAnchor.constraint(equalTo: scrollContainerView.leadingAnchor))
            case viewControllers.count - 1:
                guard let previousVC = viewControllers[safe: index - 1] else { return }
                constraints.append(contentsOf: [
                    vc.view.trailingAnchor.constraint(equalTo: scrollContainerView.trailingAnchor),
                    vc.view.leadingAnchor.constraint(equalTo: previousVC.view.trailingAnchor)
                ])
            default:
                guard let previousVC = viewControllers[safe: index - 1] else { return }
                constraints.append(vc.view.leadingAnchor.constraint(equalTo: previousVC.view.trailingAnchor))
            }
            constraints.append(contentsOf: [
                vc.view.topAnchor.constraint(equalTo: scrollContainerView.topAnchor),
                vc.view.bottomAnchor.constraint(equalTo: scrollContainerView.bottomAnchor),
                vc.view.widthAnchor.constraint(equalToConstant: view.frame.width)
            ])
            addChild(vc)
            vc.didMove(toParent: self)
            NSLayoutConstraint.activate(constraints)
        }

        escapeView.translatesAutoresizingMaskIntoConstraints = false
        escapeView.isUserInteractionEnabled = false
        escapeView.backgroundColor = .clear
        view.addSubview(escapeView)
        escapeViewTopConstraint = escapeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        NSLayoutConstraint.activate([
            escapeViewTopConstraint!,
            escapeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            escapeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            escapeView.heightAnchor.constraint(equalToConstant: headerHeight)
        ])
    }
    
    @objc
    private func tapTab(_ sender: UITapGestureRecognizer) {
        guard let tabView = topView.tabView else { return }
        let position = sender.location(in: self.topView.tabView)
        if position.y < tabView.frame.size.height - tabView.options.itemHeight {
            return
        }
        
        let index = Int(floor(position.x / (tabView.frame.size.width / max(CGFloat(tabView.items.count), 1))))
        self.selectedIndex = index
    }

    private func addContentViewToCell() {
        if topView.superview != escapeView { return }
        escapeView.isUserInteractionEnabled = false

        let cells = selectedViewController.tableView.visibleCells.filter { $0.isKind(of: ContentTopCell.self) }
        if let cell = cells.first as? ContentTopCell {
            cell.addSubview(topView)
            NSLayoutConstraint.activate([
                topView.topAnchor.constraint(equalTo: cell.topAnchor),
                topView.bottomAnchor.constraint(equalTo: cell.bottomAnchor),
                topView.trailingAnchor.constraint(equalTo: cell.trailingAnchor),
                topView.leadingAnchor.constraint(equalTo: cell.leadingAnchor)
            ])
        }
    }

    private func addContentViewToEscapeView() {
        if topView.superview == escapeView { return }
        escapeView.isUserInteractionEnabled = true
        escapeView.addSubview(topView)

        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: escapeView.topAnchor),
            topView.bottomAnchor.constraint(equalTo: escapeView.bottomAnchor),
            topView.trailingAnchor.constraint(equalTo: escapeView.trailingAnchor),
            topView.leadingAnchor.constraint(equalTo: escapeView.leadingAnchor)
        ])

        let topConstant = max(0, min(topView.frame.height - tabHeight, selectedViewController.tableView.contentOffset.y))
        escapeViewTopConstraint?.constant = -topConstant
        escapeView.layoutIfNeeded()
    }

    private func tableViewsScroll() {
        let viewControllers = self.viewControllers.filter({ !($0 == selectedViewController) })
        let contentHeight = topView.frame.height - tabHeight
        viewControllers.forEach {
            guard let tableView = $0.tableView, let selectedTableView = selectedViewController.tableView else { return }
            var contentOffset: CGPoint
            if selectedTableView.contentOffset.y >= contentHeight {
                contentOffset = tableView.contentOffset.y >= contentHeight ? tableView.contentOffset : CGPoint(x: 0, y: contentHeight)
            } else {
                contentOffset = selectedTableView.contentOffset
            }
            tableView.setContentOffset(contentOffset, animated: false)
        }
    }
}

extension TopContentPagerViewController: UIScrollViewDelegate {
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if let constant = escapeViewTopConstraint?.constant, !decelerate && -(topView.frame.height - tabHeight) < constant {
            addContentViewToCell()
        }
    }

    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        addContentViewToEscapeView()
    }

    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
        selectedIndex = index
    }
}

extension TopContentPagerViewController: ContentTableViewDelegate {

    public func moveIndex(index: Int) {
        self.selectedIndex = index
    }
    
    public func didEndDragging(viewController: ContentTableViewController, willDecelerate decelerate: Bool) {
        guard !decelerate, viewController == self.selectedViewController else { return }
        self.tableViewsScroll()
    }
    
    public func didEndDecelerationg(viewController: ContentTableViewController) {
        guard viewController == self.selectedViewController else { return }
        self.tableViewsScroll()
    }
    
    public func didScroll(viewController: ContentTableViewController) {
        guard viewController == self.selectedViewController, let selectedTableView = viewController.tableView else { return }
        if selectedTableView.contentOffset.y > self.topView.frame.height - self.tabHeight {
            self.addContentViewToEscapeView()
        } else {
            self.addContentViewToCell()
        }
    }
}
