//
//  QuestionViewController.swift
//  PersonalityQuizz
//
//  Created by Bart Witting on 13/11/2018.
//  Copyright © 2018 Bart Witting. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    /// Defining the outlets
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var singleStack: UIStackView!
    @IBOutlet weak var singleBut1: UIButton!
    @IBOutlet weak var singleBut2: UIButton!
    @IBOutlet weak var singleBut3: UIButton!
    @IBOutlet weak var singleBut4: UIButton!
    
    @IBOutlet weak var multipleStack: UIStackView!
    @IBOutlet weak var multiLabel1: UILabel!
    @IBOutlet weak var multiLabel2: UILabel!
    @IBOutlet weak var multiLabel3: UILabel!
    @IBOutlet weak var multiLabel4: UILabel!
    @IBOutlet weak var switch1: UISwitch!
    @IBOutlet weak var switch2: UISwitch!
    @IBOutlet weak var switch3: UISwitch!
    @IBOutlet weak var switch4: UISwitch!
    
    @IBOutlet weak var rangedStack: UIStackView!
    @IBOutlet weak var rangedLabel1: UILabel!
    @IBOutlet weak var rangedLabel2: UILabel!
    @IBOutlet weak var rangeSlider: UISlider!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    /// Defining the variabels, the answers are shuffled to make them appear on random positions on the screen
    var questions : [Question] = [
        Question(text: "What do you like?", type:.single, answers:[Answer(text:"Jewlery", type:.watch), Answer(text:"Having everything in reach", type:.iphone), Answer(text:"To work where possible", type:.macbook), Answer(text:"POWER", type:.imac)].shuffled()),
        Question(text: "What are you?", type:.multiple, answers:[Answer(text:"The news bringer", type:.watch), Answer(text:"Always online", type:.iphone), Answer(text:"A school person", type:.macbook), Answer(text:"A work horse", type:.imac)].shuffled()),
        Question(text: "Do you like to stay home", type:.ranged, answers:[Answer(text:"Yes", type:.watch), Answer(text:"Somethimes", type:.iphone), Answer(text:"It's possible", type:.macbook), Answer(text:"No", type:.imac)])]
    
    var questionIndex = 0
    var answersChosen : [Answer] = []
    
    /// Building the screen
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    /// Action to check which single button is pressed
    @IBAction func singleButPressed(_ sender: UIButton) {
        let currentAns = questions[questionIndex].answers
        
        switch sender {
        case singleBut1:
            answersChosen.append(currentAns[0])
        case singleBut2:
            answersChosen.append(currentAns[1])
        case singleBut3:
            answersChosen.append(currentAns[2])
        case singleBut4:
            answersChosen.append(currentAns[3])
        default:
            break
        }
        
        nextQ()
    }
    
    /// Action to check which switches are activated
    @IBAction func multiButPressed() {
        let currentAns = questions[questionIndex].answers
        
        if switch1.isOn {
            answersChosen.append(currentAns[0])
        }
        if switch2.isOn {
            answersChosen.append(currentAns[1])
        }
        if switch3.isOn {
            answersChosen.append(currentAns[2])
        }
        if switch4.isOn {
            answersChosen.append(currentAns[3])
        }
        
        nextQ()
    }
    
    /// Action to check the range
    @IBAction func rangeButPressed() {
        let currentAns = questions[questionIndex].answers
        let index = Int(round(rangeSlider.value * Float(currentAns.count-1)))
        answersChosen.append(currentAns[index])
        
        nextQ()
    }
    
    /// Function to go to the new question
    func nextQ() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        }
        else {
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
    }
    
    /// Function to set the question and answers on screen
    func updateUI() {
        singleStack.isHidden = true
        multipleStack.isHidden = true
        rangedStack.isHidden = true
        
        let currentQ = questions[questionIndex]
        let currentA = currentQ.answers
        let progress = Float(questionIndex)/Float(questions.count)
        
        navigationItem.title = "Question #\(questionIndex+1)"
        questionLabel.text = currentQ.text
        progressBar.setProgress(progress, animated: true)
        
        switch currentQ.type {
        case .single:
            updateSingle(using: currentA)
        case .multiple:
            updateMulti(using: currentA)
        case .ranged:
            updateRanged(using: currentA)
        }
    }
    
    /// Function to set the answers for a single question
    func updateSingle(using answers: [Answer]) {
        singleStack.isHidden = false
        singleBut1.setTitle(answers[0].text, for: .normal)
        singleBut2.setTitle(answers[1].text, for: .normal)
        singleBut3.setTitle(answers[2].text, for: .normal)
        singleBut4.setTitle(answers[3].text, for: .normal)
    }
    
    /// Function to set the answers for a multiple question
    func updateMulti(using answers: [Answer]) {
        multipleStack.isHidden = false
        switch1.isOn = false
        switch2.isOn = false
        switch3.isOn = false
        switch4.isOn = false
        multiLabel1.text = answers[0].text
        multiLabel2.text = answers[1].text
        multiLabel3.text = answers[2].text
        multiLabel4.text = answers[3].text
    }
    
    /// Function to set the answers for a ranged question
    func updateRanged(using answers: [Answer]) {
        rangedStack.isHidden = false
        rangeSlider.setValue(0.5, animated: false)
        rangedLabel1.text = answers.first?.text
        rangedLabel2.text = answers.last?.text
    }

    /// Function to send the result to the result page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsSegue" {
            let resultsviewcontroller = segue.destination as! ResultsViewController
            resultsviewcontroller.responses = answersChosen
        }
    }
}
