//
//  Page3ViewController.swift
//  Sample
//
//  Created by 田中厳貴 on 2021/01/26.
//

import UIKit
import TopContentPager

final class Page3ViewController: UIViewController, ContentTableBody {
    enum Const {
        static let margin: CGFloat = 16
        static let itemSpace: CGFloat = 8
        static let itemHeight: CGFloat = 200
    }
    
    var pageTitle: String = "page3"
    
    var scrollView: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            scrollView = collectionView
        }
    }
    
    static func create() -> Self {
        Storyboard.instantiate(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        setup()
    }
    
    private func setup() {
        collectionView.register(UINib(nibName: "Page3CollectionCell", bundle: nil), forCellWithReuseIdentifier: "p3Cell")
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.width / 2 - ((Const.margin * 2 + Const.itemSpace) / 2), height: Const.itemHeight)
        layout.sectionInset = UIEdgeInsets(top: Const.margin, left: Const.margin, bottom: Const.margin, right: Const.margin)
        layout.minimumInteritemSpacing = Const.itemSpace
        collectionView.collectionViewLayout = layout
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }
}

extension Page3ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "p3Cell", for: indexPath) as! Page3CollectionCell
        return cell
    }
    
    
}
