//
//  WishDetailInformationViewController.swift
//  tapple
//
//  Created by 田中 厳貴 on 2020/12/10.
//  Copyright © 2020 MatchingAgent, Inc. All rights reserved.
//

import UIKit

public protocol ContentTableViewDelegate: class {
    func moveIndex(index: Int)
    func didEndDragging(viewController: ContentTableViewController, willDecelerate decelerate: Bool)
    func didEndDecelerationg(viewController: ContentTableViewController)
    func didScroll(viewController: ContentTableViewController)
}

public final class ContentTableViewController: UIViewController {

    @IBOutlet public weak var tableView: ContentInnerTableView!
    var moveIndex: Int {
        viewController.moveIndex
    }

    private var observation: NSKeyValueObservation?
    weak var delegate: ContentTableViewDelegate?
    private var dataSource: ContentTableDataSource!
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
    public private(set) var topViewType: ContentTopProtocol.Type!
    private var bodyContentHeight: CGFloat = 0

    public struct Input {
        let topViewType: ContentTopProtocol.Type
        let viewController: ContentTableBody
    }

    public static func create(with input: Input) -> Self {
        let vc = Storyboard.instantiate(self)
        vc.viewController = input.viewController
        vc.topViewType = input.topViewType
        return vc
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = ContentTableDataSource(bodyViewController: viewController, topViewType: topViewType)
        dataSource.setup(tableView: tableView)
        setup()
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        _ = setupContentHeight
    }

    private func setup() {
        tableView.registerNib(classType: ContentTopCell.self)
        tableView.registerNib(classType: ContentBodyCell.self)
        tableView.separatorColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        
        addChild(viewController)
        viewController.didMove(toParent: self)
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
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return topViewType.estimateHeight()
        } else {
            return bodyContentHeight
        }
    }
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return topViewType.estimateHeight()
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


