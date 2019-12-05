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

    let field:UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .red
        return field
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .green
        setUp()
    }

    fileprivate func setUp(){
        self.addSubview(field)

        field.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor).isActive = true
        field.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        field.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -100).isActive = true

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
