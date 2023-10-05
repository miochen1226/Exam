//
//  ArticleModel.swift
//  Exam
//
//  Created by mio on 2023/10/3.
//

import UIKit

class SourceModel {
    var id:String?
    var name:String?
    init(source:Source?){
        self.id = source?.id
        self.name = source?.name
    }
}

public class ArticleModel {
    var source:SourceModel
    var author:String?
    var title:String?
    
    //src field 'description' in json
    var descript:String?
    
    var url:String?
    var urlToImage:String?
    var publishedAt:String?
    var content:String?
    
    init(article:Article) {
        self.source = SourceModel.init(source:article.source)
        self.author = article.author
        self.title = article.title
        self.descript = article.descript
        self.url = article.url
        self.urlToImage = article.urlToImage
        self.publishedAt = article.publishedAt
        self.content = article.content
    }
}
