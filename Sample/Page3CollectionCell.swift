//
//  Page3CollectionCell.swift
//  Sample
//
//  Created by 田中厳貴 on 2021/01/27.
//

import UIKit

class Page3CollectionCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .gray
        layer.cornerRadius = 8
        clipsToBounds = true
    }
}
