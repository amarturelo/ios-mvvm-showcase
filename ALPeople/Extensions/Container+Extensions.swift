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

        container.register(PeopleClient.self) { _ in
            //PeopleClientImpl(peopleService: MoyaProvider<PeopleService>(plugins: [NetworkLoggerPlugin()]))
            PeopleClientImpl(peopleService: MoyaProvider<PeopleService>())
        }

        container.register(PeopleRepository.self) { resolver in
            PeopleRepositoryImpl(peopleClient: resolver.resolve(PeopleClient.self)!)
        }.inObjectScope(.container)

        container.register(PeoplesListViewModel.self) { resolver in
            PeoplesListViewModel(peopleRepository: resolver.resolve(PeopleRepository.self)!)
        }

        container.register(PeopleDetailsViewModel.self) { resolver in
            PeopleDetailsViewModel()
        }

        return container
    }()
}
