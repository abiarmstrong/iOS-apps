//  BarHomeModel.swift
//  Bover Application
//
//  Created by Abi Armstrong on 4/10/18.
//  Copyright © 2018 Abi Armstrong. All rights reserved.
//
import UIKit

protocol BarHomeModelDelegate {
    func itemsDownloaded(barname:[Name])
}

class BarHomeModel: NSObject {
    
    var delegate:BarHomeModelDelegate?
    
    func barGetItems() {
        //hit web service url
        let serviceUrl = "http://cgi.soic.indiana.edu/~abiarmst/barname.php"
        //download json data
        let url = URL(string: serviceUrl)
        if let url = url {
            // create url session
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url, completionHandler:
            {(data, response, error ) in
                if error == nil {
                    // succeeded
                    
                    //call parseJson data function
                    self.parseJson(data!)
                }
                else {
                    //error occured
                }
                
            })
            //start the task
            task.resume()
        }
        
        //notify view controller and pass the data back
    }
    func parseJson(_ data:Data) {
        
        var barNameArray = [Name]()
        
        do {
            
            //parse data into json obj
            let BarjsonArray = try JSONSerialization.jsonObject(with: data, options: []) as! [Any]
            
            //loop through each result of jsonArray
            for jsonResult in BarjsonArray {
                //cast json result as a dict
                let jsonDict = jsonResult as! [String:Any]
                //create new city and set its prop
                let barName = Name(name: jsonDict["Name"]! as! String, address: jsonDict["Address"]! as! String, city: jsonDict["City"]! as! String, zip: jsonDict["Zip"]! as! String, state: jsonDict["State"]! as! String, phone: jsonDict["Phone"]! as! String)                //add to array
                barNameArray.append(barName)
            }
            
            DispatchQueue.main.async {
                //pass cityArray back to delegate
                self.delegate?.itemsDownloaded(barname: barNameArray)
            }
            
            
            
            
        }
        catch {
            print("There was an error!")
        }}}

