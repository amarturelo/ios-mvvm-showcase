//
// Created by Alberto Marturelo on 3/9/20.
// Copyright (c) 2020 Alberto Marturelo. All rights reserved.
//

import UIKit

class PeopleDetailsViewController: BaseViewController {

    var people: People!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    static func create(people: People) -> PeopleDetailsViewController {
        let vc = PeopleDetailsViewController()
        vc.people = people
        return vc
    }
}
