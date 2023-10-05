//
//  RealmHelper.swift
//  Exam
//
//  Created by mio on 2023/10/4.
//

import UIKit
import RealmSwift

class RealmHelper: NSObject {
    static let shared = RealmHelper()
    private override init(){
        
    }
    
    func getArticles()->[Article] {
        let realm = try! Realm()
        var articles:[Article] = []
        for article in Array(realm.objects(Article.self)) {
            articles.append(article)
        }
        return articles
    }
    
    func deleteAllArticles() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func saveArticles(articles:[Article]) {
        deleteAllArticles()
        let realm = try! Realm()
        try! realm.write {
            for article in articles {
                realm.add(article)
            }
        }
    }
}
