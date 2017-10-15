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
            let question1: Question = Question(url: "Inversion", text: "Do you feel any pain while inverting your ankle?", injuryInQuestion: .inversionAnkleSprain(5))
            
            let question2: Question = Question(url: "OutsideAnkleSwelling", text: "Do you have any swelling, as indicated in the video?", injuryInQuestion: .eversionAnkleSprain(3), .inversionAnkleSprain(3))
            
            let question3: Question = Question(url: "Filler", text: "Did you hear or experience a popping sound during your injury?", injuryInQuestion: .eversionAnkleSprain(2), .inversionAnkleSprain(2))
            
            let question4: Question = Question(url: "OutsideAnkleSwellingTouch", text: "Do you feel any pain after gently pressing the indicated area of your ankle?", injuryInQuestion: .inversionAnkleSprain(4))
            
            let question5: Question = Question(url: "Pronation", text: "Do you fell any pain after performing this leg movement?", injuryInQuestion: .eversionAnkleSprain(5))
            
            let question6: Question = Question(url: "ThompsonTest", text: "Does your foot plantar flex (foot jerks upwards) when someone performs the Thompson test?", injuryInQuestion: .achillesTendonitis(5))
            
            let question7: Question = Question(url: "InsideAnkleSwellingTouch", text: "Do you feel any pain after gently pressing the indicated area of your ankle?", injuryInQuestion: .eversionAnkleSprain(4))
            
            let question8: Question = Question(url: "TendonTouch", text: "Do you feel tenderness or swelling in the area referred to by the video?", injuryInQuestion: .achillesTendonitis(3), .achillesTendonRupture(3))
            
            let question9: Question = Question(url: "Filler", text: "Have you sprained your ankle before within the last 9 months?", injuryInQuestion: .eversionAnkleSprain(2), .inversionAnkleSprain(2))
            
            questions = [Question]()
            questions.append(question1)
            questions.append(question2)
            questions.append(question3)
            questions.append(question4)
            questions.append(question5)
            questions.append(question6)
            questions.append(question7)
            questions.append(question8)
            questions.append(question9)
            
        case .knee:
            bodyPart = bodyPartToBeUsed
            // Set up the question box with knee questions
            let question1: Question = Question(url: "AnteriorDrawerTest", text: "When another individual performs this test on you, do they feel any laxity (softness)?", injuryInQuestion: .ACLTear(5))
            let question2: Question = Question(url: "Plantarflexion", text: "When you horizontally rotate your knee, does it hurt?", injuryInQuestion: .ACLTear(1), .MCLTear(3))
            
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
        case "Yes", "yes":
            // First increment all the values
            for each in currentQuestion.getInjuriesArray() {
                let nameOfEachInjury = each.getDescription()
                let newValue = each.getScore() + injuryScores[nameOfEachInjury]!
                injuryScores.updateValue(newValue, forKey: each.getDescription())
            }
        case "Some", "some":
            // Increment all values by a certain multiplier
            for each in currentQuestion.getInjuriesArray() {
                let nameOfEachInjury = each.getDescription()
                let newValue = (each.getScore() / 2) + injuryScores[nameOfEachInjury]!
                injuryScores.updateValue(newValue, forKey: each.getDescription())
            }
        case "No", "no":
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
        
        var probability = Double(maxValue) / Double(totalScore)
        if probability == Double.nan {
            probability = 0.0
        }
        let returnTuple = (maxName, probability)
        
        return returnTuple
    }
    
    // Goes back to the first question as current question and erases all of the scores
    func clearAll() {
        currentQuestion = questions.first!
        print(currentQuestion.getQuestionText())
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
