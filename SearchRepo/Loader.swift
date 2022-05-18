//
//  Loader.swift
//  SearchRepo
//
//  Created by Oleksandr Artiukh on 18.05.22.
//  Copyright © 2022 Oleksandr Artiukh. All rights reserved.
//

import Foundation


class Loader{
    
    let baseURL_search = "https://api.github.com/search/repositories?q="
    let endURL_search = "+in%3Aname%2Cdescription&type=Repositories"
    let baseURL_repo = "https://api.github.com/repos/"
    
    func fetchRepoListData(urlString:String, completion: @escaping ([String:Any]?, Error?) -> Void) {
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
