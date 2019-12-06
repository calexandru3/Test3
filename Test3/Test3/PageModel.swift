//
//  PageModel.swift
//  Test3
//
//  Created by Bogdan Marica on 06/12/2019.
//  Copyright © 2019 Florin Precup. All rights reserved.
//

import UIKit

class PageModel: UIViewController {

    var dataModel:DataModel?
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }

    fileprivate func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self

        tableView.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
}
extension PageModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataModel?.city
    }
}

extension PageModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if indexPath.item == 0 {
            cell.textLabel?.text = dataModel?.data1
        }
        if indexPath.item == 1 {
            cell.textLabel?.text = dataModel?.data2
        }

        return cell
    }
}
