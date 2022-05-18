//
//  ViewController.swift
//  SearchRepo
//
//  Created by Oleksandr Artiukh on 18.05.22.
//  Copyright © 2022 Oleksandr Artiukh. All rights reserved.
//

import UIKit

protocol FirstViewControllerDelegate: class {
    func navigateToNextPage(repo:Repo)
}

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    public weak var delegate:FirstViewControllerDelegate?
    let tableView = UITableView()
    var data:[Repo] = []
    var lbl_search:UILabel!
    var searchBar:UISearchBar!
    var lbl_repo:UILabel!
    var safeArea: UILayoutGuide!
    let cellIdentifier = "cellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        return 86
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SearchTableViewCell
        let repo = data[indexPath.row]
        cell.setupCell(image: repo.avatarLink, name: repo.name, stars: repo.num_stars)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repo = data[indexPath.row]
        goToSecondPage(repo: repo)
        
    }
    
    func goToSecondPage(repo:Repo){
        self.delegate?.navigateToNextPage(repo: repo)
    }
    
    // SearchBarDelegate methods
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("End editing..")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        data.removeAll()
        tableView.reloadData()
        let loader = Loader()
        loader.fetchData(searchString: searchBar.text!) { (dict, err) in
            //TODO: handle very lond dict
            if dict != nil{
                let total = dict!["total_count"] as! Int
                print("Total items = ", total)
                if total == 0{
                    let alert = UIAlertController(title: "Info", message: "Nothing found by your request", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
                else{
                    guard let items = dict!["items"] as? [[String:Any]] else {
                        //TODO: handle error
                        print("error reading items")
                        return
                    }
                    for item in items{
                        var repo = Repo()
                        guard let owner = item["owner"] as? [String:Any] else{
                            //TODO: handle error
                            print("error reading owner")
                            return
                        }
                        repo.avatarLink = owner["avatar_url"]! as! String
                        repo.name = item["name"] as! String
                        repo.num_stars = item["stargazers_count"] as! Int
                        
                        self.data.append(repo)
                    }
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
            else{
                let alert = UIAlertController(title: "Error", message: "Could not load data", preferredStyle: .alert)
                let action = UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
}
