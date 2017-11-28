//
//  RestService.swift
//  Desafio
//
//  Created by leonardo fernandes farias on 27/11/2017.
//  Copyright © 2017 Tiago. All rights reserved.
//

import UIKit
import Alamofire

class RestService: NSObject {
    
    static let instance = RestService()
    
    let GIT_URL = "https://api.github.com/search/repositories?q=language:Java&sort=stars&page="
    
    func get(urlString: String, page: Int = 0, completion: @escaping (_ data: Data?, _ erro: String?)->()) {
        
        var url = urlString
        
        if page != 0 {
            url += page.description
        }
        
        Alamofire.request(url, method: .get, parameters: ["":""], encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
                
            case .success(_):
                if let data = response.data {
                    completion(data, nil)
                } else {
                    completion(nil, "Unavailable service")
                }
            case .failure(_):
                debugPrint(response)
                if let error = response.result.error as NSError? {
                    if error.code == -1009 {
                        completion(nil, "Check your internet connection")
                    } else {
                        completion(nil, "Unavailable service")
                    }
                } else {
                    completion(nil, "Unavailable service")
                }
            }
        }
    }

}
