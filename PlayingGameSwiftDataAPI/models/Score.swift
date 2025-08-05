//
//  Score.swift
//  PlayingGameSwiftDataAPI
//
//  Created by Fabrice Kouonang on 2025-08-05.
//

import Foundation
import SwiftData

@Model
class Score {
    var userName: String
    var score: Int
    var date: Date
    var picture: String?
    
    init(userName: String, score: Int, date: Date=Date.now, picture: String? = nil) {
        self.userName = userName
        self.score = score
        self.date = date
        self.picture = picture
    }
    
}
