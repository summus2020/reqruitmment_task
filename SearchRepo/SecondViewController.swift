//
//  SecondViewController.swift
//  Recriutment Task
//
//  Created by Oleksandr Artiukh on 17.05.22.
//  Copyright © 2022 Oleksandr Artiukh. All rights reserved.
//

import Foundation
import UIKit

public protocol SecondViewControllerDelegate: class {
    func navigateToFirstPage()
}


class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    public weak var delegate:SecondViewControllerDelegate?
    var repo:Repo!
    var tableView:UITableView!
    var commits:[Commit]!
    let loader = Loader()
    let cellIdentifier = "commitCell"
    let left_padding:CGFloat = 20
    
    lazy var avatarImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = UIColor.clear
        imgView.layer.masksToBounds = true
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    var but_online:UIButton = {
        let but = UIButton(type: UIButton.ButtonType.system)
        but.backgroundColor = UIColor.init(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
        but.setTitle("VIEW ONLINE", for: .normal)
        but.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        but.layer.cornerRadius = 19
        but.clipsToBounds = true
        but.translatesAutoresizingMaskIntoConstraints = false
        return but
    }()
    
    var lbl_by:UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = UIColor.clear
        lbl.textColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.75)
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        lbl.textAlignment = .left
        lbl.text = "REPO BY"
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var lbl_name:UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = UIColor.clear
        lbl.textColor = UIColor.white
        lbl.font = UIFont.boldSystemFont(ofSize: 30)
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var starImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "star_alpha")
        imgView.backgroundColor = UIColor.clear
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    var lbl_stars:UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = UIColor.clear
        lbl.textColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.75)
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var lbl_title:UILabel = {
        let lbl = UILabel()
        lbl.text = "Repo Title"
        lbl.backgroundColor = UIColor.clear
        lbl.textColor = UIColor.black
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var lbl_history:UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = UIColor.clear
        lbl.textColor = UIColor.black
        lbl.font = UIFont.boldSystemFont(ofSize: 24)
        lbl.textAlignment = .left
        lbl.text = "Commits History"
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var but_share:UIButton = {
        let but = UIButton(type: UIButton.ButtonType.system)
        but.setImage(UIImage(named: "share"), for: UIControl.State.normal)
        but.setTitle("Share Repo", for: UIControl.State.normal)
        but.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        but.backgroundColor = UIColor.init(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
        but.layer.cornerRadius = 12
        but.clipsToBounds = true
        but.translatesAutoresizingMaskIntoConstraints = false
        return but
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        view.backgroundColor = UIColor.white
        
        view.addSubview(avatarImageView)
        avatarImageView.downloaded(from: repo.avatarLink, contentMode: .scaleAspectFill)
        
        view.addSubview(lbl_by)
        
        view.addSubview(lbl_name)
        lbl_name.text = repo.owner
        lbl_name.sizeToFit()
        
        view.addSubview(starImageView)
        
        view.addSubview(lbl_stars)
        lbl_stars.text = "Number of Stars(" + String(repo.num_stars) + ")"
        lbl_stars.sizeToFit()
        
        view.addSubview(but_online)
        but_online.addTarget(self, action: #selector(on_but_online_clicked), for: UIControl.Event.touchDown)
        
        view.addSubview(lbl_title)
        view.addSubview(lbl_history)
        
        view.addSubview(but_share)
        but_share.addTarget(self, action: #selector(onButShareClicked), for: UIControl.Event.touchDown)
        
        setupConstraints()
        view.layoutSubviews()
        setupTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController!.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(navigateToFirstPage))
        setNeedsStatusBarAppearanceUpdate()
        commits = []
        loadCommits()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }
    func setupTableView(){
        let x = left_padding
        let y = lbl_history.frame.origin.y + lbl_history.frame.size.height + left_padding
        let w = view.frame.width - (left_padding*2)
        let h = but_share.frame.origin.y - left_padding - y
        let rect = CGRect(x: x, y: y, width: w, height: h)
        
        tableView = UITableView(frame: rect, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CommitsTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        view.addSubview(tableView)
    }
    func setupConstraints(){
        let h = view.frame.size.height/3
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor),
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            avatarImageView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: h),
            
            but_online.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 20),
            but_online.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            but_online.widthAnchor.constraint(equalToConstant: 130),
            but_online.heightAnchor.constraint(equalToConstant: 38),
            
            starImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: left_padding),
            starImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: -left_padding),
            starImageView.widthAnchor.constraint(equalToConstant: 14),
            starImageView.heightAnchor.constraint(equalToConstant: 14),
            
            lbl_stars.leftAnchor.constraint(equalTo: starImageView.rightAnchor, constant: 5),
            lbl_stars.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor, constant: 0),
            lbl_stars.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            lbl_name.leftAnchor.constraint(equalTo: view.leftAnchor, constant: left_padding),
            lbl_name.bottomAnchor.constraint(equalTo: lbl_stars.topAnchor, constant: -left_padding/2),
            lbl_name.heightAnchor.constraint(equalToConstant: 32),
            lbl_name.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -left_padding),
            
            lbl_by.leftAnchor.constraint(equalTo: view.leftAnchor, constant: left_padding),
            lbl_by.bottomAnchor.constraint(equalTo: lbl_name.topAnchor, constant: -left_padding/2),
            lbl_by.widthAnchor.constraint(equalToConstant: lbl_by.frame.size.width),
            lbl_by.heightAnchor.constraint(equalToConstant: lbl_by.frame.size.height),
            
            lbl_title.leftAnchor.constraint(equalTo: view.leftAnchor, constant: left_padding),
            lbl_title.centerYAnchor.constraint(equalTo: but_online.centerYAnchor),
            lbl_title.rightAnchor.constraint(equalTo: but_online.leftAnchor, constant: -left_padding),
            lbl_title.heightAnchor.constraint(equalToConstant: 30),
            
            lbl_history.leftAnchor.constraint(equalTo: view.leftAnchor, constant: left_padding),
            lbl_history.topAnchor.constraint(equalTo: lbl_title.bottomAnchor, constant: 36),
            lbl_history.widthAnchor.constraint(equalToConstant: lbl_history.frame.size.width),
            lbl_history.heightAnchor.constraint(equalToConstant: lbl_history.frame.size.height),
            
            but_share.leftAnchor.constraint(equalTo: view.leftAnchor, constant: left_padding),
            but_share.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -left_padding),
            but_share.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -left_padding*2),
            but_share.heightAnchor.constraint(equalToConstant: 56)
            
        ])
    }
    
    @objc func navigateToFirstPage(){
        self.delegate?.navigateToFirstPage()
    }
    
    // Button "View Online" clicked
    @objc func on_but_online_clicked(){
        // animate background color
        UIView.animate(withDuration: 0.25, animations: {
            self.but_online.backgroundColor = UIColor.lightGray
        }) { (complete) in
            UIView.animate(withDuration: 0.25, animations: {
                self.but_online.backgroundColor = UIColor.init(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
            }, completion: { (complete) in
                //TODO: navigate to github repo page
                print("button pressed")
            })
        }
    }
    
    // TableViewDelegate methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commits.count
    }
    // make all rows unselectable
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    //make all rows unhighlighted
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CommitsTableViewCell
        let commit = commits[indexPath.row]
        cell.setupCell(indx: indexPath.row+1, name: commit.author, email: commit.email, descr: commit.description)
        
        return cell
    }
    
    // load Repository info
    func loadRepo(){
        let urlString = loader.baseURL_repo + "/" + repo.owner + "/" + repo.name
        loader.fetchRepoData(urlString: urlString) { (data, err) in
            // load repository info
        }
    }
    
    // load commits
    func loadCommits(){
        let urlString = self.loader.baseURL_repo + self.repo.owner + "/" + self.repo.name + "/commits"
        print(urlString)
        self.loader.fetchCommitsData(urlString: urlString) { (data, err) in
            //create commits array
            print("data loaded...")
            if data != nil{
                let arr = data as! [[String:Any]]
                print("Loaded commits has ", data!.count, " items")
                for i in 0...2{
                    var commit = Commit()
                    let item = arr[i]["commit"] as! [String:Any]
                    let author = item["author"] as! [String:String]
                    commit.author = author["name"]!
                    commit.email = author["email"]!
                    commit.description = item["message"] as! String
                    
                    self.commits.append(commit)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            else{
                let alert = UIAlertController(title: "Error", message: "Could not load data", preferredStyle: .alert)
                let action = UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler: nil)
                alert.addAction(action)
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    // button chare click listener
    @objc func onButShareClicked(){
        
    }
}
