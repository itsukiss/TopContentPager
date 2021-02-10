//
//  TopContentPagerViewController.swift
//  TopContentPager
//
//  Created by 田中厳貴 on 2021/01/08.
//

import UIKit

public protocol TopContentPagerDataSource: AnyObject {
    func topContentPagerViewControllerTopContentView(_ viewController: TopContentPagerViewController) -> TopContentView
    func topContentPagerViewControllerViewControllers(_ viewController: TopContentPagerViewController) -> [ContentTableBody]
}

@objc public protocol TopContentPagerDelegate: AnyObject {
    @objc optional func topContentPagerViewControllerTabTopMargin(_ viewController: TopContentPagerViewController) -> CGFloat
}

class EscapeView: UIView { }

open class TopContentPagerViewController: UIViewController, UIGestureRecognizerDelegate {
    
    public weak var dataSource: TopContentPagerDataSource?
    public weak var delegate: TopContentPagerDelegate?
    public var selectedViewController: ContentTableViewController {
            viewControllers[selectedIndex]
    }
    public var selectedIndex: Int = 0 {
        didSet {
            contentOffsetX = scrollView.contentOffset.x
            addContentViewToEscapeView()
            topView.tabView?.adjustSelected(page: selectedIndex)
            UIView.animate(withDuration: 0.25, animations: {
                self.scrollView.setContentOffset(CGPoint(x: self.scrollView.bounds.size.width * CGFloat(self.selectedIndex), y: 0), animated: false)
            }) { _ in
                self.contentOffsetX = self.scrollView.contentOffset.x
                if let constant = self.escapeViewTopConstraint?.constant, -(self.topView.frame.height - self.tabHeight) < constant {
                    self.addContentViewToCell()
                }
            }
        }
    }
    
    public private(set) var viewControllers: [ContentTableViewController] = []
    public private(set) var tabHeight: CGFloat!
    public private(set) var headerHeight: CGFloat!
    public private(set) var safeAreaBar = UIView()
    public var topMargin: CGFloat {
        delegate?.topContentPagerViewControllerTabTopMargin?(self) ?? 0
    }

    private var topView: TopContentView!
    private let scrollView = UIScrollView()
    private let scrollContainerView = UIView()
    private let escapeView = EscapeView()
    private var escapeViewTopConstraint: NSLayoutConstraint?
    private var escapeViewHeightConstraint: NSLayoutConstraint?
    private var containerViews: [UIView] = []
    private var tabBarTitles: [PagerItem] = []
    private var contentOffsetX: CGFloat = 0
    private lazy var setupLayout: Void = {
        tabBarTitles.forEach { topView.tabView?.addItem(item: $0) }
        selectedIndex = 0
        topView.tabView?.adjustSelected(page: selectedIndex)
        topView.tabView?.update(pagerOptions: .init())
        topView.isUserInteractionEnabled = true
        let tabBarTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapTab(_:)))
        tabBarTapRecognizer.delegate = self
        topView.tabView?.addGestureRecognizer(tabBarTapRecognizer)
    }()

    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupWillLoadDataSource()
        guard let dataSource = dataSource, !dataSource.topContentPagerViewControllerViewControllers(self).isEmpty else {
            return
        }
        loadDataSource(dataSource: dataSource)
        setup()
        viewControllers.forEach { vc in
            vc.delegate = self
        }
    }

    open override func viewDidLayoutSubviews() {
        super.viewWillLayoutSubviews()
        guard let dataSource = dataSource, !dataSource.topContentPagerViewControllerViewControllers(self).isEmpty else {
            return
        }
        _ = setupLayout
    }
    
    open func setupWillLoadDataSource() { }

    public func updateHeader() {
        escapeViewHeightConstraint?.constant = topView.estimateHeight
        escapeView.layoutIfNeeded()
        addContentViewToEscapeView()
        viewControllers.forEach { $0.tableView.reloadData() }
        tabHeight = topView.tabViewHeight + topMargin
        headerHeight = topView.estimateHeight
        topView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: headerHeight)
        addContentViewToCell()
        escapeViewHeightConstraint?.constant = topView.estimateHeight
        escapeView.layoutIfNeeded()
    }
    
    private func loadDataSource(dataSource: TopContentPagerDataSource) {
        topView = dataSource.topContentPagerViewControllerTopContentView(self)
        topView.delegate = self
        topView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: topView.estimateHeight)
        tabHeight = topView.tabViewHeight + topMargin
        headerHeight = topView.estimateHeight
        let bodyViewControllers = dataSource.topContentPagerViewControllerViewControllers(self)
        tabBarTitles = bodyViewControllers.map { $0.pagerItem }
        bodyViewControllers.forEach { item in
            let contentVC = ContentTableViewController.create(with: .init(topView: topView, viewController: item))
            viewControllers.append(contentVC)
        }
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
        escapeViewHeightConstraint = escapeView.heightAnchor.constraint(equalToConstant: headerHeight)
        NSLayoutConstraint.activate([
            escapeViewTopConstraint!,
            escapeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            escapeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            escapeViewHeightConstraint!
        ])
        
        safeAreaBar.translatesAutoresizingMaskIntoConstraints = false
        safeAreaBar.isUserInteractionEnabled = false
        safeAreaBar.backgroundColor = .white
        safeAreaBar.clipsToBounds = true
        view.addSubview(safeAreaBar)
        
        NSLayoutConstraint.activate([
            safeAreaBar.topAnchor.constraint(equalTo: view.topAnchor),
            safeAreaBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            safeAreaBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            safeAreaBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    @objc private func tapTab(_ sender: UITapGestureRecognizer) {
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
        }
    }

    private func addContentViewToEscapeView() {
        if topView.superview == escapeView { return }
        escapeView.isUserInteractionEnabled = true
        escapeView.addSubview(topView)

        let topConstant = max(0, min(topView.frame.height - tabHeight, selectedViewController.tableView.contentOffset.y))
        escapeViewTopConstraint?.constant = -topConstant
        escapeView.layoutIfNeeded()
    }

    private func tableViewsScroll() {
        let viewControllers = self.viewControllers.filter({ !($0 == selectedViewController) })
        let contentHeight = topView.frame.height - tabHeight
        viewControllers.forEach { vc in
            var contentOffset: CGPoint
            if selectedViewController.tableView.contentOffset.y >= contentHeight {
                contentOffset = vc.tableView.contentOffset.y >= contentHeight ? vc.tableView.contentOffset : CGPoint(x: 0, y: contentHeight)
            } else {
                contentOffset = selectedViewController.tableView.contentOffset
            }
            vc.tableView.setContentOffset(contentOffset, animated: false)
        }
    }
}

extension TopContentPagerViewController: UIScrollViewDelegate {
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        contentOffsetX = scrollView.contentOffset.x
        if let constant = escapeViewTopConstraint?.constant, !decelerate && -(topView.frame.height - tabHeight) < constant {
            addContentViewToCell()
        }
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != contentOffsetX {
            scrollView.contentOffset.y = 0
        }
    }

    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        contentOffsetX = scrollView.contentOffset.x
        addContentViewToEscapeView()
    }

    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
        selectedIndex = index
    }
}

extension TopContentPagerViewController: ContentTableViewDelegate {
    
    public func didEndDragging(viewController: ContentTableViewController, willDecelerate decelerate: Bool) {
        guard !decelerate, viewController == self.selectedViewController else { return }
        self.tableViewsScroll()
    }
    
    public func didEndDecelerationg(viewController: ContentTableViewController) {
        guard viewController == self.selectedViewController else { return }
        self.tableViewsScroll()
    }
    
    public func didScroll(viewController: ContentTableViewController) {
        guard viewController == self.selectedViewController else { return }
        if selectedViewController.tableView.contentOffset.y > self.topView.frame.height - self.tabHeight {
            self.addContentViewToEscapeView()
        } else {
            self.addContentViewToCell()
        }
    }
}

extension TopContentPagerViewController: TopContentViewDelegate {
    func needsReload() {
        updateHeader()
    }
}
