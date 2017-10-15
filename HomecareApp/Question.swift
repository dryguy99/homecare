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
    case inversionAnkleSprain(Int)
    case eversionAnkleSprain(Int)
    case achillesTendonitis(Int)
    case achillesTendonRupture(Int)
    case stressFracture(Int)
    
    case ACLTear(Int)
    case MCLTear(Int)
    case PCLTear(Int)
    case LCLTear(Int)
    case meniscusMedialTear(Int)
    case meniscusLateralTear(Int)
    
    static let allValues = ["Inversion Ankle Sprain", "Eversion Ankle Sprain", "Achilles Tendonitis", "Achilles Tendon Rupture", "Stress Fracture", "ACL Tear", "MCL Tear", "PCL Tear", "LCL Tear", "Meniscus Medial Tear", "Meniscus Lateral Tear"]
    
    // Make Injury hashable for use in a dictionary
    var hashValue: Int {
        return self.toInt()
    }
    
    func getScore() -> Int {
        switch self {
        case .inversionAnkleSprain(let value): return value
        case .eversionAnkleSprain(let value): return value
        case .achillesTendonitis(let value): return value
        case .achillesTendonRupture(let value): return value
        case .stressFracture(let value): return value
            
        case .ACLTear(let value): return value
        case .MCLTear(let value): return value
        case .PCLTear(let value): return value
        case .LCLTear(let value): return value
        case .meniscusMedialTear(let value): return value
        case .meniscusLateralTear(let value): return value
        }
    }
    
    func getDescription() -> String {
        switch self {
        case .inversionAnkleSprain(_): return "Inversion Ankle Sprain"
        case .eversionAnkleSprain(_): return "Eversion Ankle Sprain"
        case .achillesTendonitis(_): return "Achilles Tendonitis"
        case .achillesTendonRupture(_): return "Achilles Tendon Rupture"
        case .stressFracture(_): return "Stress Fracture"
            
        case .ACLTear(_): return "ACL Tear"
        case .MCLTear(_): return "MCL Tear"
        case .PCLTear(_): return "PCL Tear"
        case .LCLTear(_): return "LCL Tear"
        case .meniscusMedialTear(_): return "Meniscus Medial Tear"
        case .meniscusLateralTear(_): return "Meniscus Lateral Tear"
        }
    }
    
    func toInt() -> Int {
        switch self {
        case .inversionAnkleSprain:
            return 1
        case .eversionAnkleSprain:
            return 2
        case .achillesTendonitis:
            return 3
        case .achillesTendonRupture:
            return 4
        case .stressFracture:
            return 5
            
        case .ACLTear:
            return 6
        case .MCLTear:
            return 7
        case .PCLTear:
            return 8
        case .LCLTear:
            return 9
        case .meniscusMedialTear:
            return 10
        case .meniscusLateralTear:
            return 11
        }
    }
}

func ==(lhs: Injury, rhs: Injury) -> Bool {
    return lhs.toInt() == rhs.toInt()
}
