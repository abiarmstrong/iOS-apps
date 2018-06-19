//
//  ProfileViewController.swift
//  Bover Application
//
//  Created by Noah Miller on 4/17/18.
//  Copyright © 2018 Abi Armstrong. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    
    //label again don't copy instead connect
    
    @IBOutlet weak var labelUserName: UILabel!
    //button
    
    @IBAction func buttonLogout(_ sender: UIButton) {
    
    //removing values from default
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
        
        //switching to login screen
        let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "Signin") as! Signin
        self.navigationController?.pushViewController(loginViewController, animated: true)
        self.dismiss(animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hiding back button

        //getting user data from defaults
        let defaultValues = UserDefaults.standard
        if let name = defaultValues.string(forKey: "username"){
            //setting the name to label
            labelUserName.text = name
        }else{
            //send back to login view controller
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
