//
// Created by Alberto Marturelo on 3/9/20.
// Copyright (c) 2020 Alberto Marturelo. All rights reserved.
//

import UIKit
import Swinject
import RxSwift

class PeopleDetailsViewController: BaseViewController {

    var people: People!

    let viewModel = Container.sharedContainer.resolve(PeopleDetailsViewModel.self)!

    fileprivate var mainView: PeopleDetailsView {
        return self.view as! PeopleDetailsView
    }

    override func loadView() {
        self.view = PeopleDetailsView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if self.people == nil {
            self.back()
        }
        self.observers()
        self.viewModel.configure(people: self.people)
    }

    private func observers() {
        self.viewModel.nameSubject
                .observeOn(MainScheduler.instance)
                .subscribe { event in
                    switch event {
                    case .next(let result):
                        self.updateNameUI(name: result)
                        break
                    case .error(_):
                        break
                    case .completed:
                        break

                    }
                }.disposed(by: self.disposeBag)
    }

    func updateNameUI(name: Name) {
        self.configureNavigationBar(largeTitleColor: .black, backgroundColor: .white, tintColor: .blue, title: name.shortName(), preferredLargeTitle: true)
    }

    private func back() {
        self.navigationController?.dismiss(animated: true)
    }

    static func create(people: People) -> PeopleDetailsViewController {
        let vc = PeopleDetailsViewController()
        vc.people = people
        return vc
    }
}
