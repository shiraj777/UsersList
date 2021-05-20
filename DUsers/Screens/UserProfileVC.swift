//
//  UserProfileVC.swift
//  DUsers
//
//  Created by Shira Janach on 19/05/2021.
//

import UIKit

class UserProfileVC: DUDataLoadingVC {

    let headerView      = HeaderUserProfileView(frame: .zero)
    let tableView       = UITableView()
    var posts: [Post]   = []
    var page            = 1
    var userId: String!
    var fullName: String!
    
    init(userId: String) {
        super.init(nibName: nil, bundle: nil)
        
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .systemBackground        

        self.userId   = userId
        self.modalPresentationCapturesStatusBarAppearance = true
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
            .lightContent
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configure()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getUsers()
    }
    
    
    func configureTableView() {
        tableView.separatorStyle = .none
        tableView.frame = view.bounds
        tableView.rowHeight = 100
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.reuseID)
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configure() {
        view.addSubviews(headerView, tableView)
                
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: screenHeight/1.9),
            
            
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    func getUsers() {
        showLoadingView()
        NetworkManager.shared.getPosts(userId: userId, page: page){ [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case.success(let posts):
                if posts.isEmpty {
                    print("")
//                    self.showEmptyStateView(with: "", in: self.view)
                }else{
                    self.posts = posts
                    DispatchQueue.main.async {
                        self.headerView.set(posts: posts)
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
                
            case .failure(let error):
                self.presentGFAlertOnMinThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}


extension UserProfileVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseID) as! PostCell
        cell.selectionStyle = .none
        let post = posts[indexPath.row]
        cell.set(post: post)
        return cell
    }
}
