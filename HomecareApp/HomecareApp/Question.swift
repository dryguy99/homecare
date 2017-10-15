//
//  Question.swift
//  HomecareApp
//
//  Created by Darshan Kalola on 10/14/17.
//  Copyright © 2017 Darshan Kalola. All rights reserved.
//

import Foundation
import UIKit

class Question {
    private let videoURL: String
    private let questionText: String
    private var injuriesArray: [Injury]
    
    init(url: String, text: String, injuryInQuestion: Injury...) {
        // Set appropiate variables
        videoURL = url
        questionText = text
        injuriesArray = [Injury]()
        for injury in injuryInQuestion {
            injuriesArray.append(injury)
        }
    }
    
    // Getters
    func getVideoURL() -> String {
        return videoURL
    }
    
    func getQuestionText() -> String {
        return questionText
    }
    
    func getInjuriesArray() -> [Injury] {
        return injuriesArray
    }
}


enum Injury: Hashable {
    case invertedAnkleSprain(Int)
    case evertedAnkleSprain(Int)
    case ACLTear(Int)
    case MCLTear(Int)
    
    static let allValues = ["Inverted Ankle Sprain", "Everted Ankle Sprain", "ACL Tear", "MCL Tear"]
    
    // Make Injury hashable for use in a dictionary
    var hashValue: Int {
        return self.toInt()
    }
    
    func getScore() -> Int {
        switch self {
        case .invertedAnkleSprain(let value): return value
        case .evertedAnkleSprain(let value): return value
        case .ACLTear(let value): return value
        case .MCLTear(let value): return value
        }
    }
    
    func getDescription() -> String {
        switch self {
        case .invertedAnkleSprain(_): return "Inverted Ankle Sprain"
        case .evertedAnkleSprain(_): return "Everted Ankle Sprain"
        case .ACLTear(_): return "ACL Tear"
        case .MCLTear(_): return "MCL Tear"
        }
    }
    
    func toInt() -> Int {
        switch self {
        case .invertedAnkleSprain:
            return 1
        case .evertedAnkleSprain:
            return 2
        case .ACLTear:
            return 3
        case .MCLTear:
            return 4
        }
    }
}

func ==(lhs: Injury, rhs: Injury) -> Bool {
    return lhs.toInt() == rhs.toInt()
}
