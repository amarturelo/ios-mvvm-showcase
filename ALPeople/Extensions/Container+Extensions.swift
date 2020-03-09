//
//  Container+Extensions.swift
//  ALPeople
//
//  Created by Alberto Marturelo on 3/9/20.
//  Copyright © 2020 Alberto Marturelo. All rights reserved.
//

import Swinject
import Moya

extension Container {
    static let sharedContainer: Container = {
        let container = Container()

        container.register(PeopleRepository.self) { resolver in
            PeopleRepositoryImpl()
        }.inObjectScope(.container)

        container.register(PeoplesListViewModel.self) { resolver in
            PeoplesListViewModel(peopleRepository: resolver.resolve(PeopleRepository.self)!)
        }

        return container
    }()
}
