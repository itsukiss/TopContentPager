import UIKit

public protocol PagerItemView: UIView {
    var activeColor: UIColor { get set }
    var deactiveColor: UIColor { get set }
    var activeBackgroundColor: UIColor { get set }
    var isSelected: Bool { get set }

    func badge(isHidden: Bool)
}
