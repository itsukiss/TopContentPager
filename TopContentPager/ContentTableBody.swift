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
    var moveIndex: Int { get }
}

public extension ContentTableBody {
    var moveIndex: Int {
        0
    }
}
