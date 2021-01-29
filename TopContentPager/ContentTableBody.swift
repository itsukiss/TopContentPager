//
//  ContentTableBody.swift
//  TopContentPager
//
//  Created by 田中厳貴 on 2021/01/08.
//

import UIKit

public protocol ContentTableBody: UIViewController {
    var pagerItem: PagerItem { get }
    var scrollView: UIScrollView! { get }
    @discardableResult func refresh(sender: UIRefreshControl, contentViewController: ContentTableViewController) -> Bool
}

public extension ContentTableBody {
    func refresh(sender: UIRefreshControl, contentViewController: ContentTableViewController) -> Bool {
        return false
    }
}
