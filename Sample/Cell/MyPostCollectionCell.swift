//
//  MyPostCollectionCell.swift
//  Sample
//
//  Created by 田中厳貴 on 2021/01/27.
//

import UIKit

class MyPostCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var postImageView: UIImageView! {
        didSet {
            postImageView.contentMode = .scaleAspectFill
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
    
    func prepare(image: UIImage) {
        postImageView.image = image
    }
}
