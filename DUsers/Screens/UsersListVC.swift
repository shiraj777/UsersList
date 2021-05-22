//
//  UsersListVC.swift
//  DUsers
//
//  Created by Shira Janach on 19/05/2021.
//

import UIKit

class UsersListVC: DUDataLoadingVC {

    let tableView       = UITableView()
    var users: [User]   = []
    var page            = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        getUsers()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title                = "Users"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .clear
        
        let addButton = UIBarButtonItem(image: Images.share, style: .plain, target: self, action: #selector(shareButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.rowHeight = screenHeight/9.2
        tableView.delegate = self
        tableView.dataSource = self
        tableView.removeExcessCells()
        
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.reuseID)
    }
    
    
    func getUsers() {
        showLoadingView()
        NetworkManager.shared.getUsers(page: page){ [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case.success(let users):
                if users.isEmpty {
//                    self.showEmptyStateView(with: "", in: self.view)
                }else{
                    self.users = users
                    DispatchQueue.main.async {
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

extension UsersListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.reuseID) as! UserCell
        let user = users[indexPath.row]
        cell.set(user: user)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user    = users[indexPath.row]
        let destVC  = UserProfileVC(userId: user.id)
        
        navigationController?.pushViewController(destVC, animated: true)
    }
}
