//
//  NotificationTableCell.swift
//  Sample
//
//  Created by 田中厳貴 on 2021/01/27.
//

import UIKit

final class NotificationTableCell: UITableViewCell {
    
    @IBOutlet private weak var contentImageView: UIImageView! {
        didSet {
            contentImageView.layer.cornerRadius = contentImageView.frame.height / 2
            contentImageView.clipsToBounds = true
        }
    }
    @IBOutlet private weak var notificationLabel: UILabel!
    
    func prepare(text: String) {
        contentImageView.image = UIImage(named: "noman")
        notificationLabel.text = text
    }
}
