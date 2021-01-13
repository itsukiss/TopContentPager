//
//  UITableView+Register.swift
//  TopContentPager
//
//  Created by 田中厳貴 on 2021/01/13.
//

import UIKit

extension UITableView {

    public func registerNib<T: UITableViewCell>(classType type: T.Type) {
        let nib = UINib(nibName: type.className, bundle: Bundle(for: type))
        register(nib, forCellReuseIdentifier: type.className)
    }

    public func registerClass<T: UITableViewCell>(classType type: T.Type) {
        register(T.self, forCellReuseIdentifier: type.className)
    }

    public func registerNib<T: UITableViewHeaderFooterView>(classType type: T.Type) {
        let nib = UINib(nibName: type.className, bundle: Bundle(for: type))
        register(nib, forHeaderFooterViewReuseIdentifier: type.className)
    }

    public func registerClass<T: UITableViewHeaderFooterView>(classType type: T.Type) {
        register(T.self, forHeaderFooterViewReuseIdentifier: type.className)
    }

    public func dequeueReusableCell<T: UITableViewCell>(classType type: T.Type, for indexPath: IndexPath) -> T {
        dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! T
    }

    public func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(classType type: T.Type) -> T {
        dequeueReusableHeaderFooterView(withIdentifier: type.className) as! T
    }
}
