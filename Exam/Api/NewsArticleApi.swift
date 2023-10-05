//
//  NewsArticleApi.swift
//  Exam
//
//  Created by mio on 2023/10/5.
//

import Foundation
import Moya

class NewsArticleApi: ArticleApiProtocol {
    func fetchArticles(completion: @escaping (Data?, Error?) -> ()) {
        let provider = MoyaProvider<NewsApi>()
        provider.request(.topHeadLine) { result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                completion(data, nil)
                break
            case let .failure(error):
                completion(nil, error)
                break
            }
        }
    }
}

public enum NewsApi {
    case topHeadLine
}

let apiKey = "f8bfa122dd4e489fab6d464371303fb1"

extension NewsApi: TargetType {
    public var baseURL: URL { return URL(string: "https://newsapi.org/v2")! }
    
    public var path: String {
        switch self {
        case .topHeadLine:
            return "/top-headlines"
        }
    }
    public var method: Moya.Method {
        return .get
    }
    
    public var task: Task {
        switch self {
        case .topHeadLine:
            return .requestParameters(parameters: ["country": "us","apiKey":apiKey], encoding: URLEncoding.default)
        }
    }
    
    public var validationType: ValidationType {
        switch self {
        case .topHeadLine:
            return .successCodes
        }
    }
    
    public var headers: [String: String]? {
        return nil
    }
}
