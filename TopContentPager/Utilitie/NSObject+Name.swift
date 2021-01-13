//
//  NSObject+Name.swift
//  TopContentPager
//
//  Created by 田中厳貴 on 2021/01/13.
//

import Foundation

extension NSObject {
    class var className: String {
        String(describing: self)
    }

    var className: String {
        String(describing: type(of: self))
    }
}
