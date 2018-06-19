//  HomeModel.swift
//  Bover Application
//
//  Created by Abi Armstrong on 4/9/18.
//  Copyright © 2018 Abi Armstrong. All rights reserved.
//

import UIKit

protocol HomeModelDelegate {
    func itemsDownloaded(citi:[City])
}

class HomeModel: NSObject {
    
    var delegate:HomeModelDelegate?
    
    func getItems() {
        //hit web service url
        let serviceUrl = "http://cgi.soic.indiana.edu/~abiarmst/city.php"
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
        
        var cityArray = [City]()
        
        do {
            
            //parse data into json obj
            let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as! [Any]
            
            //loop through each result of jsonArray
            for jsonResult in jsonArray {
                //cast json result as a dict
                let jsonDict = jsonResult as! [String:Any]
                //create new city and set its prop
                let cities = City(city: jsonDict["City"]! as! String)
                //add to array
                cityArray.append(cities)
            }
            
            DispatchQueue.main.async {
                //pass cityArray back to delegate
                self.delegate?.itemsDownloaded(citi: cityArray)
            }
            
            
        }
        catch {
            print("There was an error!")
        }}}

