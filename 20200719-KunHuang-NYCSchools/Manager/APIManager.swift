//
//  APIManager.swift
//  20200719-KunHuang-NYCSchools
//
//  Created by Kun Huang on 7/19/20.
//  Copyright © 2020 Kun Huang. All rights reserved.
//

import Foundation

struct APIManager {

    public static let apiManager = APIManager()
    let satScoresURL = "https://data.cityofnewyork.us/resource/f9bf-2cp4.json"

    // Types of errors
    public enum APIError: Error {
        case invalidURL(reason: String)
        case someError(error: Error)
        case JSONError(reason: String)
        case emptySAT(reason: String)
    }


    /// Gets NYC high school name and dbn(database numbner?)
    /// - Parameter completion: A closure to check if request failed or completed
    /// - Returns: An Array of School Objects
    func getNYCSchools(completion: @escaping (Result<[School], APIError>) -> () ) {

        let apiURL = URL(string: "https://data.cityofnewyork.us/resource/s3k6-pzi2.json")

        let task = URLSession.shared.dataTask(with: apiURL!) { (data, response, error) in

            guard let dataJson = data else {
                completion(.failure(.invalidURL(reason: "invalid URL")))
                return
            }
            guard error == nil else {
                completion(.failure(.someError(error: error!)))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let school = try decoder.decode([School].self, from: dataJson)
                completion(.success(school))
            } catch {
                completion(.failure(.JSONError(reason: "JSON can't decode")))
            }

        }
        task.resume()
    }


    /// Gets the SAT scores of the NYC high school
    /// - Parameters:
    ///   - dbn: The number to search for the high school
    ///   - completion: A closure to check if request failed or completed
    /// - Returns: School details object with the required information
    func getSchoolSAT(dbn: String, completion: @escaping (Result<SchoolDetails, APIError>) -> () ) {

        let apiURL = URL(string: satScoresURL + "?dbn=\(dbn)")

        let task = URLSession.shared.dataTask(with: apiURL!) { (data, response, error) in

            guard let dataJson = data else {
                completion(.failure(.invalidURL(reason: "invalid URL")))
                return
            }
            guard error == nil else {
                completion(.failure(.someError(error: error!)))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let schoolDetailsArray = try decoder.decode([SchoolDetails].self, from: dataJson)
                guard let schoolDetails = schoolDetailsArray.first else {
                    completion(.failure(.emptySAT(reason: "No SAT scores for this school available")))
                    return
                }
                completion(.success(schoolDetails))
            } catch {
                completion(.failure(.JSONError(reason: "JSON can't decode")))
            }

        }
        task.resume()
    }
}
