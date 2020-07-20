//
//  MainViewController.swift
//  20200719-KunHuang-NYCSchools
//
//  Created by Kun Huang on 7/19/20.
//  Copyright © 2020 Kun Huang. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var schoolTableView: UITableView!
    private var schoolList: [School] = [] {
        didSet {
            DispatchQueue.main.async {
                self.schoolTableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Sets delegate and datasource
        schoolTableView.delegate = self
        schoolTableView.dataSource = self

        loadSchoolList()
    }


    /// Calls the APIManager to get high schools and store it in an array
    func loadSchoolList() {

        APIManager.apiManager.getNYCSchools { result in

            switch result {
            case .success(let schools):
                self.schoolList = schools
            case .failure(let error):
                self.present(Alerts.errorAlert(message: "Error Accessing the API"), animated: true)
                print(error)
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schoolList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SchoolViewCell", for: indexPath) as? SchoolViewCell else {
            let cell = SchoolViewCell(style: .default, reuseIdentifier: "SchoolViewCell")
            return cell
        }

        cell.school = schoolList[indexPath.row]

        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let cell = sender as! UITableViewCell
        if let indexPath = schoolTableView.indexPath(for: cell) {
            let school = schoolList[indexPath.row]
            let detailViewController = segue.destination as! SchoolDetailsViewController
            detailViewController.dbn = school.dbn
            detailViewController.schoolName = school.schoolName
        }
    }

}
