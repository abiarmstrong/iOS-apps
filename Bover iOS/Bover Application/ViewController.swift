//
//  ViewController.swift
//  Bover Application
//
//  Created by Abi Armstrong on 4/5/18.
//  Copyright © 2018 Abi Armstrong. All rights reserved.
//

import UIKit


import Alamofire
import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textFieldUsername: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPhone: UITextField!
    @IBOutlet weak var labelMessage: UILabel!
    

    
    
    
    @IBAction func buttonRegister(_ sender: UIButton) {
        
        let URL_USER_REGISTER = "http://cgi.soic.indiana.edu/~nolomill/register/v1/register.php"
        
        let parameters: Parameters=[
            "username":textFieldUsername.text!,
            "password":textFieldPassword.text!,
            "email":textFieldEmail.text!,
            "phone":textFieldPhone.text!
        ]
        
        Alamofire.request(URL_USER_REGISTER, method: .post, parameters: parameters).responseJSON
            {
                response in
                //printing response
                print(response)
                
                //getting the json value from the server
                if let result = response.result.value {
                    
                    //converting it as NSDictionary
                    let jsonData = result as! NSDictionary
                    
                    //displaying the message in label
                    self.labelMessage.text = jsonData.value(forKey: "message") as! String?
                }

        
        
        }}
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
        
        toolbar.setItems([doneButton], animated: false)
        
        textFieldUsername.inputAccessoryView = toolbar
        textFieldPassword.inputAccessoryView = toolbar
        textFieldEmail.inputAccessoryView = toolbar
        textFieldPhone.inputAccessoryView = toolbar
        

    }
    
    @objc func doneClicked() {
        view.endEditing(true)
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}


