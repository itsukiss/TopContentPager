//
//  ContentTableBody.swift
//  TopContentPager
//
//  Created by 田中厳貴 on 2021/01/08.
//

import UIKit

public protocol ContentTableBody: UIViewController {
    var pageTitle: String { get }
    var scrollView: UIScrollView! { get }
    var delegate: ContentTableBodyDelegate? { get set }
    @discardableResult func refresh(sender: UIRefreshControl, contentViewController: ContentTableViewController) -> Bool
}

public extension ContentTableBody {
    func refresh(sender: UIRefreshControl, contentViewController: ContentTableViewController) -> Bool {
        return false
    }
}

public protocol ContentTableBodyDelegate: class {
    func selectedIndex(index: Int)
}
