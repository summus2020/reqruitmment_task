//
//  ViewController.swift
//  SearchRepo
//
//  Created by Oleksandr Artiukh on 18.05.22.
//  Copyright © 2022 Oleksandr Artiukh. All rights reserved.
//

import UIKit

public protocol FirstViewControllerDelegate: class {
    func navigateToNextPage()
}

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    public weak var delegate:FirstViewControllerDelegate?
    let tableView = UITableView()
    var data:[Person] = []
    var lbl_search:UILabel!
    var searchBar:UISearchBar!
    var lbl_repo:UILabel!
    var safeArea: UILayoutGuide!
    let cellIdentifier = "cellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: remove it
        var person = Person()
        person.imageLink = "http://localhost:8888/avatar.png"
        person.name = "John Doe"
        person.num_commits = 2022
        data.append(person)
        //----------------
        
        self.view.backgroundColor = UIColor.white
        safeArea = self.view.layoutMarginsGuide
        
        lbl_search = UILabel(frame: CGRect(origin: CGPoint(x: 10, y: 0), size: CGSize(width: UIScreen.main.bounds.size.width, height: 30)))
        lbl_search.text = "Search"
        lbl_search.textColor = UIColor.black
        lbl_search.backgroundColor = UIColor.clear
        lbl_search.font = UIFont.boldSystemFont(ofSize: 28)
        lbl_search.sizeToFit()
        self.view.addSubview(lbl_search)
        
        searchBar = UISearchBar(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: UIScreen.main.bounds.size.width, height: 60)))
        searchBar.searchBarStyle = UISearchBar.Style.minimal
        self.view.addSubview(searchBar)
        searchBar.delegate = self
        
        lbl_repo = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 30))
        lbl_repo.text = "Repositories"
        lbl_repo.textColor = UIColor.black
        lbl_repo.backgroundColor = UIColor.clear
        lbl_repo.font = UIFont.boldSystemFont(ofSize: 22)
        lbl_repo.sizeToFit()
        self.view.addSubview(lbl_repo)
        
        self.view.addSubview(self.tableView)
        self.setupConstraints()
        
        setupTableView()
        
    }
    func setupTableView(){
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    func setupConstraints(){
        // constraints for label "Search"
        lbl_search.translatesAutoresizingMaskIntoConstraints = false
        lbl_search.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 28).isActive = true
        lbl_search.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 0).isActive = true
        
        // constraints for search bar
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: lbl_search.bottomAnchor, constant: 4).isActive = true
        searchBar.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 4).isActive = true
        searchBar.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -4).isActive = true
        
        // constraints for label "Repositories"
        lbl_repo.translatesAutoresizingMaskIntoConstraints = false
        lbl_repo.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16).isActive = true
        lbl_repo.leftAnchor.constraint(equalTo: lbl_search.leftAnchor).isActive = true
        
        // constraints for tableView
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: lbl_repo.bottomAnchor, constant: 10).isActive=true
        tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0).isActive=true
        tableView.leftAnchor.constraint(equalTo: lbl_repo.leftAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: 0).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SearchTableViewCell
        let person = data[indexPath.row]
        cell.setupCell(image: person.imageLink, name: person.name, commits: person.num_commits)
        
        return cell
    }
    
    func goToSecondPage(){
        self.delegate?.navigateToNextPage()
    }
    
}
