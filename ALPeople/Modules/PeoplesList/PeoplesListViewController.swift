//
//  PeoplesListViewController.swift
//  ALPeople
//
//  Created by Alberto Marturelo on 3/9/20.
//  Copyright © 2020 Alberto Marturelo. All rights reserved.
//

import Foundation
import UIKit
import Swinject
import RxCocoa
import Kingfisher

class PeoplesListViewController: BaseViewController {

    let viewModel = Container.sharedContainer.resolve(PeoplesListViewModel.self)!


    fileprivate var mainView: PeoplesListView {
        return self.view as! PeoplesListView
    }

    override func loadView() {
        setupSearchController()

        self.view = PeoplesListView()
    }

    private func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search peoples"
        //searchController.searchBar.tintColor = .blue
        //searchController.searchBar.scopeButtonTitles = ["ALL","Mrs","Miss","Mr"]
        self.navigationItem.searchController = searchController
    }

    override func viewDidLoad() {
        self.setupTableView()
        self.configureNavigationBar(largeTitleColor: .black, backgroundColor: .white, tintColor: .blue, title: "Peoples", preferredLargeTitle: true)

        self.observers()

        self.fetch()
    }

    //biding
    func observers() {
        self.viewModel.peoples.bind(to: mainView.tableView.rx.items(cellIdentifier: PeopleTableViewCell.reuseIdentifier)) { (index, model: People, cell: PeopleTableViewCell) in
                    cell.configure(people: model)
                }
                .disposed(by: disposeBag)

        /*mainView.tableView.rx.modelSelected(People.self)
                .subscribe { event in
                    switch event {
                    case .next(let value):
                        print(value)
                        break
                    case .error(_):
                        break
                    case .completed:
                        break
                    @unknown default:
                        break
                    }
                }.disposed(by: disposeBag)*/
    }

    private func setupTableView() {
        self.mainView.tableView.delegate = self
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .black
        refreshControl.addTarget(self, action: #selector(refreshListData(_:)), for: .valueChanged)
        if #available(iOS 10.0, *) {
            self.mainView.tableView.refreshControl = refreshControl
        } else {
            self.mainView.tableView.addSubview(refreshControl)
        }
    }

    @objc private func refreshListData(_ sender: Any) {
        self.mainView.tableView.refreshControl?.endRefreshing()
        self.fetch()
    }

    private func fetch() {
        self.viewModel.fetch()
    }

    deinit {
        self.viewModel.cleaned()
        self.cleaned()
    }
}

extension PeoplesListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        self.viewModel.search(text: searchController.searchBar.text?.lowercased() ?? "")
    }
}

extension PeoplesListViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = tableView.dataSource!.tableView(tableView, numberOfRowsInSection: indexPath.section) - 1
        if indexPath.row == lastElement {
            self.viewModel.nextPage()
            //self.viewModel.add(event: FetchNextPeoplesListEvent())
        }
    }
}
