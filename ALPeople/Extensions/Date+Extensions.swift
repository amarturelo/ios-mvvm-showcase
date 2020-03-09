//
// Created by Alberto Marturelo on 3/9/20.
// Copyright (c) 2020 Alberto Marturelo. All rights reserved.
//

import Foundation

extension Date {
    func prettyDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMMd, YYYY")

        return dateFormatter.string(from: self)
    }
}