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
    private let page1 = Page1ViewController.create()
    private let page2 = Page2ViewController.create()
    
    override func setupDataSource() {
        super.setupDataSource()
        dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension CustomTopContentPagerViewController: TopContentPagerDataSource {
    func topContentPagerViewControllerTopContentView(_ viewController: TopContentPagerViewController) -> ContentTopProtocol {
        topView
    }
    
    func topContentPagerViewControllerTabTitles(_ viewController: TopContentPagerViewController) -> [String] {
        ["Page1", "Page2"]
    }
    
    func topContentPagerViewControllerViewControllers(_ viewController: TopContentPagerViewController) -> [ContentTableBody] {
        [page1, page2]
    }
    
}
