//
//  BaseViewModel.swift
//  ALPeople
//
//  Created by Alberto Marturelo on 3/9/20.
//  Copyright © 2020 Alberto Marturelo. All rights reserved.
//

import RxSwift

class BaseViewModel {
    internal let disposeBag = DisposeBag()
    internal let compositeDisposable = CompositeDisposable()
    
    func cleaned(){
        self.compositeDisposable.disposed(by: disposeBag)
    }
}
