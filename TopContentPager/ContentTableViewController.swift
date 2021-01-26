//
//  WishDetailInformationViewController.swift
//  TopContentPager
//
//  Created by 田中厳貴 on 2021/01/08.
//

import UIKit

public protocol ContentTableViewDelegate: class {
    func didEndDragging(viewController: ContentTableViewController, willDecelerate decelerate: Bool)
    func didEndDecelerationg(viewController: ContentTableViewController)
    func didScroll(viewController: ContentTableViewController)
}

public final class ContentTableViewController: UIViewController {

    public var tableView = ContentInnerTableView()
 
    private var observation: NSKeyValueObservation?
    private var refreshControl = UIRefreshControl()
    weak var delegate: ContentTableViewDelegate?
    public private(set) var viewController: ContentTableBody!
    lazy var setupContentHeight: Void = {
        observation = nil
        observation = viewController.scrollView.observe(\.contentSize, options: [.new, .old, .prior]) { [weak self] ( _, contentSize) in
            if let newValue = contentSize.newValue {
                self?.bodyContentHeight = newValue.height
            }
            self?.tableView.reloadData()
        }
    }()
    public private(set) var topView: TopContentView!
    private var bodyContentHeight: CGFloat = 0

    public struct Input {
        let topView: TopContentView
        let viewController: ContentTableBody
    }

    public static func create(with input: Input) -> Self {
        let vc = Self.init()
        vc.viewController = input.viewController
        vc.topView = input.topView
        return vc
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setup()
    }
    
    private func setupView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func setup() {
        tableView.registerClass(classType: ContentTopCell.self)
        tableView.registerClass(classType: ContentBodyCell.self)
        tableView.separatorColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.refreshControl = viewController.refresh(sender: refreshControl, contentViewController: self) ? refreshControl : nil
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        
        addChild(viewController)
        viewController.didMove(toParent: self)
    }
    
    @objc func refresh(sender: UIRefreshControl) {
        viewController.refresh(sender: sender, contentViewController: self)
    }
}

extension ContentTableViewController: UIScrollViewDelegate{
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        delegate?.didEndDragging(viewController: self, willDecelerate: decelerate)
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegate?.didEndDecelerationg(viewController: self)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.didScroll(viewController: self)
    }
}

extension ContentTableViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            return tableView.dequeueReusableCell(classType: ContentTopCell.self, for: indexPath)
        } else {
            let cell = tableView.dequeueReusableCell(classType: ContentBodyCell.self, for: indexPath)
            if let bodyVC = viewController {
                cell.prepare(viewController: bodyVC)
            }
            return cell
        }
    }
    
    
}

extension ContentTableViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell is ContentBodyCell {
            _ = setupContentHeight
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return topView.estimateHeight
        } else {
            return bodyContentHeight
        }
    }
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return topView.estimateHeight
        } else {
            return bodyContentHeight
        }
    }
}

public class ContentInnerTableView: UITableView {
    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        func findScrollView(targetView: UIView?) -> UIView? {
            guard let targetView = targetView else { return nil }
            if let _ = targetView as? UIScrollView {
                return targetView
            } else {
                return findScrollView(targetView: targetView.superview)
            }
        }
        if let scrollView = findScrollView(targetView: superview) as? UIScrollView {
            if let index = indexPathForRow(at: point), let _ = cellForRow(at: index) as? ContentTopCell {
                scrollView.isScrollEnabled = false
            } else {
                scrollView.isScrollEnabled = true
            }
        }
        return super.hitTest(point, with: event)
    }
}


