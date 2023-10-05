//
//  ArticlesInteractor.swift
//  Exam
//
//  Created by mio on 2023/10/4.
//

import Foundation
import RxSwift
import ObserverSet
import Cleanse

class ArticleModelList {
    var articleModels: [ArticleModel] = []
    init(articleModels:[ArticleModel]) {
        self.articleModels = articleModels
    }
}

protocol ArticlesInteractorProtocol {
    var articlesDidChanged: ObserverSet<Void>{ get  }
    var fetchingStatusDidChanged: ObserverSet<Bool>{ get  }
    var articleModelList: ArticleModelList? { get  }
    
    func fetchArticles()
    func reloadArticleList()
    func cleanDatabase()
}

final class ArticlesInteractor: ArticlesInteractorProtocol {
    var articlesDidChanged: ObserverSet<Void> = ObserverSet()
    var fetchingStatusDidChanged: ObserverSet<Bool> = ObserverSet()
    var articleModelList: ArticleModelList?
    let disposeBag = DisposeBag()
    let articleDataProviderProperties:ArticleDataProviderProperties
    private let articleDataProvider: ArticleDataProviderProtocol
    
    init(articleDataProviderProperties: ArticleDataProviderProperties) {
        self.articleDataProviderProperties = articleDataProviderProperties
        self.articleDataProvider = ArticleDataProvider.init(articleDataProviderProperties: articleDataProviderProperties)
        
        articleDataProvider.isFetching.subscribe { isFetching in
            if isFetching == false {
                self.reloadArticleList()
            }
            self.fetchingStatusDidChanged.notify(isFetching)
                
        } onError: { error in
            
        } onCompleted: {
            
        } onDisposed: {
            
        }.disposed(by: disposeBag)
    }
    
    func isFetching() -> Bool {
        let isFetching = try? articleDataProvider.isFetching.value()
        return isFetching ??  false
    }
    
    func cleanDatabase() {
        articleDataProvider.deleteAllArticles()
        reloadArticleList()
    }
    
    func reloadArticleList() {
        let articleModels = articleDataProvider.getArticleModels()
        articleModelList = ArticleModelList(articleModels: articleModels)
        articlesDidChanged.notify()
    }
    
    func fetchArticles() {
        articleDataProvider.fetchArticles()
    }
}


