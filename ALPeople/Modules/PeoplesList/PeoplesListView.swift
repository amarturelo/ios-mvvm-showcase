//
//  PeoplesListView.swift
//  ALPeople
//
//  Created by Alberto Marturelo on 3/9/20.
//  Copyright © 2020 Alberto Marturelo. All rights reserved.
//

import UIKit
import FlexLayout
import PinLayout

class PeoplesListView: UIView {
    private var rootFlexContainer = UIView()

    let tableView: UITableView = UITableView()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        tableView.backgroundColor = .white
        //tableView.allowsSelection = false
        tableView.register(PeopleTableViewCell.self, forCellReuseIdentifier: PeopleTableViewCell.reuseIdentifier)

        addSubview(tableView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.pin.all()
    }
}
