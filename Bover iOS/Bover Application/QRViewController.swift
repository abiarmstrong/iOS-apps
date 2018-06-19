//
//  QRCodeViewController.swift
//  Bover Application
//
//  Created by Ngando Ntone on 4/10/18.
//  Copyright © 2018 Abi Armstrong. All rights reserved.
//

import UIKit
import Alamofire

class QRCodeViewController: UIViewController {
    
    @IBOutlet weak var QrImage: UIImageView!
    @IBOutlet weak var CodeEntrance: UITextField!
    
    @IBOutlet weak var labelMessage: UILabel!
    
    let letters = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R"
        ,"S","T","U","V","W","X","Y","Z"]
    @IBAction func ReceiveQRCode(_ sender: UIButton) {
        CodeEntrance.text = ""
        var teststring = ""
        
        for i in 0...9 {
            let selectedPosition = Int(arc4random()) % 26
            teststring += letters[selectedPosition]
        }
        var QRCode = teststring
        let URL_USER_QRCode = "http://cgi.soic.indiana.edu/~nolomill/register/v1/QRinsert.php"
        
        let parameters: Parameters=["string":QRCode]
        
        Alamofire.request(URL_USER_QRCode, method: .post, parameters: parameters).responseJSON
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
        }
        (sender).isEnabled = false
        CodeEntrance.text = teststring
        
    }
    
    
    @IBAction func SubmitCode(_ sender: Any) {
        
        if let myString = CodeEntrance.text
        {
            let data = myString.data(using: .ascii, allowLossyConversion: false)
            let filter =  CIFilter(name: "CIQRCodeGenerator")
            filter?.setValue(data, forKey: "inputMessage")
            
            let ciImage = filter?.outputImage
            let transform = CGAffineTransform(scaleX: 10, y:10)
            let transformImage = ciImage?.transformed(by: transform)
            
            let image = UIImage(ciImage: transformImage!)
            
            
            
            QrImage.image = image
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

