//
// Created by Alberto Marturelo on 3/9/20.
// Copyright (c) 2020 Alberto Marturelo. All rights reserved.
//

import RxSwift

class PeopleDetailsViewModel: BaseViewModel {

    private var people: People!

    let nameSubject = ReplaySubject<Name>.create(bufferSize: 1)

    let avatarSubject = ReplaySubject<String>.create(bufferSize: 1)

    func configure(people: People) {
        nameSubject.onNext(people.name)
        avatarSubject.onNext(people.picture.large)
    }

}
