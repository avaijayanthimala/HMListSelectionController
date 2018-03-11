//
//  HMListSelectionViewController.swift
//  HMListSelectionController
//
//  Created by Mala on 09/03/18.
//  Copyright © 2018 Hakuna Matata. All rights reserved.
//

import Foundation
import UIKit

public protocol HMListSelectionDelegate {
    func multiselectData(selectedItem: NSArray)
    func addNewItems()
}

public class HMListSelectionController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
   
    //MARK: - IBOutlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnDone: UIButton!
    
    //MARK: - Properties
    public var aryList = [String] ()
    public var selectedary = [String]()
    public var filteredAryList = [String] ()
    public var navTitle : String?
    public var delegate : HMListSelectionDelegate?
    let searchController = UISearchController(searchResultsController: nil)
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.isNavigationBarHidden = true
        lblTitle.text = navTitle
        setupSearchController()
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Tableview Datasource
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredAryList.count
        }
            return aryList.count
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if let _ = cell {
            
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell") as UITableViewCell
        }
        
        let row = indexPath.row
        if searchController.isActive && searchController.searchBar.text != "" {
            let selectedText = filteredAryList[row]
            cell!.textLabel?.font = UIFont.systemFont(ofSize: 14)
            cell!.textLabel?.text = filteredAryList[row]
            cell!.selectionStyle = .none
            cell!.accessoryType = self.selectedary.contains(selectedText) ? .checkmark : .none
        } else {
            let selectedText = aryList[row]
            cell!.textLabel?.font = UIFont.systemFont(ofSize: 14)
            cell!.textLabel?.text = aryList[row]
            cell!.selectionStyle = .none
            cell!.accessoryType = self.selectedary.contains(selectedText) ? .checkmark : .none
        }
       
        return cell!
    }
    
    //MARK: - Tableview Delegate
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchController.isActive && searchController.searchBar.text != "" {
            if self.selectedary.contains(filteredAryList[indexPath.row]) {
                self.selectedary.remove(at: self.selectedary.index(of: filteredAryList[indexPath.row])!)
            } else {
                self.selectedary.append(filteredAryList[indexPath.row])
            }
        } else {
            if self.selectedary.contains(aryList[indexPath.row]) {
                self.selectedary.remove(at: self.selectedary.index(of: aryList[indexPath.row])!)
            } else {
                self.selectedary.append(aryList[indexPath.row])
            }
        }
        tableView.reloadData()
    }
    
    //MARK: - Search Bar
    
    func setupSearchController() {
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.barTintColor = UIColor(white: 0.9, alpha: 0.9)
        searchController.searchBar.placeholder = "Search"
        searchController.hidesNavigationBarDuringPresentation = false
        
        tableView.tableHeaderView = searchController.searchBar
    }
    
    func filterRowsForSearchedText(_ searchText: String) {
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchText)
        let array = (self.aryList as NSArray).filtered(using: searchPredicate)
        self.filteredAryList = array as! [String]
        tableView.reloadData()
    }
    
    //MARK: - Search Result Updating
    public func updateSearchResults(for searchController: UISearchController) {
        if let term = searchController.searchBar.text {
            filterRowsForSearchedText(term)
        }
    }
    
    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnDoneClicked(_ sender: Any) {
        self.delegate?.multiselectData(selectedItem: selectedary as NSArray)
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnAddNewItemClicked(_ sender: Any) {
        self.delegate?.addNewItems()
    }
    
}
