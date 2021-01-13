//
//  ViewController.swift
//  Sample
//
//  Created by 田中厳貴 on 2021/01/08.
//

import UIKit
import TopContentPager

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let topContentVC = TopContentPagerViewController
            .create(with: .init(
                        topView: TopView.instantiate(),
                        pageItems: [
                            .init(title: "Page1", viewController: Page1ViewController.create()),
                            .init(title: "Page2", viewController: Page2ViewController.create())
                        ]))
        topContentVC.modalPresentationStyle = .fullScreen
        present(topContentVC, animated: true, completion: nil)
    }
}

