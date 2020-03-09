//
// Created by Alberto Marturelo on 3/9/20.
// Copyright (c) 2020 Alberto Marturelo. All rights reserved.
//

import RxSwift

import RxSwift
import Moya

class PeopleClientImpl: PeopleClient {

    let peopleService: MoyaProvider<PeopleService>

    init(peopleService: MoyaProvider<PeopleService>) {
        self.peopleService = peopleService
    }

    func peoples(page: Int, limit: Int) -> Single<[People]> {
        Single.create { observer in

            self.peopleService.request(.peoples(page: page, limit: limit)) { result in
                switch result {
                case .success(let response):
                    do {
                        try response.filterSuccessfulStatusCodes()
                        let data = try response.mapJSON() as! [String: Any]
                        let list = data["results"] as! [[String: Any]]
                        let peoples = list.map { dictionary -> People in
                            People.init(json: dictionary)
                        }
                        observer(.success(peoples))

                    } catch let e {
                        observer(.error(e))
                    }
                    break
                case .failure(let error):
                    observer(.error(error))
                    break
                }
            }

            return Disposables.create()
        }
    }

}
