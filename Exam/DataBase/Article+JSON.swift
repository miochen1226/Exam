//
//  Article+JSON.swift
//  Exam
//
//  Created by mio on 2023/10/4.
//

import Foundation
import SwiftyJSON

extension Article {
    convenience init(json:JSON){
        var jsonModifyed = json
        jsonModifyed["descript"] = json["description"]
        self.init(value: jsonModifyed.dictionaryObject as Any)
    }
}
