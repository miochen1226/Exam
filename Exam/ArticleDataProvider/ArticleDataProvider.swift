//
//  ArticleDataProvider.swift
//  Exam
//
//  Created by mio on 2023/10/5.
//

import Foundation
import SwiftyJSON
import RxSwift

class ArticleDataProvider: ArticleDataProviderProtocol {
    
    let articleDataProviderProperties: ArticleDataProviderProperties
    
    init(articleDataProviderProperties: ArticleDataProviderProperties) {
        self.articleDataProviderProperties = articleDataProviderProperties
    }
    
    var isFetching = BehaviorSubject(value: false)
    
    func getArticleModels()->[ArticleModel] {
        var articleModels:[ArticleModel] = []
        for article in  self.articleDataProviderProperties.articleDataBase.getArticleModels() {
            let articleModel = ArticleModel.init(article: article)
            articleModels.append(articleModel)
        }
        return articleModels
    }
    
    func fetchArticles() {
        fetchArticles() { (articles, error) in
            self.handleRecriveArticles(articles: articles)
        }
    }
    
    func deleteAllArticles() {
        articleDataProviderProperties.articleDataBase.deleteAllArticles()
    }
    
    func saveToDataBase(articles:[Article]) {
        articleDataProviderProperties.articleDataBase.saveArticles(articles:articles)
    }
    
    func fetchArticles(completion: @escaping ([Article], Error?) -> ()) {
        isFetching.onNext(true)
        articleDataProviderProperties.articleApi.fetchArticles { data, error in
            if error == nil {
                let articles = self.dataToArticles(data: data)
                completion(articles,error)
            }
            else {
                completion([],error)
            }
            self.isFetching.onNext(false)
        }
    }
    
    func handleRecriveArticles(articles:[Article]) {
        saveToDataBase(articles: articles)
    }
    
    func dataToArticles(data:Data?) -> [Article] {
        if data == nil {
            return []
        }
        
        let json = try? JSON(data: data!)
        var articles:[Article] = []
        for articleJsonObj in json?["articles"].arrayValue ?? [] {
            let article = Article.init(json: articleJsonObj)
            articles.append(article)
        }
        return articles
    }
}
