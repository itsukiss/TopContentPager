//
//  MyPostViewController.swift
//  Sample
//
//  Created by 田中厳貴 on 2021/01/26.
//

import UIKit
import TopContentPager

final class MyPostViewController: UIViewController, ContentTableBody {
    enum Const {
        static let margin: CGFloat = 2
        static let itemSpace: CGFloat = 1
    }
    
    var pageTitle: String = "投稿"
    
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
        collectionView.register(UINib(nibName: "MyPostCollectionCell", bundle: nil), forCellWithReuseIdentifier: "MyPostCollectionCell")
        let layout = UICollectionViewFlowLayout()
        let length = self.view.frame.width / 3 - ((Const.margin * 2 + Const.itemSpace * 2) / 2)
        layout.itemSize = CGSize(width: length, height: length)
        layout.sectionInset = UIEdgeInsets(top: Const.margin, left: Const.margin, bottom: Const.margin, right: Const.margin)
        layout.minimumInteritemSpacing = Const.itemSpace
        layout.minimumLineSpacing = Const.itemSpace * 2
        collectionView.collectionViewLayout = layout
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }
}

extension MyPostViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        MockData.postList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyPostCollectionCell", for: indexPath) as! MyPostCollectionCell
        cell.prepare(image: MockData.postList[indexPath.row])
        return cell
    }
}
