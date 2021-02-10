//
//  DefaultPagerItemView.swift
//  TopContentPager
//
//  Created by 田中厳貴 on 2021/02/10.
//

import UIKit

final public class DefaultPagerItemView: UIView, PagerItemView {
    private var backView = UIView()
    private var titleLabel = UILabel()
    private var badgeView = UIView()
    private var stackView = UIStackView()
    private var imageView = UIImageView()
    
    public var activeColor: UIColor = UIColor.black
    public var deactiveColor: UIColor = UIColor.gray
    public var activeBackgroundColor: UIColor = UIColor.clear
    
    private var imageViewHeight: NSLayoutConstraint?
    private var imageViewWidth: NSLayoutConstraint?

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
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 4
        addSubview(stackView)
        let stackViewTrailing = stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        let stackViewLeading = stackView.leadingAnchor.constraint(equalTo: leadingAnchor)
        
        stackViewTrailing.priority = .defaultLow
        stackViewLeading.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackViewTrailing,
            stackViewLeading
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageViewHeight = imageView.heightAnchor.constraint(equalToConstant: 24)
        imageViewWidth = imageView.widthAnchor.constraint(equalToConstant: 24)
        
        NSLayoutConstraint.activate([
            imageViewHeight!,
            imageViewWidth!
        ])
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        
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
                imageView.tintColor = activeColor
                backView.backgroundColor = activeBackgroundColor
            } else {
                titleLabel.textColor = deactiveColor
                imageView.tintColor = deactiveColor
                backView.backgroundColor = .clear
            }
        }
    }

    public func configure(with res: PagerItem) {
        switch res {
        case .text(let textItem):
            self.titleLabel.isHidden = false
            self.imageView.isHidden = true
            self.titleLabel.text = textItem.title
            self.titleLabel.font = textItem.font
        case .image(let imageItem):
            self.titleLabel.isHidden = true
            self.imageView.isHidden = false
            self.imageView.image = imageItem.image?.withRenderingMode(.alwaysTemplate)
            self.imageViewHeight?.constant = imageItem.size.height
            self.imageViewWidth?.constant = imageItem.size.width
            self.imageView.layer.cornerRadius = imageItem.cornerRadius
            self.imageView.clipsToBounds = true
        case .textAndImage(let textItem, let imageItem):
            self.titleLabel.isHidden = false
            self.imageView.isHidden = false
            self.titleLabel.text = textItem.title
            self.titleLabel.font = textItem.font
            self.imageView.image = imageItem.image?.withRenderingMode(.alwaysTemplate)
            self.imageViewHeight?.constant = imageItem.size.height
            self.imageViewWidth?.constant = imageItem.size.width
            self.imageView.layer.cornerRadius = imageItem.cornerRadius
            self.imageView.clipsToBounds = true
        case .custom(_):
            break
        }
    }

    public func badge(isHidden: Bool) {
        self.badgeView.isHidden = isHidden
    }
}

