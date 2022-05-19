//
//  Structures.swift
//  SearchRepo
//
//  Created by Oleksandr Artiukh on 19.05.22.
//  Copyright © 2022 Oleksandr Artiukh. All rights reserved.
//

import Foundation

struct Repo {
    var avatarLink:String = ""
    var name:String = ""
    var num_stars:Int = 0
    var owner:String = ""
    var repo_name:String = ""
    var html_url:String = ""
    
}

struct Commit {
    var author:String = ""
    var email:String = ""
    var description:String = ""
}
