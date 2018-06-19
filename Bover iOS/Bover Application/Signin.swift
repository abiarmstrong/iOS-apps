//
//  Signin.swift
//  Bover Application
//
//  Created by Noah Miller on 4/5/18.
//  Copyright © 2018 Abi Armstrong. All rights reserved.
//

import UIKit
import Alamofire

class Signin: UIViewController {
    
    //The login script url make sure to write the ip instead of localhost
    //you can get the ip using ifconfig command in terminal
    let URL_USER_LOGIN = "http://cgi.soic.indiana.edu/~nolomill/register/v1/login.php"
    
    //the defaultvalues to store user data
    let defaultValues = UserDefaults.standard
    
    //the connected views
    //don't copy instead connect the views using assistant editor
    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var textFieldUserName: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    //the button action function
    @IBAction func buttonLogin(_ sender: UIButton) {
        
        //getting the username and password
        let parameters: Parameters=[
            "username":textFieldUserName.text!,
            "password":textFieldPassword.text!
        ]
        
        //making a post request
        Alamofire.request(URL_USER_LOGIN, method: .post, parameters: parameters).responseJSON
            {
                response in
                //printing response
                print(response)
                
                //getting the json value from the server
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary
                    
                    //if there is no error
                    if(!(jsonData.value(forKey: "error") as! Bool)){
                        
                        //getting the user from response
                        let user = jsonData.value(forKey: "user") as! NSDictionary
                        
                        //getting user values
                        let userId = user.value(forKey: "UID") as! Int
                        let userName = user.value(forKey: "Username") as! String
                        let userEmail = user.value(forKey: "Email") as! String
                        let userPhone = user.value(forKey: "Phone") as! String
                        
                        //saving user values to defaults
                        self.defaultValues.set(userId, forKey: "userid")
                        self.defaultValues.set(userName, forKey: "username")
                        self.defaultValues.set(userEmail, forKey: "useremail")
                        self.defaultValues.set(userPhone, forKey: "userphone")
                        
                        //switching the screen
                        let profileViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewcontroller") as! ProfileViewController
                        self.navigationController?.pushViewController(profileViewController, animated: true)
                        
                        self.dismiss(animated: false, completion: nil)
                    }else{
                        //error message in case of invalid credential
                        self.labelMessage.text = "Invalid username or password"
                    }
                }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //hiding the navigation button
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        
        let toolbar1 = UIToolbar()
        toolbar1.sizeToFit()
        let doneButton1 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
        
        toolbar1.setItems([doneButton1], animated: false)
        
        textFieldUserName.inputAccessoryView = toolbar1
        textFieldPassword.inputAccessoryView = toolbar1
    }
    @objc func doneClicked() {
        view.endEditing(true)
    }
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        //if user is already logged in switching to profile screen
//        if defaultValues.string(forKey: "username") != nil{
//            let profileViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewcontroller") as! ProfileViewController
//            self.navigationController?.pushViewController(profileViewController, animated: true)
//
//        }
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

