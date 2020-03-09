//
// Created by Alberto Marturelo on 3/9/20.
// Copyright (c) 2020 Alberto Marturelo. All rights reserved.
//

import RxSwift

protocol PeopleClient {
    func peoples(page: Int, limit: Int) -> Single<[People]>
}
