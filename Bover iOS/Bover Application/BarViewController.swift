//  BarViewController.swift
//  Bover Application
//
//  Created by Abi Armstrong on 4/10/18.
//  Copyright © 2018 Abi Armstrong. All rights reserved.
//

import UIKit

class BarViewController: UIViewController, BarHomeModelDelegate,  UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var barTableView: UITableView!
    
    var barhomeModel = BarHomeModel()
    var barname = [Name]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set self as tableview data source and delegate
        barTableView.delegate = self
        barTableView.dataSource = self
        
        //intiate calling items download
        barhomeModel.barGetItems()
        barhomeModel.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func itemsDownloaded(barname: [Name]) {
        self.barname = barname
        barTableView.reloadData()
    }
    
    // MARK: -UITableView Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return barname.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let barCell = tableView.dequeueReusableCell(withIdentifier: "BarBasicCell", for: indexPath)
        barCell.textLabel?.text = barname[indexPath.row].name
        return barCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "next", sender: self)
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

