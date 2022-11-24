//
//  CompletableUseCase.swift
//  MyApp
//
//  Created by Manh Pham on 24/11/2022.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa
import MPInjector
import Networking

class CompletableUseCase<P>: UseCase {
    
    var cacheParams: P?
    
    @Inject var connectivityService: ConnectivityService
    
    private let _processing = BehaviorRelay(value: false)
    var processing: Driver<Bool> {
        _processing
            .asDriver()
    }

    private let _succeeded = PublishSubject<Void>()
    var succeeded: Driver<Void> {
        _succeeded
            .asDriverOnErrorJustComplete()
    }

    private let _failed = PublishSubject<Error>()
    var failed: Driver<Error> {
        _failed
            .asDriverOnErrorJustComplete()
    }
    
    private let bag = DisposeBag()
    
    func buildUseCase(params: P) -> Completable { // swiftlint:disable:this unavailable_function
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
            .subscribe(onCompleted: { [weak self] in
                self?._succeeded.onNext(())
                self?._processing.accept(false)
            }, onError: { [weak self] error in
                self?._failed.onNext(error)
                self?._processing.accept(false)
            })
            .disposed(by: bag)

    }
}
