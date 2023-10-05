//
//  Article.swift
//  Exam
//
//  Created by mio on 2023/10/4.
//

import UIKit
import RealmSwift

class Source: Object {
    @Persisted var id:String?
    @Persisted var name:String?
}

public class Article: Object {
    @Persisted var source:Source?
    @Persisted var author:String?
    @Persisted var title:String?
    
    //src field 'description' in json
    @Persisted var descript:String?
    
    @Persisted var url:String?
    @Persisted var urlToImage:String?
    @Persisted var publishedAt:String?
    @Persisted var content:String?
    
    //Restore 'descript' as 'description', original source field name in json
    override class public func propertiesMapping() -> [String: String] {
            ["descript": "description"]
    }
}
