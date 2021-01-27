//
//  Page2ViewController.swift
//  Sample
//
//  Created by 田中厳貴 on 2021/01/13.
//

import UIKit
import TopContentPager

final class Page2ViewController: UIViewController, ContentTableBody {
    var pageTitle: String = "お知らせ"
    
    private var mockData: [String] = []
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
        tableView.register(UINib(nibName: "NotificationTableCell", bundle: nil), forCellReuseIdentifier: "NotificationTableCell")
        
        for _ in 0...20 {
            let user = "user\(Int.random(in: 100000 ... 999999))"
            let noti = MockData.notiList.randomElement() ?? ""
            mockData.append("\(user)\(noti)")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
}

extension Page2ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mockData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableCell", for: indexPath) as! NotificationTableCell
        cell.prepare(text: mockData[indexPath.row])
        return cell
    }
}
