//
//  Alerts.swift
//  20200719-KunHuang-NYCSchools
//
//  Created by Kun Huang on 7/20/20.
//  Copyright © 2020 Kun Huang. All rights reserved.
//

import Foundation
import UIKit

class Alerts {

    public static func errorAlert(message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Error Alerts", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))

        return alert
    }
}
