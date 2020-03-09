//
// Created by Alberto Marturelo on 3/9/20.
// Copyright (c) 2020 Alberto Marturelo. All rights reserved.
//

@testable import ALPeople
import RxSwift

class MockPeopleRepository: PeopleRepository {
    var peoplesVisitor = false
    var peoplesReturn: Single<[People]> = Single<[People]>.just([])

    func peoples(page: Int, limit: Int) -> Single<[People]> {
        peoplesVisitor = true
        return peoplesReturn
    }

}
