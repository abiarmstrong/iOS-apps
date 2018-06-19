//  CityViewController.swift
//  Bover Application
//
//  Created by Abi Armstrong on 4/9/18.
//  Copyright © 2018 Abi Armstrong. All rights reserved.
//

import UIKit

class CityViewController: UIViewController, HomeModelDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var cityTableView: UITableView!
    
    var homeModel = HomeModel()
    var citi = [City]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set self as tableview data source and delegate
        cityTableView.delegate = self
        cityTableView.dataSource = self
        
        // intiate calling the items download
        homeModel.getItems()
        homeModel.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func itemsDownloaded(citi: [City]) {
        self.citi = citi
        cityTableView.reloadData()
        
    }
    
    // MARK: - UITableView Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citi.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath)
        cell.textLabel?.text = citi[indexPath.row].city
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToBars", sender: self)
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

