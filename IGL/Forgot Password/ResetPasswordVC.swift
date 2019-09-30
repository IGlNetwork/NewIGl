//
//  ResetPasswordVC.swift
//  IGL
//
//  Created by Mac Min on 30/09/18.
//  Copyright © 2018 Mac Min. All rights reserved.
//

import UIKit

class ResetPasswordVC: UIViewController
{
                         //****  Here is IBOutlets of all StoryBoard Objects  ****//
   
    @IBOutlet weak var LoginView: UIView!
  
    @IBOutlet weak var NewPassword: UITextField!
    @IBOutlet weak var ConfirmPassword: UITextField!
   
    var user_id = ""
    
    
                         //**** Here is default methods of UIViewController  class  ***** //
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.When_viewDidLoads()
    }

                        //**** Here is IBActons of all Storyboad Objects *****//
    @IBAction func Submit(_ send: Any)
    {
        // Please write here code for Login
        resetPassword()
    }

    func When_viewDidLoads()
    {
        // write code when viewDidLoad loads
        LoginView.layer.cornerRadius = 17
        NewPassword.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: NewPassword.frame.height))
        NewPassword.leftViewMode = .always
        ConfirmPassword.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: ConfirmPassword.frame.height))
        ConfirmPassword.leftViewMode = .always
        NewPassword.layer.borderWidth = 0.4
        NewPassword.layer.borderColor = #colorLiteral(red: 0.1098039216, green: 0.5725490196, blue: 0.9137254902, alpha: 0.8611943493)
        
        ConfirmPassword.layer.borderWidth = 0.4
        ConfirmPassword.layer.borderColor = #colorLiteral(red: 0.1098039216, green: 0.5725490196, blue: 0.9137254902, alpha: 0.8611943493)
        
        user_id = UserDefaults.standard.value(forKey: "user_id") as! String
    }
    
    func When_viewWillAppears()
    {
        // write code when viewDidLoad loads
    }
    
    func Validate_text_fields() -> Bool
    {
        guard NewPassword.text != "" else {
            Global.showAlertMessageWithOkButtonAndTitle("New password is empty", andMessage: "")
            return false
        }
        
        guard ConfirmPassword.text != "" else {
            Global.showAlertMessageWithOkButtonAndTitle("Confirm password is empty", andMessage: "")
            return false
        }
        
        guard NewPassword.text == ConfirmPassword.text else {
             Global.showAlertMessageWithOkButtonAndTitle("Password does not match", andMessage: "")
            return false
        }
        return true
    }
   // ============ API Calling ============
    func resetPassword()
    {
        var dictPost:[String: AnyObject]!
        
        dictPost = ["user_id":user_id as AnyObject,"newpassword":NewPassword.text as AnyObject]
        print("Dictionary:",dictPost)
        
        if self.Validate_text_fields()
        {
            WebHelper.requestPostUrl(strURL: GlobalConstant.reset_password, Dictionary: dictPost, Success:{
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
                    let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
                    let vc : ResetpasswordSuccessVC = mainStoryboard.instantiateViewController(withIdentifier: "ResetpasswordSuccessVC")as! ResetpasswordSuccessVC
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
    
}
