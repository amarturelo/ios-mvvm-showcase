//
// Created by Alberto Marturelo on 3/9/20.
// Copyright (c) 2020 Alberto Marturelo. All rights reserved.
//

import XCTest
@testable import ALPeople
import RxSwift
import RxTest
import RxBlocking

class TestPeoplesListViewModel: XCTestCase {

    var viewModel: PeoplesListViewModel?
    var mockPeopleRepository: MockPeopleRepository?

    override func setUp() {
        self.mockPeopleRepository = MockPeopleRepository();
        self.viewModel = PeoplesListViewModel(peopleRepository: mockPeopleRepository!);
    }

    func testVisitFetchRepository_WhenFetch() {
        mockPeopleRepository?.peoplesReturn = Single<[People]>.just([People(), People(), People()])

        let scheduler = TestScheduler(initialClock: 0)

        scheduler.scheduleAt(100) {
            _ = self.viewModel?.fetch()
        }

        scheduler.start()

        XCTAssertTrue(mockPeopleRepository?.peoplesVisitor ?? false)
    }

    func testFetchSuccess_WhenFetch() {
        mockPeopleRepository?.peoplesReturn = Single<[People]>.just([People(), People(), People()])

        let scheduler = TestScheduler(initialClock: 0)

        let observer1 = scheduler.createObserver(Any.self)

        scheduler.scheduleAt(100) {
            _ = self.viewModel?.fetch()
        }

        scheduler.start()

        let results = try! viewModel?.peoples.asObservable().toBlocking().first()

        XCTAssertTrue(results?.count == 3)
    }
}
