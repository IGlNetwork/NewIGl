//
//  LoginViewController.swift
//  IGL
//
//  Created by Mac Min on 26/09/18.
//  Copyright © 2018 Mac Min. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController
{

                        //****  Here is IBOutlets of all StoryBoard Objects  ****//
    @IBOutlet weak var SocialIconViews: UIView!
    @IBOutlet weak var LoginView: UIView!
    @IBOutlet weak var RegisterView: UIView!
   
    @IBOutlet weak var UserNameTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
                        //**** Here is default methods of UIViewController  class  ***** //
    

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.When_viewDidLoads()
       
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
          login()
    }

    @IBAction func Forgot_password(_ send: Any)
    {
        // Please write here code for Forgot_password
        let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
        let vc : ForgotPasswordVC = mainStoryboard.instantiateViewController(withIdentifier: "ForgotPasswordVC")as! ForgotPasswordVC
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func Register_now(_ send: Any)
    {
        // Please write here code for Register_now
        let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
        let vc : RegistrationVC = mainStoryboard.instantiateViewController(withIdentifier: "RegistrationVC")as! RegistrationVC
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func Login_using_facebook(_ sender: Any)
    {
        // Please write here code for Login_using_facebook
    }
    
    @IBAction func Login_using_gmail(_ sender: Any)
    {
        // Please write here code for Login_using_facebook
    }
    
    @IBAction func Login_using_chat(_ sender: Any)
    {
        // Please write here code for Login_using_facebook
    }
    
    @IBAction func Login_using_share(_ sender: Any)
    {
        // Please write here code for Login_using_facebook
    }
    
    
                               //***** Here is UserCreated methodas  ****//
    func When_viewDidLoads()
    {
        // write code when viewDidLoad loads
        LoginView.layer.cornerRadius = 18
        RegisterView.layer.cornerRadius = 15
        UserNameTextField.layer.borderWidth = 0.3
        UserNameTextField.layer.borderColor = #colorLiteral(red: 0.1098039216, green: 0.5725490196, blue: 0.9137254902, alpha: 0.8611943493)
        PasswordTextField.layer.borderWidth = 0.3
        PasswordTextField.layer.borderColor = #colorLiteral(red: 0.1098039216, green: 0.5725490196, blue: 0.9137254902, alpha: 0.8)
        
        UserNameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: UserNameTextField.frame.height))
        UserNameTextField.leftViewMode = .always
        
        PasswordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: PasswordTextField.frame.height))
        PasswordTextField.leftViewMode = .always
    }
    
    func When_viewWillAppears()
    {
        // write code when viewDidLoad loads

    }
    
    func Validate_text_fields() -> Bool
    { 
        guard UserNameTextField.text != "" else {
            Global.showAlertMessageWithOkButtonAndTitle("User name is empty", andMessage: "")
            return false
        }
        
        guard PasswordTextField.text != "" else {
            Global.showAlertMessageWithOkButtonAndTitle("Password is empty", andMessage: "")
            return false
        }
       
        return true
    }
    
    
    // =============  API Calling  ==================
    
    func login()
    {
        var dictPost:[String: AnyObject]!//UserNameTextField.text
        dictPost = ["email": UserNameTextField.text! as AnyObject,"pwd":PasswordTextField.text! as AnyObject]
        print("Dictionary:",dictPost)
        
        if self.Validate_text_fields()
        {
            WebHelper.requestPostUrl(strURL: GlobalConstant.login, Dictionary: dictPost, Success:{
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
                     let dict = success.object(forKey: "Userdetails") as! NSDictionary
                     print("Dict::",dict,":::Dict")
                     UserDefaults.standard.set(dict.value(forKey: "SocialID") as! String, forKey: "SocialID")
                     UserDefaults.standard.set(dict.value(forKey: "SocialLoginType") as! String, forKey: "SocialLoginType")
                     UserDefaults.standard.set(dict.value(forKey: "UserBio") as! String, forKey: "UserBio")
                     UserDefaults.standard.set(dict.value(forKey: "UserCoverImage") as! String, forKey: "UserCoverImage")
                     UserDefaults.standard.set(dict.value(forKey: "UserGender") as! String, forKey: "UserGender")
                     UserDefaults.standard.set(dict.value(forKey: "UserProfileImage") as! String, forKey: "UserProfileImage")
                     UserDefaults.standard.set(dict.value(forKey: "UserType") as! String, forKey: "UserType")
                     UserDefaults.standard.set(dict.value(forKey: "activated") as! String, forKey: "activated")
                     //UserDefaults.standard.set(dict.value(forKey: "ban_reason") as! String, forKey: "ban_reason")
                     UserDefaults.standard.set(dict.value(forKey: "banned") as! String, forKey: "banned")
                     UserDefaults.standard.set(dict.value(forKey: "created") as! String, forKey: "created")
                     UserDefaults.standard.set(dict.value(forKey: "email") as! String, forKey: "email")
                     UserDefaults.standard.set(dict.value(forKey: "firstname") as! String, forKey: "firstname")
                     UserDefaults.standard.set(dict.value(forKey: "id") as! String, forKey: "user_id")
                     UserDefaults.standard.set(dict.value(forKey: "last_ip") as! String, forKey: "last_ip")
                     UserDefaults.standard.set(dict.value(forKey: "last_login") as! String, forKey: "last_login")
                     UserDefaults.standard.set(dict.value(forKey: "lastname") as! String, forKey: "lastname")
                     UserDefaults.standard.set(dict.value(forKey: "mobile") as! String, forKey: "mobile")
                     UserDefaults.standard.set(dict.value(forKey: "modified") as! String, forKey: "modified")
                    UserDefaults.standard.set(dict.value(forKey: "UserCredit") as! String, forKey: "UserCredit")//UserCredit = 49;
                    // UserDefaults.standard.set(dict.value(forKey: "new_email") as! String, forKey: "new_email")
                    // UserDefaults.standard.set(dict.value(forKey: "new_email_key") as! String, forKey: "new_email_key")
                    // UserDefaults.standard.set(dict.value(forKey: "new_password_key") as! String, forKey: "new_password_key")
                     UserDefaults.standard.set(dict.value(forKey: "password") as! String, forKey: "password")
                     UserDefaults.standard.set(dict.value(forKey: "username") as! String, forKey: "username")
                    UserDefaults.standard.set("1", forKey: "isLoggedIn")
                    let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
                    let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"SW-Reaveal") as! SWRevealViewController
                    self.present(SwreavelObj, animated: true, completion: nil)
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
