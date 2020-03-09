//
// Created by Alberto Marturelo on 3/9/20.
// Copyright (c) 2020 Alberto Marturelo. All rights reserved.
//

import Foundation
import XCTest

extension XCUIApplication {
    var isDisplayPeopleDetails: Bool {
        otherElements["PeopleDetailsViewController"].exists
    }
}
