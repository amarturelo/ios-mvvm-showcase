//
//  BaseViewController.swift
//  ALPeople
//
//  Created by Alberto Marturelo on 3/9/20.
//  Copyright © 2020 Alberto Marturelo. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController{
    fileprivate let compositeDisposable = CompositeDisposable()
    internal let disposeBag = DisposeBag()
    
    func cleaned() {
        self.compositeDisposable.disposed(by: disposeBag)
    }
}

