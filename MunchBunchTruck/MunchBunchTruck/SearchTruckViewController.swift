//
//  SearchTruckViewController.swift
//  MunchBunchTruck
//
//  Created by Kevin Nguyen on 3/22/18.
//  Copyright © 2018 munch-bunch-app. All rights reserved.
//

import UIKit
import RAMReel
import Alamofire
import SwiftyJSON
import SwiftyBeaver

class SearchTruckViewController: UIViewController, UICollectionViewDelegate {
    
    // Data
    var dataSource: SimplePrefixQueryDataSource!
    var ramReel: RAMReel<RAMCell, RAMTextField, SimplePrefixQueryDataSource>!
    var truckNames: [String] = []
    var truckIds: [Int] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Make networked call to get all truck names
        Alamofire.request("http://ec2-13-57-236-241.us-west-1.compute.amazonaws.com:3000/api/v1/trucks/names", method: .get, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let data):
                // JSON map of truck names and ids
                let json = JSON(data)
                let jsonArray = json["data"].arrayValue
                for i in 0..<jsonArray.count {
                    self.truckNames.append(jsonArray[i]["name"].string!)
                    self.truckIds.append(jsonArray[i]["truck_id"].int!)
                }
                self.dataSource = SimplePrefixQueryDataSource(self.truckNames)
                self.ramReel = RAMReel(frame: self.view.bounds, dataSource: self.dataSource, placeholder: "Start by typing…", attemptToDodgeKeyboard: true) {
                    print("Plain:", $0)
                }
                
                // TODO: Replace with actual hooks
                self.ramReel.hooks.append {
                    let r = Array($0.reversed())
                    let j = String(r)
                    print("Reversed:", j)
                }
                
                self.view.addSubview(self.ramReel.view)
                self.ramReel.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            // Need to handle network error - user will not be able to access page
            case .failure(let error):
                print(error)
            }
        }
    }
}
