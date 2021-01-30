//
//  CustomTopContentPagerViewController.swift
//  Sample
//
//  Created by 田中厳貴 on 2021/01/15.
//

import UIKit
import TopContentPager

final class CustomTopContentPagerViewController: TopContentPagerViewController {
    private let topView = TopView.instantiate()
    private let myPostVC = MyPostViewController.create()
    private let timelineVC = TimelineViewController.create()
    private let notificationVC = NotificationViewController.create()
    
    override func setupWillLoadDataSource() {
        super.setupWillLoadDataSource()
        dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension CustomTopContentPagerViewController: TopContentPagerDataSource {
    func topContentPagerViewControllerTopContentView(_ viewController: TopContentPagerViewController) -> TopContentView {
        topView
    }
    
    func topContentPagerViewControllerViewControllers(_ viewController: TopContentPagerViewController) -> [ContentTableBody] {
        [myPostVC, timelineVC, notificationVC]
    }
}
