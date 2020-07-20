//
//  SchoolDetailsViewController.swift
//  20200719-KunHuang-NYCSchools
//
//  Created by Kun Huang on 7/19/20.
//  Copyright © 2020 Kun Huang. All rights reserved.
//

import UIKit

class SchoolDetailsViewController: UIViewController {

    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet private weak var numSatTakersLabel: UILabel?
    @IBOutlet private weak var avgReadingLabel: UILabel?
    @IBOutlet private weak var avgMathLabel: UILabel?
    @IBOutlet private weak var avgWritingLabel: UILabel?
    var dbn: String?
    var schoolName: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        schoolNameLabel.text = schoolName
        getSchoolScores()
    }


    /// Gets the school SAT details based on dbn
    private func getSchoolScores() {
        if let dbn = dbn {
            APIManager.apiManager.getSchoolSAT(dbn: dbn) { result in
                switch result {
                case .success(let school):
                    DispatchQueue.main.async {
                        self.setUpLabels(school: school)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.setUpLabels()
                        print(error)
                    }
                }
            }
        }
    }


    /// Set up all the labels accordining
    /// - Parameter school: The School Details Object
    private func setUpLabels(school: SchoolDetails? = nil) {

        if let school = school {
            numSatTakersLabel?.text = "Number SAT Takers: \(school.numOfSatTestTakers)"
            avgReadingLabel?.text = "Average Reading Score: \(school.satCriticalReadingAvgScore)"
            avgMathLabel?.text = "Average Math Score: \(school.satMathAvgScore)"
            avgWritingLabel?.text = "Average Writing Score: \(school.satWritingAvgScore)"
        } else {
            present(Alerts.errorAlert(message: "No SAT scores for this school available"), animated: true)
            numSatTakersLabel?.text = "No SAT scores available for this school"
            avgReadingLabel?.text = "No SAT scores available for this school"
            avgMathLabel?.text = "No SAT scores available for this school"
            avgWritingLabel?.text = "No SAT scores available for this school"
        }

    }

}
