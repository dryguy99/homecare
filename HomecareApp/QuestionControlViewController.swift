//
//  QuestionControlViewController.swift
//  HomecareApp
//
//  Created by Darshan Kalola on 10/14/17.
//  Copyright © 2017 Darshan Kalola. All rights reserved.
//

import UIKit
import Speech
import AVKit
import AVFoundation

struct StringConstants {
    static let segueToResults = "Results Segue"
}

class QuestionControlViewController: UIViewController, SFSpeechRecognizerDelegate {
    
    // MARK: - Model
    // FIXME - DEFAULT AS ANKLE
    var questionBox: QuestionBox!
    
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var yesButton: UIButton!
    @IBOutlet var someButton: UIButton!
    @IBOutlet var noButton: UIButton!

    // Four variables for speech
    let audioEngine = AVAudioEngine()
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer()
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    
    @IBAction func recordSpeech(_ sender: UIButton) {
        recordAndRecognizeSpeech()
    }
    func recordAndRecognizeSpeech() {
        guard let node =  audioEngine.inputNode else {
            return
        }
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
            self.request.append(buffer)
        }
        
        // Prepare
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            return print(error)
        }
        
        guard let myRecognizer = SFSpeechRecognizer() else {
            return
        }
        
        if !myRecognizer.isAvailable {
            return
        }
        
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { (result, error) in
            if let result = result {
                let _ = result.bestTranscription.formattedString
                
                // NOTE: THIS WILL ACTIVATE VOICE CONTROL!
                //handleUserResponse(response)
                
            } else if let error = error {
                print(error)
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpResponseButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        // Update text label
        updateTextLabel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func backButton(_ sender: Any) {
        // Returns back
        questionBox.clearAll()
        print("We have clered")
    }
    
    
    // MARK: - Handle video playback
    @IBAction func playVideo(_ sender: Any) {
        // Get the correct video to play
        let videoName = questionBox.getCurrentQuestion().getVideoURL()
        guard let path = Bundle.main.path(forResource: videoName, ofType:"mp4") else {
            debugPrint("Not found")
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerController = AVPlayerViewController()
        playerController.player = player
        present(playerController, animated: true) {
            player.play()
        }
    }
    
    // MARK: - Set up pain response buttons
    func setUpResponseButtons() {
        // Round the corners of all buttons
        yesButton.layer.cornerRadius = 15
        yesButton.layer.masksToBounds = true
        
        someButton.layer.cornerRadius = 15
        someButton.layer.masksToBounds = true
        
        noButton.layer.cornerRadius = 15
        noButton.layer.masksToBounds = true
    }
    
    // MARK: - Handlers for pain response buttons
    @IBAction func handleUserResponse(_ sender: UIButton) {
        let userResponse = sender.currentTitle
        let shouldSegue = questionBox.handleResponse(withConfirmation: userResponse!)
        if shouldSegue {
            performSegue(withIdentifier: StringConstants.segueToResults, sender: nil)
        }
        updateTextLabel()
    }
    
    // Updates the text label
    func updateTextLabel() {
        UIView.animate(withDuration: 0.3, animations: { 
            self.textLabel.alpha = 0
        }, completion: nil)
        
        UIView.animate(withDuration: 0.3) {
            self.textLabel.text = self.questionBox.getCurrentQuestion().getQuestionText()
            self.textLabel.alpha = 1.0
        }
    }
    
    
    // MARK: - Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ResultsViewController {
            // Creates a results object
            let resultTuple = questionBox.getMostProbableInjury()
            let result = Result(injury: resultTuple.0, probability: resultTuple.1)
            destinationVC.result = result
            destinationVC.questionBox = questionBox
        }
    }
}
