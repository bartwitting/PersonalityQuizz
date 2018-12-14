//
//  ResultsViewController.swift
//  PersonalityQuizz
//
//  Created by Bart Witting on 13/11/2018.
//  Copyright © 2018 Bart Witting. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    /// Defining the variable this time the result from the last VC
    var responses : [Answer]!
    
    /// Defining the outlets
    @IBOutlet weak var bigLabel: UILabel!
    @IBOutlet weak var smallLabel: UILabel!
    
    /// Building the screen
    override func viewDidLoad() {
        navigationItem.hidesBackButton = true
        super.viewDidLoad()
        print(responses)
        calculateResult()
    }

    /// Function to calculate the result
    func calculateResult() {
        var freqOfAns : [Answer.Product : Int] = [:]
        let responseTypes = responses.map { $0.type }
        for response in responseTypes {
            freqOfAns[response] = (freqOfAns[response] ?? 0) + 1
        }
        let mostCommon = freqOfAns.sorted(by: { $0.1 > $1.1 }).first!.key

        bigLabel.text = "You are a \(mostCommon.rawValue)!"
        smallLabel.text = mostCommon.definition
    }

}
