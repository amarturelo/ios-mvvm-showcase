//
//  PeopleRepositoryImpl.swift
//  ALPeople
//
//  Created by Alberto Marturelo on 3/9/20.
//  Copyright © 2020 Alberto Marturelo. All rights reserved.
//

import RxSwift

class PeopleRepositoryImpl: PeopleRepository {

    let peopleClient: PeopleClient

    init(peopleClient: PeopleClient) {
        self.peopleClient = peopleClient
    }

    func peoples(page: Int = 1, limit: Int = 30) -> Single<[People]> {
        self.peopleClient.peoples(page: page, limit: limit)
    }

}
