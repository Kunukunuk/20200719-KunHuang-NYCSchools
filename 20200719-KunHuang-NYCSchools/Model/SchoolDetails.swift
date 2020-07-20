//
//  SchoolDetails.swift
//  20200719-KunHuang-NYCSchools
//
//  Created by Kun Huang on 7/19/20.
//  Copyright © 2020 Kun Huang. All rights reserved.
//

import Foundation

struct SchoolDetails: Codable {

    var dbn: String
    var schoolName: String
    var numOfSatTestTakers: String
    var satCriticalReadingAvgScore: String
    var satMathAvgScore: String
    var satWritingAvgScore: String

}
