//
//  Loader.swift
//  SearchRepo
//
//  Created by Oleksandr Artiukh on 18.05.22.
//  Copyright © 2022 Oleksandr Artiukh. All rights reserved.
//

import Foundation


class Loader{
    
    let baseURL = "https://api.github.com/search/repositories?q="
    let endURL = "+in%3Aname%2Cdescription&type=Repositories"
    
    func fetchData(searchString:String, completion: @escaping ([String:Any]?, Error?) -> Void) {
        
        
        let trimmedString = searchString.trimmingCharacters(in: .whitespaces)
        let newString = trimmedString.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        let escapedString = newString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let urlString = baseURL + escapedString! + endURL
        print(urlString)
        
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                if let array = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]{
                    completion(array, nil)
                }
            } catch {
                print(error)
                completion(nil, error)
            }
        }
        task.resume()
    }
    
}
