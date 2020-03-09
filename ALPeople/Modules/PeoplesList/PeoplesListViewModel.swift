//
//  PeoplesListViewModel.swift
//  ALPeople
//
//  Created by Alberto Marturelo on 3/9/20.
//  Copyright © 2020 Alberto Marturelo. All rights reserved.
//

import RxSwift

class PeoplesListViewModel: BaseViewModel {

    internal var page: Int = 1
    internal var limit: Int = 30

    let peoples = BehaviorSubject<[People]>(value: [])
    private let searchText = BehaviorSubject<String>(value: "")

    let error = PublishSubject<Error>()

    let peopleRepository: PeopleRepository

    init(peopleRepository: PeopleRepository) {
        self.peopleRepository = peopleRepository
    }

    func fetch() {
        self.page = 1
        
        self.cleaned()
        
        Observable.combineLatest(self.searchText, peopleRepository.peoples(page: self.page, limit: limit).asObservable()) { (text: String, result: [People]) -> [People] in
                    self.filter(peoples: result, filter: text)
                }
                .subscribe { (event: Event<[People]>) in
                    switch event {
                    case .next(let results):
                        self.peoples.onNext(results)
                        break
                    case .error(let error):
                        self.handleError(error: error)
                        break
                    case .completed:
                        break
                    }
                }.disposed(by: self.disposeBag)
    }

    internal func filter(peoples: [People], filter: String) -> [People] {
        if filter.isEmpty {
            return peoples
        }
        return peoples.filter { people in
            people.name.fullName().lowercased().contains(filter)
        }
    }

    func search(text: String) {
        self.searchText.onNext(text)
    }

    func nextPage() {
        
        if !(try! searchText.value().isEmpty){
            return
        }
        
        self.page += 1
        peopleRepository.peoples(page: self.page, limit: limit)
                .subscribe({ event in
                    switch event {
                    case .success(let peoples):
                        try! self.peoples.onNext(self.peoples.value() + peoples)
                    case .error(let error):
                        self.handleError(error: error)
                        break
                    }
                })
                .disposed(by: self.disposeBag)
    }

    internal func handleError(error: Error) {
        self.error.onNext(error)
    }
}
