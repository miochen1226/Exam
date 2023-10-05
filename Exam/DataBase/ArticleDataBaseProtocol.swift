//
//  ArticleDataBaseProtocol.swift
//  Exam
//
//  Created by mio on 2023/10/5.
//

import Foundation

public protocol ArticleDataBaseProtocol {
    func getArticleModels()->[Article]
    func deleteAllArticles()
    func saveArticles(articles:[Article])
}
