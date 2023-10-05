//
//  ArticleTest.swift
//  ExamTests
//
//  Created by mio on 2023/10/3.
//

import XCTest
@testable import Exam
import RealmSwift
import SwiftyJSON


class ArticleTest: XCTestCase {

    override func setUp() {
        super.setUp()
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //1.Load article from json file,
    //2.save to realm ,
    //3.query article
    func testExample() throws {
        let path = Bundle(for: ExamTests.self).path(forResource: "Article", ofType: "json")!
        let jsonString = try? String(contentsOfFile: path, encoding: String.Encoding.utf8)
        let json = JSON(parseJSON: jsonString!)
        
        let article = Article.init(json: json)
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(article)
        }
        
        let articleRead = realm.objects(Article.self).first(where: { $0.title == "Turkey launches airstrikes against Kurdish militants following deadly Ankara blast - CNN" })!
        
        XCTAssert(articleRead.source?.id == "cnn")
        XCTAssert(articleRead.source?.name == "CNN")
        XCTAssert(articleRead.author == "Gul Tuysuz, Heather Law, Kathleen Magramo")
        XCTAssert(articleRead.title == "Turkey launches airstrikes against Kurdish militants following deadly Ankara blast - CNN")
        XCTAssert(articleRead.descript == "Turkey’s military carried out airstrikes targeting Kurdish militants in northern Iraq on Sunday, just hours after the Kurdistan Workers’ Party (PKK) claimed responsibility for a deadly bombing in the capital in the latest attack of its nearly four-decade long…")
        XCTAssert(articleRead.url == "https://www.cnn.com/2023/10/02/middleeast/turkey-airstrike-iraq-kurdish-pkk-ankara-bomb-intl/index.html")
        XCTAssert(articleRead.urlToImage == "https://media.cnn.com/api/v1/images/stellar/prod/231002104357-01-turkey-bomb-attack.jpg?c=16x9&q=w_800,c_fill")
        XCTAssert(articleRead.content == "Turkeys military carried out airstrikes targeting Kurdish militants in northern Iraq on Sunday, just hours after the Kurdistan Workers Party (PKK) claimed responsibility for a deadly bombing in the c… [+2831 chars]")
    }
    
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
