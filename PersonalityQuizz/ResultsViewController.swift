//
//  ResultsViewController.swift
//  PersonalityQuizz
//
//  Created by Bart Witting on 13/11/2018.
//  Copyright © 2018 Bart Witting. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    var responses : [Answer]!
    
    @IBOutlet weak var bigLabel: UILabel!
    @IBOutlet weak var smallLabel: UILabel!
    
    override func viewDidLoad() {
        navigationItem.hidesBackButton = true
        super.viewDidLoad()
        print(responses)
        calculateResult()
    }

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
