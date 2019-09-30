//
//  ResetpasswordSuccessVC.swift
//  IGL
//
//  Created by Mac Min on 30/09/18.
//  Copyright © 2018 Mac Min. All rights reserved.
//

import UIKit

class ResetpasswordSuccessVC: UIViewController
{
    //****  Here is IBOutlets of all StoryBoard Objects  ****//
    @IBOutlet weak var LoginView: UIView!
    
    
                                      //**** Here is default methods of UIViewController  class  ***** //
    override func viewDidLoad()
    {
        super.viewDidLoad()
       LoginView.layer.cornerRadius = 18
    }


                                              //**** Here is IBActons of all Storyboad Objects *****//
    @IBAction func Login(_ send: Any)
    {
        // Please write here code for Login
        let storyBoardObj = UIStoryboard(name: "Main", bundle: nil)
        let loginobj = storyBoardObj.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.present(loginobj, animated: true, completion: nil)
      
    }
    
}
