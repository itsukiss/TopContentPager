//
//  Storyboard.swift
//  TopContentPager
//
//  Created by 田中厳貴 on 2021/01/13.
//

import UIKit

final class Storyboard {

    public static func instantiate<T: UIViewController>(_ type: T.Type) -> T {
        let storyboardName = String(describing: type)
        let sb = UIStoryboard(name: storyboardName, bundle: Bundle(for: type))
        let vc = sb.instantiateInitialViewController() as! T
        return vc
    }
}
