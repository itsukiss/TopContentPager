//
//  NSObject+NibLoading.swift
//  Sample
//
//  Created by 田中厳貴 on 2021/01/13.
//

import UIKit

extension NSObject {

    /// nibファイルから自身のインスタンスを取得。
    /// 引数に誤りがある（例：存在しないファイル名を指定する）と実行時エラーになるので注意。
    ///
    /// - Parameters:
    ///   - nameOrNil: nilの場合は自身のクラス名（例えばUIViewなら"UIView"に相当）。非nilの場合は`UINib.init(nibName:,bundle:)`のと同じ。
    ///   - bundleOrNil: `UINib.init(nibName:,bundle:)`のと同じ。
    ///   - ownerOrNil: `UINib.instantiate(withOwner:,options:)`のと同じ。
    ///   - optionsOrNil: `UINib.instantiate(withOwner:,options:)`のと同じ。
    /// - Returns: nibファイルから最初に見つかった自身のインスタンス。
    ///
    /// 例：
    /// ```
    /// // MyView.nibからロード。
    /// let myView: MyView = MyView.instantiate()
    /// ```
    /// - SeeAlso: UINib
    class func instantiate(nibName nameOrNil: String? = nil, bundle bundleOrNil: Bundle? = nil, withOwner ownerOrNil: Any? = nil, options optionsOrNil: [UINib.OptionsKey: Any]? = nil) -> Self {
        let nibName = (nameOrNil ?? "\(self)")
        return UINib.instantiate(type: self, nibName: nibName, bundle: bundleOrNil ?? Bundle(for: self), withOwner: ownerOrNil, options: optionsOrNil)!
    }
}

extension UINib {

    /// `instantiate()`返り値から指定Typeのインスタンスのみを返す。
    ///
    /// - Parameters:
    ///   - type: 取得したいType。
    ///   - name: `UINib.init(nibName:,bundle:)`のと同じ。
    ///   - bundleOrNil: `UINib.init(nibName:,bundle:)`のと同じ。
    ///   - ownerOrNil: `UINib.instantiate(withOwner:,options:)`のと同じ。
    ///   - optionsOrNil: `UINib.instantiate(withOwner:,options:)`のと同じ。
    /// - Returns: 最初に見つかったインスタンス。無かった場合はnil。
    /// - SeeAlso: UINib
    class func instantiate<T>(type: T.Type, nibName name: String, bundle bundleOrNil: Bundle?, withOwner ownerOrNil: Any?, options optionsOrNil: [UINib.OptionsKey: Any]? = nil) -> T? {

        for any in self.init(nibName: name, bundle: bundleOrNil).instantiate(withOwner: ownerOrNil, options: optionsOrNil) {
            if let obj = any as? T {
                return obj
            }
        }
        return nil
    }
}
