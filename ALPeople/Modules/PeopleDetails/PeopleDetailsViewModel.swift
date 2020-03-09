//
// Created by Alberto Marturelo on 3/9/20.
// Copyright (c) 2020 Alberto Marturelo. All rights reserved.
//

import RxSwift

class PeopleDetailsViewModel: BaseViewModel {

    private var people: People!

    let peopleSubject = ReplaySubject<People>.create(bufferSize: 1)

    func configure(people: People) {
        peopleSubject.onNext(people)
    }

}
