//
//  ArticleDataProviderProtocol.swift
//  Exam
//
//  Created by mio on 2023/10/5.
//

import Foundation
import RxSwift

public protocol ArticleDataProviderProtocol {
    var isFetching:BehaviorSubject<Bool> { get }
    func getArticleModels()->[ArticleModel]
    func fetchArticles()
    func deleteAllArticles()
}
