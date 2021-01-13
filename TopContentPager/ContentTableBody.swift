//
//  ContentTableBody.swift
//  tapple
//
//  Created by 田中 厳貴 on 2021/01/05.
//  Copyright © 2021 MatchingAgent, Inc. All rights reserved.
//

import UIKit

public protocol ContentTableBody: UIViewController {
    var scrollView: UIScrollView! { get }
    var delegate: ContentTableBodyDelegate? { get set }
    func refresh(sender: UIRefreshControl, contentViewController: ContentTableViewController) -> Bool
}

public extension ContentTableBody {
    func refresh(sender: UIRefreshControl, contentViewController: ContentTableViewController) -> Bool {
        return false
    }
}

public protocol ContentTableBodyDelegate: class {
    func selectedIndex(index: Int)
}
