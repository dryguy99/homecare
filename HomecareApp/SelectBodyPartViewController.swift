//
//  SelectBodyPartViewController.swift
//  HomecareApp
//
//  Created by Darshan Kalola on 10/15/17.
//  Copyright © 2017 Darshan Kalola. All rights reserved.
//

import UIKit

class SelectBodyPartViewController: UIViewController {

    // Selects the correct body part questions to present
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationNC = segue.destination as? UINavigationController {
            if let destinationVC = destinationNC.viewControllers.first as? QuestionControlViewController {
                if let identifier = segue.identifier {
                    if identifier == "Knee" {
                        let qBox = QuestionBox(bodyPartToBeUsed: .knee)
                        destinationVC.questionBox = qBox
                    } else if identifier == "Ankle" {
                        let qBox = QuestionBox(bodyPartToBeUsed: .ankle)
                        destinationVC.questionBox = qBox
                    }
                }
            }
        }
    }
}
