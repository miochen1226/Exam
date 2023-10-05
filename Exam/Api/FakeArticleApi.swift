//
//  FakeArticleApi.swift
//  Exam
//
//  Created by mio on 2023/10/5.
//

import Foundation

//Current not use, maybe for test using
class FakeArticleApi: ArticleApiProtocol {
    func fetchArticles(completion: @escaping (Data?, Error?) -> ()) {
        Thread.sleep(forTimeInterval: 5)
        completion(nil,nil)
    }
}
