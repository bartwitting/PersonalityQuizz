//
//  QuestionData.swift
//  PersonalityQuizz
//
//  Created by Bart Witting on 13/11/2018.
//  Copyright © 2018 Bart Witting. All rights reserved.
//

import Foundation

struct Question {
    var text : String
    var type : ResponseType
    var answers : [Answer]
    
    enum ResponseType {
        case single, multiple, ranged
    }
}

struct Answer {
    var text : String
    var type : Product
    
    /// An enumaration to define the result
    enum Product: Character {
        case watch = "⌚️", iphone = "📱", macbook = "💻", imac = "🖥"
        
        var definition : String {
            switch self {
            case .watch:
                return "You're a close and up to date help for your friends. Someone in close reach."
            case .iphone:
                return "You're a daily need and always usefull. "
            case .macbook:
                return "You're the person/product to work with. A powerful option on the road."
            case .imac:
                return "You're the powerhouse for someone's work. A safe place to work at home."
            }
        }
    }
}
