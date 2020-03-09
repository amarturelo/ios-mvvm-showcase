//
// Created by Alberto Marturelo on 3/9/20.
// Copyright (c) 2020 Alberto Marturelo. All rights reserved.
//

import UIKit
import Swinject
import RxSwift
import Kingfisher

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

        self.mainView.emailLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.mailAction)))
        self.mainView.addressLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.mapAction)))
        self.mainView.phoneLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.callAction)))


        if self.people == nil {
            self.back()
        }
        self.observers()
        self.viewModel.configure(people: self.people)
    }

    @IBAction func mailAction(_ sender: Any) {
        let supportEmail = people?.email ?? ""
        if let emailURL = URL(string: "mailto:\(supportEmail)"), UIApplication.shared.canOpenURL(emailURL) {
            UIApplication.shared.open(emailURL, options: [:], completionHandler: nil)
        }
    }

    @IBAction func callAction(_ sender: Any) {
        guard   let number = people?.cell.to(type: .phoneNumber),
                let url = URL(string: "tel://\(number.onlyDigits())"),
                UIApplication.shared.canOpenURL(url) else {
            return
        }
        if #available(iOS 10, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }

    @IBAction func mapAction(_ sender: Any) {
        //let location = CLLocation.init(latitude: Double(people!.location.coordinates.latitude) as! CLLocationDegrees, longitude: Double(people!.location.coordinates.longitude) as! CLLocationDegrees)
        if (UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!)) {
            UIApplication.shared.openURL(URL(string:
            "comgooglemaps://?center=\(people!.location.coordinates.latitude),\(people!.location.coordinates.longitude)&zoom=14&views=traffic")!)
        } else {
            print("Can't use comgooglemaps://");
        }
        //navigateUsingAppleMaps(to: location, locationName: people!.name.first)
    }

    private func observers() {
        self.viewModel.peopleSubject
                .observeOn(MainScheduler.instance)
                .subscribe { event in
                    switch event {
                    case .next(let result):
                        self.updatePeopleUI(people: result)
                        break
                    case .error(_):
                        break
                    case .completed:
                        break

                    }
                }.disposed(by: self.disposeBag)

    }

    func updatePeopleUI(people: People) {
        self.mainView.updatePeople(people: people)
        self.configureNavigationBar(largeTitleColor: .black, backgroundColor: .white, tintColor: .blue, title: people.name.shortName(), preferredLargeTitle: true)
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
