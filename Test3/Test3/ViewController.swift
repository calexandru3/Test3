//
//  ViewController.swift
//  Test3
//
//  Created by Bogdan Marica on 05/12/2019.
//  Copyright © 2019 Florin Precup. All rights reserved.
//

import UIKit
import EmptyDataSet_Swift


class ViewController: UIViewController, EmptyDataSetSource, EmptyDataSetDelegate {

    @IBOutlet weak var tableView: UITableView!

    let dataSource:Array<String> = {
        let arry = Array<String>()

        return arry
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.emptyDataSetView { view in
            view.titleLabelString(NSAttributedString(string: "Niciun oras inserat in lista de preferinte!"))
        }
    }

    @IBAction func addCity(_ sender: Any) {
    }
}

extension ViewController: UITableViewDelegate {

}

extension ViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }


}
