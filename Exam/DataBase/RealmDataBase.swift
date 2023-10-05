//
//  RealmDataBase.swift
//  Exam
//
//  Created by mio on 2023/10/5.
//

import Foundation

class RealmDataBase: ArticleDataBaseProtocol {
    func getArticleModels() -> [Article] {
        RealmHelper.shared.getArticles()
    }
    
    func deleteAllArticles() {
        RealmHelper.shared.deleteAllArticles()
    }
    
    func saveArticles(articles: [Article]) {
        RealmHelper.shared.saveArticles(articles: articles)
    }
}
