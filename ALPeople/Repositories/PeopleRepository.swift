//
//  PeopleRepository.swift
//  ALPeople
//
//  Created by Alberto Marturelo on 3/9/20.
//  Copyright © 2020 Alberto Marturelo. All rights reserved.
//

import Foundation
import RxSwift

protocol PeopleRepository {
    func peoples(page: Int, limit: Int)->Single<[People]>
}
