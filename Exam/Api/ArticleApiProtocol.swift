//
//  ArticleApiProtocol.swift
//  Exam
//
//  Created by mio on 2023/10/5.
//

import Foundation

public protocol ArticleApiProtocol {
    func fetchArticles(completion: @escaping (Data?, Error?) -> ())
}
