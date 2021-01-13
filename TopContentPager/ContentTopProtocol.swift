//
//  ContentTopProtocol.swift
//  tapple
//
//  Created by 田中 厳貴 on 2021/01/05.
//  Copyright © 2021 MatchingAgent, Inc. All rights reserved.
//

import UIKit

public protocol ContentTopProtocol: UIView {
    var tabViewHeight: CGFloat { get set }
    var estimateHeight: CGFloat { get set }
    var tabView: PagerItemsView! { get set }
}
