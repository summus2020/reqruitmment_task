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
        but.backgroundColor = UIColor.init(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
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
        lbl.textColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.5)
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
        lbl.textColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.5)
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var lbl_title:UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = UIColor.clear
        lbl.textColor = UIColor.black
        lbl.font = UIFont.boldSystemFont(ofSize: 28)
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var lbl_history:UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = UIColor.clear
        lbl.textColor = UIColor.black
        lbl.font = UIFont.boldSystemFont(ofSize: 30)
        lbl.textAlignment = .left
        lbl.text = "Commits History"
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        view.backgroundColor = UIColor.white
        
        view.addSubview(avatarImageView)
        avatarImageView.downloaded(from: repo.avatarLink, contentMode: .scaleAspectFill)
        
        view.addSubview(lbl_by)
        
        view.addSubview(lbl_name)
        lbl_name.text = "Repo Author"//repo.owner
        lbl_name.sizeToFit()
        
        view.addSubview(starImageView)
        
        view.addSubview(lbl_stars)
        lbl_stars.text = "Number of Stars(" + String(repo.num_stars) + ")"
        lbl_stars.sizeToFit()
        
        
        
        view.addSubview(but_online)
        but_online.addTarget(self, action: #selector(on_but_online_clicked), for: UIControl.Event.touchDown)
        
        setupConstraints()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController!.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(navigateToFirstPage))
        
        setNeedsStatusBarAppearanceUpdate()
        commits = []
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
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
            lbl_name.heightAnchor.constraint(equalToConstant: 28),
            lbl_name.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -left_padding),
            
            lbl_by.leftAnchor.constraint(equalTo: view.leftAnchor, constant: left_padding),
            lbl_by.bottomAnchor.constraint(equalTo: lbl_name.topAnchor, constant: -left_padding/2),
            lbl_by.widthAnchor.constraint(equalToConstant: lbl_by.frame.size.width),
            lbl_by.heightAnchor.constraint(equalToConstant: lbl_by.frame.size.height)
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CommitsTableViewCell
        
        return cell
    }
    
    // load Repository info
    func loadRepo(){
        let urlString = loader.baseURL_repo + "/" + repo.owner + "/" + repo.name
        loader.fetchRepoListData(urlString: urlString) { (data, err) in
            // load repository info
        }
    }
    
    // load commits
    func loadCommits(){
        let urlString = loader.baseURL_repo + "/" + repo.owner + "/" + repo.name + "/commits"
        loader.fetchRepoListData(urlString: urlString) { (data, err) in
            //create commits array
        }
    }
}
