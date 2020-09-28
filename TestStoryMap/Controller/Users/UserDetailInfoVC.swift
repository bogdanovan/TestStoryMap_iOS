//
//  UserDetailInfoVC.swift
//  TestStoryMap
//
//  Created by Anatolii Bogdanov on 24.09.2020.
//

import UIKit

class UserDetailInfoVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var userAvatar: RoundImageView!
    @IBOutlet weak var userAvatarShadowView: ShadowView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userRelationLabel: UILabel!
    @IBOutlet weak var userBatteryPrecentageLabel: UILabel!
    @IBOutlet weak var userBatteryImage: UIImageView!
    
    @IBOutlet weak var pathHistoryView: RectangleButton!
    @IBOutlet weak var checkOnMapView: RectangleButton!
    
    @IBOutlet weak var placesTableView: UITableView!
    
    var user: Users?
    var places: [Place] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = K.profileNavBarTitle
        
        placesTableView.delegate = self
        placesTableView.dataSource = self
        
        loadUserInfo()
        
        placesTableView.register(UINib(nibName: "PlacesCell", bundle: nil), forCellReuseIdentifier: K.placeCellIndetifier)
        placesTableView.register(UINib(nibName: "AddPlaceCell", bundle: nil), forCellReuseIdentifier: K.addCellIndetifier)
        
        placesTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: placesTableView.frame.size.width, height: 1))
        
        let tapPath = UITapGestureRecognizer(target: self, action: #selector(self.handleTapPath(_:)))
        pathHistoryView.addGestureRecognizer(tapPath)
        
    }
    
    @objc func handleTapPath(_ sender: UITapGestureRecognizer? = nil) {
        performSegue(withIdentifier: K.userPathSegue, sender: self)
    }
    
    func loadUserInfo() {
        if let user = user {
            userAvatar.image = UIImage(systemName: user.avatar)
            userNameLabel.text = user.name
            userRelationLabel.text = user.relation
            userAvatar.kf.setImage(with: URL(string: user.avatar))
            if let batteryPrecentage = user.batteryPercentage {
                userBatteryPrecentageLabel.text = "\(batteryPrecentage)%"
                userBatteryPrecentageLabel.textColor = user.batteryColor!
                userBatteryImage.image = UIImage(named: user.batteryImage!)
                userAvatarShadowView.drawShadow()
            }
            if let userPlaces = user.places {
                places = userPlaces
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.userPathSegue {
            let viewController = segue.destination as! RouteSelectionVC
            viewController.user = user
        }
    }
    
}

extension UserDetailInfoVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = user?.places?.count {
            return count + 1
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row >= places.count {
            let cell = placesTableView.dequeueReusableCell(withIdentifier: K.addCellIndetifier, for: indexPath) as! AddPlaceCell
            return cell
        } else {
            let place = places[indexPath.row]
            
            let cell = placesTableView.dequeueReusableCell(withIdentifier: K.placeCellIndetifier, for: indexPath) as! PlacesCell
            
            cell.placeNameLabel.text = place.name
            cell.placeAddressLabel.text = place.address
            cell.separatorInset = UIEdgeInsets.zero
            cell.layoutMargins = UIEdgeInsets.zero
            
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
