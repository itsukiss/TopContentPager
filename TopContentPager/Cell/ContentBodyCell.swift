//
//  ContentBodyCell.swift
//  TopContentPager
//
//  Created by 田中厳貴 on 2021/01/08.
//

import UIKit

final class ContentBodyCell: UITableViewCell {
    
    private weak var bodyViewController: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func prepare(viewController: UIViewController) {
        guard bodyViewController == nil else { return }
        bodyViewController = viewController
        self.addSubview(viewController.view)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewController.view.topAnchor.constraint(equalTo: self.topAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            viewController.view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            viewController.view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}
