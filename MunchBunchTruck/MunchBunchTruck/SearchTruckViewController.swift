//
//  SearchTruckViewController.swift
//  MunchBunchTruck
//
//  Created by Kevin Nguyen on 3/22/18.
//  Copyright © 2018 munch-bunch-app. All rights reserved.
//

import UIKit
import RAMReel

class SearchTruckViewController: UIViewController, UICollectionViewDelegate {
    
    // Data
    var dataSource: SimplePrefixQueryDataSource!
    var ramReel: RAMReel<RAMCell, RAMTextField, SimplePrefixQueryDataSource>!
    
    // TODO: Delete dummy data
    let data: [String] = ["Kevin", "Jimbus", "Justine", "Peanut", "Geralt", "Yennefer", "Richard", "Kahlan", "Roland"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Make networked call to get all truck names
        dataSource = SimplePrefixQueryDataSource(data)
        ramReel = RAMReel(frame: view.bounds, dataSource: dataSource, placeholder: "Start by typing…", attemptToDodgeKeyboard: true) {
            print("Plain:", $0)
        }
        
        // TODO: Replace with actual hooks
        ramReel.hooks.append {
            let r = Array($0.reversed())
            let j = String(r)
            print("Reversed:", j)
        }
        
        view.addSubview(ramReel.view)
        ramReel.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
