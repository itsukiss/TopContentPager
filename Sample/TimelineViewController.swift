//
//  TimelineViewController.swift
//  Sample
//
//  Created by 田中厳貴 on 2021/01/13.
//

import UIKit
import TopContentPager

final class TimelineViewController: UIViewController, ContentTableBody {
    var pageTitle: String = "タイムライン"
    
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
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "TimelineTableCell", bundle: nil), forCellReuseIdentifier: "TimelineTableCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
}

extension TimelineViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MockData.postList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimelineTableCell", for: indexPath) as! TimelineTableCell
        cell.prepare(image: MockData.postList[indexPath.row])
        return cell
    }
}
