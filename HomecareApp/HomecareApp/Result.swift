//
//  Result.swift
//  HomecareApp
//
//  Created by Darshan Kalola on 10/15/17.
//  Copyright © 2017 Darshan Kalola. All rights reserved.
//

import Foundation
import UIKit

class Result {
    private let injuryName: String
    private let injuryProbability: Double
    
    init(injury: String, probability: Double) {
        injuryName = injury
        injuryProbability = probability
    }
    
    func convertProbabilityToPercent() -> String {
        let percentDouble = injuryProbability * 100
        let percentString = "%" + String(format: "%.2f", percentDouble)
        return percentString
    }
    
    func getInjuryName() -> String {
        return injuryName
    }
}
