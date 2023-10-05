//
//  ArticlesViewModel.swift
//  Exam
//
//  Created by mio on 2023/10/4.
//

import Foundation
import RxSwift
import RxCocoa
import ObserverSet

class ArticlesViewModel : ObservableObject {
    private let interactor: ArticlesInteractorProtocol
    private let coordinator: ArticlesCoordinatorProtocol
    let dataSource = BehaviorRelay(value: [ArticleModel]())
    let isFetching = BehaviorSubject(value: false)
    var title = ""
    private var timer:Disposable?
    
    init(interactor: ArticlesInteractorProtocol, coordinator: ArticlesCoordinatorProtocol,title:String) {
        self.interactor = interactor
        self.coordinator = coordinator
        self.title = title
        
        self.interactor.articlesDidChanged.add(DispatchQueue.main) { Void in
            self.reloadDataSource()
        }
        
        self.interactor.fetchingStatusDidChanged.add(DispatchQueue.main) { isFetching in
            self.isFetching.onNext(isFetching)
        }
        
        self.reloadArticleList()
        self.fetchArticles()
        startTimer()
    }
    
    private func startTimer() {
        self.timer = Observable<Int>.interval(.seconds(30), scheduler:MainScheduler.instance).subscribe(onNext: { [weak self] value in
            self?.fetchArticles()
        }, onCompleted: {
            
        })
    }
    
    deinit {
        timer?.dispose()
    }
    
    private func reloadDataSource() {
        let articleModels:[ArticleModel] = interactor.articleModelList?.articleModels ?? []
        dataSource.accept(articleModels)
    }
    
    private func reloadArticleList() {
        interactor.reloadArticleList()
    }
    
    func cleanDatabase() {
        self.interactor.cleanDatabase()
    }
    
    func fetchArticles() {
        interactor.fetchArticles()
    }
    
    //TODO not use now
    func enterArticle(dataIndex:Int) {
        //Call coordinator.present to enter detail page
    }
}
