//
//  UsersVC.swift
//  TestStoryMap
//
//  Created by Anatolii Bogdanov on 23.09.2020.
//

import UIKit

class UsersVC: UIViewController {
    
    
    
    @IBOutlet weak var userTableView: UITableView!
    
    @IBOutlet weak var peopleLabel: UILabel!
    
    var users: [Users] = []
    var places: [Place] = []
    var user: Users?
    var peopleManager = PeopleManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userTableView.delegate = self
        self.userTableView.dataSource = self
        
        self.peopleManager.delegate = self
        peopleManager.performRequest()
        
        self.navigationItem.title = K.usersNavBarTitle
        peopleLabel.text = K.usersNavBarTitle
        
        userTableView.register(UINib(nibName: "UsersCell", bundle: nil), forCellReuseIdentifier: K.userCellIdentifier)
        userTableView.tableFooterView = UIView()
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.userDetailSegue {
            let viewController = segue.destination as! UserDetailInfoVC
            viewController.user = user
        }
    }
    
}

extension UsersVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = users[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.userCellIdentifier, for: indexPath) as! UsersCell
        cell.userNameLabel?.text = user.name
        cell.relationLabel?.text = user.relation
        if let batteryLevel = user.batteryPercentage {
            cell.userBatteryPercentageLabel?.text = "\(batteryLevel)%"
            cell.userBatteryPercentageLabel?.textColor = user.batteryColor
            if let batteryImage = user.batteryImage {
                cell.userBatteryImage.image = UIImage(named: batteryImage)
            }
        }
        cell.userAvatar.kf.setImage(with: URL(string: user.avatar))
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        user = users[indexPath.row]
        performSegue(withIdentifier: K.userDetailSegue, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { (action, view, completion) in
            completion(true)
        }
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, completion) in
            completion(true)
        }
        
        deleteAction.backgroundColor = UIColor.red
        editAction.backgroundColor = UIColor.gray
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
    
}

extension UsersVC: PeopleManagerDelegate {
    func didUpdatePeople(users: [Users]) {
        DispatchQueue.main.async {
            for user in users {
                user.places = [Place(name: "Школа", address: "пр-т Ленина, д.15", lat: 55.804314, lon: 37.582123),
                               Place(name: "Дом", address: "ул.Гагарина, д.3", lat: 55.749846, lon: 37.593317)]
            }
            
            self.users = users
            self.userTableView.reloadData()
        }
    }
}
