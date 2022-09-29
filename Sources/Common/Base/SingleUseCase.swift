//
//  SingleUseCase.swift
//  MyApp
//
//  Created by Manh Pham on 7/30/22.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa
import MPInjector

class SingleUseCase<P, R>: UseCase {
    
    var cacheParams: P?
    
    @Inject var connectivityService: ConnectivityService
    
    private let _processing = BehaviorRelay(value: false)
    var processing: Driver<Bool> {
        _processing
            .asDriver()
    }

    private let _succeeded = PublishSubject<R>()
    var succeeded: Driver<R> {
        _succeeded
            .asDriverOnErrorJustComplete()
    }

    private let _failed = PublishSubject<Error>()
    var failed: Driver<Error> {
        _failed
            .asDriverOnErrorJustComplete()
    }
    
    private let bag = DisposeBag()
    
    func buildUseCase(params: P) -> Single<R> { // swiftlint:disable:this unavailable_function
        fatalError("this is abstract")
    }
    
    final func execute(params: P) {
        cacheParams = params
        performedIfNeeded(params: params)
    }
    
    private func performedIfNeeded(params: P) {
        if _processing.value == true {
            _failed.onNext(AppError.actionAlreadyPerforming)
            return
        }
        if !connectivityService.isNetworkConnection {
            _failed.onNext(AppError.noInternetConnection)
            return
        }
        _processing.accept(true)
        buildUseCase(params: params)
            .subscribe(onSuccess: { [weak self] result in
                self?._succeeded.onNext(result)
                self?._processing.accept(false)
            }, onFailure: { [weak self] error in
                self?._failed.onNext(error)
                self?._processing.accept(false)
            })
            .disposed(by: bag)

    }
}
