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
        let topContentVC = CustomTopContentPagerViewController()
        topContentVC.modalPresentationStyle = .fullScreen
        present(topContentVC, animated: true, completion: nil)
    }
}

