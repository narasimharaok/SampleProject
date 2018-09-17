//
//  Network.swift
//  SampleProject
//
//  Created by Narasimha Rao Kundanapalli on 9/16/18.
//  Copyright © 2018 Narasimha Rao Kundanapalli. All rights reserved.
//

import Foundation

protocol GitRequest {
    func getGitData(forCompany company: String, pageNumber: Int, perPage: Int, using completion: @escaping([GitModel]?)->())
}

class Network: NSObject, GitRequest {
    static let shared = Network()
    
    func getGitData(forCompany company: String, pageNumber: Int, perPage: Int, using completion: @escaping ([GitModel]?) -> ()) {
        let session = URLSession(configuration: .default)
         //https://api.github.com/users/apple/repos?page=1&per_page=10
        let baseUrl =  "https://api.github.com/users/"
        guard let  url = URL(string: baseUrl + company + "/repos?page=\(pageNumber)&per_page=\(perPage)")  else {
            return
        }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data  else {
                completion(nil)
                return
            }
            do {
                let response = try JSONSerialization.jsonObject(with: data, options: [])
                guard let array = response as? [Any] else {
                    completion(nil)
                    return
                }
                var result: [GitModel] = []
                for element in array {
                    if let model = element as? [String: Any] {
                        result.append(GitModel.init(model))
                    }
                    completion(result)
                }
            } catch let parsingError {
                print(parsingError)
            }
        }
        task.resume()
    }
}
