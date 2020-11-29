//
//  ClaimService.swift
//  ClaimClientProgUI
//
//  Created by Justin Poblete on 11/25/20.
//  Copyright © 2020 Justin Poblete. All rights reserved.
//
import Foundation

struct Claim : Codable {
    var title : String
    var date : String
}

class ClaimService {
    
    func addClaim(cObj: Claim, completion: @escaping (Bool) -> Void) {
        let requestUrl = "http://localhost:8020/ClaimService/add"
        var request = URLRequest(url: NSURL(string: requestUrl)! as URL)
        let jsonData : Data! = try! JSONEncoder().encode(cObj)
        var value = Bool()
        //
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //
        let task = URLSession.shared.uploadTask(with: request, from: jsonData) {
            (data, response, error) in
            DispatchQueue.main.async {
                if let resp = data {
                    // type of resp is Data
                    let respStr = String(bytes: resp, encoding: .utf8)
                    print("The response data sent from the server is \(respStr!)")
                    value = true
                    completion(value)
                    //
                } else if let respError = error {
                    print("Server Error : \(respError)")
                    value = false
                    completion(value)
                }
            }
        }
        task.resume()
    }
}
