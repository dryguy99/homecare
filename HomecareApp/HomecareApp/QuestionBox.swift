//
//  QuestionBox.swift
//  HomecareApp
//
//  Created by Darshan Kalola on 10/14/17.
//  Copyright © 2017 Darshan Kalola. All rights reserved.
//

import Foundation
import UIKit

class QuestionBox {
    
    // All questions cooresponding to the chosen body part
    private var questions: [Question]
    
    // The question that is currently being displayed to the user
    private var currentQuestion: Question
    private var currentQuestionIndex: Int
    
    // A dictionary that contains the scores of each injury
    private var injuryScores: [String:Int]
    
    // Picks which body part to initalize the questions with
    private let bodyPart: BodyPart
    
    // Init based on which body part we are focused on
    init(bodyPartToBeUsed: BodyPart) {
        switch bodyPartToBeUsed {
        case .ankle:
            bodyPart = bodyPartToBeUsed
            // Set up the question box with ankle questions
            let question1: Question = Question(url: "test", text: "When you laterally rotate your ankle, does it hur?", injuryInQuestion: .evertedAnkleSprain(3), .invertedAnkleSprain(5))
            let question2: Question = Question(url: "test", text: "When you horizontally rotate your ankle, does it hur?", injuryInQuestion: .evertedAnkleSprain(5))
            
            questions = [Question]()
            questions.append(question1)
            questions.append(question2)
        case .knee:
            bodyPart = bodyPartToBeUsed
            // Set up the question box with knee questions
            let question1: Question = Question(url: "test", text: "When you laterally rotate your knee, does it hur?", injuryInQuestion: .ACLTear(3), .MCLTear(5))
            let question2: Question = Question(url: "test", text: "When you horizontally rotate your knee, does it hur?", injuryInQuestion: .ACLTear(1), .MCLTear(3))
            
            questions = [Question]()
            questions.append(question1)
            questions.append(question2)
        }
        
        currentQuestion = questions.first!
        currentQuestionIndex = 1 // NOTE: THIS STARTS AT 1
        injuryScores = [String:Int]()
        // Add all injuries with an initial score of 0
        for each in Injury.allValues {
            injuryScores[each] = 0
        }
    }
    
    // Getters
    func getCurrentQuestion() -> Question {
        return currentQuestion
    }
    
    // Handle user responses, returns a bool indicated whether we should keep going (true) or segue (false)
    func handleResponse(withConfirmation confirmation: String) -> Bool{
        switch confirmation {
        case "Yes":
            // First increment all the values
            for each in currentQuestion.getInjuriesArray() {
                let nameOfEachInjury = each.getDescription()
                let newValue = each.getScore() + injuryScores[nameOfEachInjury]!
                injuryScores.updateValue(newValue, forKey: each.getDescription())
            }
        case "Some":
            // Increment all values by a certain multiplier
            for each in currentQuestion.getInjuriesArray() {
                let nameOfEachInjury = each.getDescription()
                let newValue = (each.getScore() / 2) + injuryScores[nameOfEachInjury]!
                injuryScores.updateValue(newValue, forKey: each.getDescription())
            }
        case "No":
            // Do not increment anything if no
            break
        default:
            print("Error!")
        }
        // Move to the next question if possible
        if currentQuestionIndex == questions.count {
            // Return true, we should not segue to results
            return true
        }
        
        currentQuestion = questions[currentQuestionIndex]
        currentQuestionIndex+=1
        return false
    }
    
    // Calculates the most probably injury based on score and probability
    func getMostProbableInjury() -> (String, Double) {
        // Iterate through the dictionary looking for max
        var maxValue = Int.min
        var maxName = ""
        // Total score is used to calculate probability. It is the sum of all the scores assigned
        var totalScore = 0
        for eachKeyValue in injuryScores.keys {
            if let currValue = injuryScores[eachKeyValue] {
                totalScore += currValue
                if (currValue > maxValue) {
                    maxValue = currValue
                    maxName = eachKeyValue
                }
            }
        }
        
        let probability = Double(maxValue) / Double(totalScore)
        let returnTuple = (maxName, probability)
        
        return returnTuple
    }
    
    // Goes back to the first question as current question and erases all of the scores
    func clearAll() {
        currentQuestion = questions.first!
        for eachKeyValue in injuryScores.keys {
            injuryScores[eachKeyValue] = 0
        }
        currentQuestionIndex = 1
    }
}

enum BodyPart {
    case ankle
    case knee
}
