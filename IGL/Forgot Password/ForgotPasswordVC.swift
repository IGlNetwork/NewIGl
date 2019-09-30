//
//  ForgotPasswordVC.swift
//  IGL
//
//  Created by Mac Min on 30/09/18.
//  Copyright © 2018 Mac Min. All rights reserved.
//

import UIKit

class ForgotPasswordVC: UIViewController
{
                   //****  Here is IBOutlets of all StoryBoard Objects     ****//
    @IBOutlet weak var SubmitView:UIView!
    @IBOutlet weak var EmailTextField:UITextField!
    
    
    
                //**** Here is default methods of UIViewController  class  ***** //
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.When_viewDidLoads()
    }


                     //**** Here is IBActons of all Storyboad Objects *****//
    @IBAction func Submit_forgot_passwords(_ sender: Any)
    {
        // write hee your code for Submit_forgot_passwords
        if Global.isValidEmailAddress(emailAddressString: EmailTextField.text!) == true{
            forgotPassword()
        }else{
            Global.showAlertMessageWithOkButtonAndTitle("Email is not valid", andMessage: "")
        }
       
    }
    
    
                         //***** Here is UserCreated methodas  ****//
    func When_viewDidLoads()
    {
        // write code when viewDidLoad loads
        
        EmailTextField.layer.borderWidth = 0.3
        EmailTextField.layer.borderColor = #colorLiteral(red: 0.1098039216, green: 0.5725490196, blue: 0.9137254902, alpha: 0.8611943493)
        EmailTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: EmailTextField.frame.height))
        EmailTextField.leftViewMode = .always
        
        SubmitView.layer.cornerRadius = 17
      
    }
    
    func When_viewWillAppears()
    {
        // write code when viewDidLoad loads
        
    }
    
    //  ============ API Calling ================
    
    func forgotPassword()
    {
        var dictPost:[String: AnyObject]!
        dictPost = ["email":EmailTextField.text as AnyObject]
        print("Dictionary:",dictPost)
        
        if self.EmailTextField.text != nil
        {
            WebHelper.requestPostUrl(strURL: GlobalConstant.forget_password, Dictionary: dictPost, Success:{
                success in
                let status = success.object(forKey: "status") as! String
                print("status:",status)
                /// Result fail
                if status == "0"
                {
                    
                    Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage: success.object(forKey: "msg") as! String)
                }
                    /// Result success
                else if status == "1"
                {
                    
                    Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage: success.object(forKey: "msg") as! String)
                    let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    let vc:ResetPasswordVC = mainStoryboard.instantiateViewController(withIdentifier: "ResetPasswordVC") as! ResetPasswordVC
                    self.present(vc, animated: true, completion: nil)
                }  /// Result nil
                else
                {
                    //Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage: GlobalConstant.InternalServerErrorMessage)
                }
            }, Failure: {
                failure in
                Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage: failure.localizedDescription)
            })
            
        }
        
    }
    
    @IBAction func BackAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
