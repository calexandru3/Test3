//
//  CellWithField.swift
//  Test3
//
//  Created by Bogdan Marica on 05/12/2019.
//  Copyright © 2019 Florin Precup. All rights reserved.
//

import UIKit

class CellWithField: UITableViewCell {

    var textForField:String?{
        didSet{
            guard let text = textForField else {return}
            field.text = text
        }
    }

    var deleteDelegate:DeleteCell?
    var indexPath:IndexPath?

    lazy var button:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "xIcon"), for: .normal)
        button.addTarget(self, action: #selector(handleDelete), for: .touchUpInside)
        
        return button
    }()

    @objc func handleDelete(){
        deleteDelegate?.deleteCell(indexPath: self.indexPath!)
    }

    let field:UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.borderWidth = 1.0

        return field
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        field.delegate = self
        setUp()
    }

    fileprivate func setUp(){
        self.addSubview(field)
        self.addSubview(button)

        field.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor).isActive = true
        field.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        field.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -70).isActive = true

        button.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true


    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CellWithField: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        deleteDelegate?.addTextToDataSource(indexPath: self.indexPath!, text: field.text!)
    }
}
