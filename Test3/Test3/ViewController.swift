//
//  ViewController.swift
//  Test3
//
//  Created by Bogdan Marica on 05/12/2019.
//  Copyright © 2019 Florin Precup. All rights reserved.
//

import UIKit
import EmptyDataSet_Swift

protocol DeleteCell {
    func deleteCell(indexPath:IndexPath)
    func addTextToDataSource(indexPath:IndexPath,text:String)
}

class ViewController: UIViewController, EmptyDataSetSource, EmptyDataSetDelegate {

    @IBOutlet weak var tableView: UITableView!

    var dataSource:Array<String> = {
        var array = Array<String>()
        array.append("Bucharest")
        array.append("London")

        return array
    }()

    let activityIndicator:UIActivityIndicatorView = {
        let activitiy = UIActivityIndicatorView()
        activitiy.translatesAutoresizingMaskIntoConstraints = false

        return activitiy
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()

        self.view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        self.view.bringSubviewToFront(activityIndicator)
    }

    fileprivate func setUpTable(){
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        tableView.emptyDataSetView { view in
            view.titleLabelString(NSAttributedString(string: "Niciun oras inserat in lista de preferinte!"))
        }
        tableView.register(CellWithField.self, forCellReuseIdentifier: "cellWithField")
    }

    @IBAction func addCity(_ sender: Any) {
        dataSource.append("")
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath.init(row: dataSource.count-1, section: 0)], with: .automatic)
        tableView.endUpdates()
    }

    let dispatchGroup = DispatchGroup()

    @IBAction func fetch(_ sender: Any) {
        var models = Array<DataModel>()
        activityIndicator.startAnimating()
        for item in dataSource {
            API.sharedInstance.getData(forCity: item, dp: dispatchGroup) { (model) in
                models.append(model)
            }
        }

        dispatchGroup.notify(queue: .main){
            self.activityIndicator.stopAnimating()

            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "customPageView") as! CustomPageViewController
            var pages = Array<PageModel>()
            for model in models {
                let page = PageModel()
                page.dataModel = model
                pages.append(page)
            }
            controller.pages = pages
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}

extension ViewController: UITableViewDelegate {

}

extension ViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellWithField") as! CellWithField
        cell.deleteDelegate = self
        cell.indexPath = indexPath
        cell.textForField = dataSource[indexPath.item]
        return cell
    }
}

extension ViewController:DeleteCell{
    func addTextToDataSource(indexPath: IndexPath, text: String) {
        dataSource[indexPath.item] = text
    }

    func deleteCell(indexPath: IndexPath) {
        tableView.beginUpdates()
        self.dataSource.remove(at: indexPath.item)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }
}
