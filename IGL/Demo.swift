//
//  Demo.swift
//  IGL
//
//  Created by Mac Min on 30/09/18.
//  Copyright © 2018 Mac Min. All rights reserved.
//

import UIKit

class Demo: UIViewController
{
    //****  Here is IBOutlets of all StoryBoard Objects  ****//
    @IBOutlet weak var SocialIconViews: UIView!
    @IBOutlet weak var UserNameTextField: UITextField!
    
    //**** Here is default methods of UIViewController  class  ***** //
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        // write here your code
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        // write hee your code
    }
    
    //**** Here is IBActons of all Storyboad Objects *****//
    @IBAction func Login(_ send: Any)
    {
        // Please write here code for Login
        
    }
    
    
    //***** Here is UserCreated methodas  ****//
    func When_viewDidLoads()
    {
        // write code when viewDidLoad loads
        
    }
    
    func Validate_text_fields()
    {
        guard UserNameTextField.text != "" else {
            Global.showAlertMessageWithOkButtonAndTitle("User name is empty", andMessage: "")
            return
        }
    }
    
}
