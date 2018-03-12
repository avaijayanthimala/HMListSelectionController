//
//  ViewController.swift
//  HMListSelectionController
//
//  Created by avaijayanthimala on 03/11/2018.
//  Copyright (c) 2018 avaijayanthimala. All rights reserved.
//

import UIKit
import HMListSelectionController


class ViewController: UIViewController, HMListSelectionDelegate {

    var aryCars = ["swift","Maruthi","Hundai","Ford","BMW","RolesRoyals","VolsWages","Jaguar"];
    var selectedItems = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnGetItemsFromList(_ sender: Any) {
        let podBundle = Bundle(for:HMListSelectionController.self)
        if let bundleURL = podBundle.url(forResource: "HMListSelectionController", withExtension: "bundle") {
            if let bundle = Bundle(url: bundleURL) {
                let listSelectionController = HMListSelectionController(nibName: "HMListSelectionController", bundle: bundle)
                listSelectionController.delegate = self
                listSelectionController.aryList = aryCars;
                listSelectionController.selectedary = selectedItems;
                listSelectionController.addButtonNeeded = false
                listSelectionController.isMultiSelection = true
                
                let navBarProperties = NavBarPropertiesDTO()
                navBarProperties.navBarBGColor = .red
                navBarProperties.navBarTitle = "CARS LIST"
                navBarProperties.navBarFontFamily = "Helivatica"
                navBarProperties.navBarFontSize = 15
                navBarProperties.navBarTextColor = .white
                listSelectionController.navBarProperties = navBarProperties
                
//                let addBtnProperties = AddButtonPropertiesDTO()
//                addBtnProperties.btnaddBGColor = .white
//                addBtnProperties.btnaddFontFamily = "Helivatica"
//                addBtnProperties.btnaddFontSize = 15
//                addBtnProperties.btnaddTextColor = .red
//                addBtnProperties.btnaddTitle = "Add Cars"
//                listSelectionController.addButtonProperties = addBtnProperties
                self.navigationController?.pushViewController(listSelectionController, animated: true)
            }
        }
    }
    
    func multiselectData(selectedItem: NSArray) {
        NSLog("%@", selectedItem)
        self.selectedItems = selectedItem as! [String]
    }
    func addNewItems() {
        
    }

}

