//
//  ResultsViewController.swift
//  HomecareApp
//
//  Created by Darshan Kalola on 10/14/17.
//  Copyright © 2017 Darshan Kalola. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    var result: Result!
    var questionBox: QuestionBox!
    
    @IBOutlet var containerRectangleView: UIView!
    @IBOutlet var illnessNameLabel: UILabel!
    @IBOutlet var percentageNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLabels()
        setUpContainerRectangleView()
    }
    
    // MARK: - User Interface
    // Set's up the container rectangle view
    func setUpContainerRectangleView() {
        // Clip the boundaries
        containerRectangleView.layer.cornerRadius = 9.0
        containerRectangleView.layer.masksToBounds = true
    }
    
    // Set up the label
    func setUpLabels() {
        illnessNameLabel.text = result?.getInjuryName()
        percentageNameLabel.text = result?.convertProbabilityToPercent()
    }
    
    // Revert everything back to beginning when we go back
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Clear out the questionsbox
        questionBox.clearAll()
    }
}
