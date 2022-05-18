//
//  Loader.swift
//  SearchRepo
//
//  Created by Oleksandr Artiukh on 18.05.22.
//  Copyright © 2022 Oleksandr Artiukh. All rights reserved.
//

import Foundation


class Loader{
    
    
    
    func fetchData(completion: @escaping ([String:Any]?, Error?) -> Void) {
        let url = URL(string: "http://api.geekdo.com/api/images?ajax=1&gallery=all&nosession=1&objectid=127023&objecttype=thing&pageid=357&showcount=1&size=thumb&sort=recent")!
        
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
