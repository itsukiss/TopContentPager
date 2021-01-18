//
//  PagerItemView.swift
//  TopContentPager
//
//  Created by 田中厳貴 on 2021/01/08.
//

import UIKit

final public class PagerItemView: UIView {
    private var backView = UIView()
    private var titleLabel = UILabel()
    private var badgeView = UIView()
    
    var activeColor: UIColor = UIColor.black
    var deactveColor: UIColor = UIColor.gray
    var activeBackgroundColor: UIColor = UIColor.clear

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(backView)
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: topAnchor),
            backView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        
        badgeView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(badgeView)
        NSLayoutConstraint.activate([
            badgeView.widthAnchor.constraint(equalToConstant: 10),
            badgeView.heightAnchor.constraint(equalToConstant: 10),
            badgeView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 3),
            badgeView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 3)
        ])
    }
    
    
    private lazy var setupLayout: Void = {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 13)
        titleLabel.textColor = UIColor.black
        badgeView.isHidden = true
        badgeView.layer.cornerRadius = badgeView.frame.height / 2
        badgeView.clipsToBounds = true
        badgeView.backgroundColor = UIColor.red
    }()
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        _ = setupLayout
    }
    
    public var isSelected: Bool = false {
        didSet {
            if isSelected {
                titleLabel.textColor = activeColor
                backView.backgroundColor = activeBackgroundColor
            } else {
                titleLabel.textColor = deactveColor
                backView.backgroundColor = .clear
            }
        }
    }

    public func configure(with res: PagerItem) {
        self.titleLabel.text = res.title
    }

    public func badge(isHidden: Bool) {
        self.badgeView.isHidden = isHidden
    }
}

