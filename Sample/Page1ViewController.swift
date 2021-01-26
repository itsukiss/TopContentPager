//
//  Page1ViewController.swift
//  Sample
//
//  Created by 田中厳貴 on 2021/01/13.
//

import UIKit
import TopContentPager

final class Page1ViewController: UIViewController, ContentTableBody {
    var pageTitle: String = "Page1"
    
    var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            scrollView = tableView
        }
    }
    
    static func create() -> Self {
        Storyboard.instantiate(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
}

extension Page1ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "p1Cell")
        cell.textLabel?.text = "item\(indexPath.row)"
        return cell
    }
}
