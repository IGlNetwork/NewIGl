//
//  RegistrationVC.swift
//  IGL
//
//  Created by Mac Min on 30/09/18.
//  Copyright © 2018 Mac Min. All rights reserved.
//

import UIKit

class RegistrationVC: UIViewController
{
    
                            //****  Here is IBOutlets of all StoryBoard Objects  ****//
     @IBOutlet weak var RegisterNowView: UIView!
     @IBOutlet weak var LoginView: UIView!
     @IBOutlet weak var SocialIconView: UIView!
    
    @IBOutlet weak var FirstNameTextField:UITextField!
    @IBOutlet weak var LastNameTextField:UITextField!
    @IBOutlet weak var EmailTextField:UITextField!
    @IBOutlet weak var MobileNumerTextField:UITextField!
    @IBOutlet weak var PasswordTextField:UITextField!
    @IBOutlet weak var ConfirmPasswordTextField:UITextField!
    @IBOutlet weak var TermAndConditionButon:UIButton!
  
    
    
    var termnCondition = "1"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
       self.When_viewDidLoads()
    }

    override func viewWillAppear(_ animated: Bool)
    {
        // write here your code
    }

                        //**** Here is IBActons of all Storyboad Objects *****//
    
    @IBAction func Register_now(_ sender: Any)
    {
        // write hee your code for Registe_now
         self.registration()
    }
    
    @IBAction func Login(_ sender: Any)
    {
       let LoginObj = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.present(LoginObj, animated: true, completion: nil)
    }
    
    @IBAction func signup_using_facebook(_ sender: Any)
    {
        // write hee your code for signup_using_facebook
    }
    @IBAction func  signup_using_gmail(_ sender: Any)
    {
        // write hee your code for signup_using_gmail
    }
    
    @IBAction func  signup_using_chat(_ sender: Any)
    {
        // write hee your code for signup_using_chat
    }
    
    @IBAction func  signup_using_share(_ sender: Any)
    {
        // write hee your code for signup_using_share
    }
    
    @IBAction func Check_mark(_ sender: Any)
    {
        // write hee your code for Check_mark
    }
    
    @IBAction func  Privacy_policy(_ sender: Any)
    {
        // write hee your code for Privacy_policy
    }
    var falg = true
    @IBAction func  Terms_and_conditons(_ sender: Any)
    {
        if falg == true{
            TermAndConditionButon.setImage(UIImage(named: "Uncheck"), for: UIControlState.normal)
            termnCondition = "0"
           falg = false
        }else{
             TermAndConditionButon.setImage(UIImage(named: "check"), for: UIControlState.normal)
            termnCondition = "1"
            print("terms n conditions",termnCondition)
          falg = true
        }
        // write hee your code for Terms_and_conditons
    }
    
    
    
                         //***** Here is UserCreated methodas  ****//

    func When_viewDidLoads()
    {
        // write code when viewDidLoad loads
        RegisterNowView.layer.cornerRadius = 15.0
        LoginView.layer.cornerRadius = 15.0
        
        MobileNumerTextField.keyboardType = .numberPad
        EmailTextField.keyboardType = .emailAddress
        
        FirstNameTextField.autocapitalizationType = .words
        LastNameTextField.autocapitalizationType = .words
        
        TermAndConditionButon.layer.borderColor = #colorLiteral(red: 0.1098039216, green: 0.5725490196, blue: 0.9137254902, alpha: 0.8611943493)
        TermAndConditionButon.layer.borderWidth = 0.8
        FirstNameTextField.layer.borderWidth = 0.3
        FirstNameTextField.layer.borderColor = #colorLiteral(red: 0.1098039216, green: 0.5725490196, blue: 0.9137254902, alpha: 0.8611943493)
        FirstNameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: EmailTextField.frame.height))
        FirstNameTextField.leftViewMode = .always
        
        LastNameTextField.layer.borderWidth = 0.3
        LastNameTextField.layer.borderColor = #colorLiteral(red: 0.1098039216, green: 0.5725490196, blue: 0.9137254902, alpha: 0.8611943493)
        LastNameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: EmailTextField.frame.height))
        LastNameTextField.leftViewMode = .always
        
        EmailTextField.layer.borderWidth = 0.3
        EmailTextField.layer.borderColor = #colorLiteral(red: 0.1098039216, green: 0.5725490196, blue: 0.9137254902, alpha: 0.8611943493)
        EmailTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: EmailTextField.frame.height))
        EmailTextField.leftViewMode = .always
        
        MobileNumerTextField.layer.borderWidth = 0.3
        MobileNumerTextField.layer.borderColor = #colorLiteral(red: 0.1098039216, green: 0.5725490196, blue: 0.9137254902, alpha: 0.8611943493)
        MobileNumerTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: EmailTextField.frame.height))
        MobileNumerTextField.leftViewMode = .always
        
        
        PasswordTextField.layer.borderWidth = 0.3
        PasswordTextField.layer.borderColor = #colorLiteral(red: 0.1098039216, green: 0.5725490196, blue: 0.9137254902, alpha: 0.8611943493)
        PasswordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: EmailTextField.frame.height))
        PasswordTextField.leftViewMode = .always
        
        ConfirmPasswordTextField.layer.borderWidth = 0.3
        ConfirmPasswordTextField.layer.borderColor = #colorLiteral(red: 0.1098039216, green: 0.5725490196, blue: 0.9137254902, alpha: 0.8611943493)
        ConfirmPasswordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: EmailTextField.frame.height))
        ConfirmPasswordTextField.leftViewMode = .always
        
    }
    
    func When_viewWillAppears()
    {
        // write code when viewDidLoad loads
        
    }
    
    func Validate_text_fields() -> Bool
    {
        guard FirstNameTextField.text != "" else {
          Global.showAlertMessageWithOkButtonAndTitle("First name is empty", andMessage: "")
          return false
        }
        guard FirstNameTextField.text!.count > 4 else {
            Global.showAlertMessageWithOkButtonAndTitle("First name must be greater than 4 characters long", andMessage: "")
            return false
        }
        guard FirstNameTextField.text!.count < 21 else {
            Global.showAlertMessageWithOkButtonAndTitle("First name must be less than 20 characters long", andMessage: "")
            return false
        }
        guard LastNameTextField.text != "" else {
            Global.showAlertMessageWithOkButtonAndTitle("Last name is empty", andMessage: "")
            return false
        }
        guard LastNameTextField.text!.count > 4 else {
            Global.showAlertMessageWithOkButtonAndTitle("Last name must be greater than 4 characters long", andMessage: "")
            return false
        }
        guard LastNameTextField.text!.count < 21 else {
            Global.showAlertMessageWithOkButtonAndTitle("Last name must be less than 20 characters long", andMessage: "")
            return false
        }
      
        guard EmailTextField.text != "" else {
            Global.showAlertMessageWithOkButtonAndTitle("Email is empty", andMessage: "")
            return false
        }
        guard Global.isValidEmailAddress(emailAddressString: EmailTextField.text!) == true else {
            Global.showAlertMessageWithOkButtonAndTitle("Email is not valid", andMessage: "")
            return false
        }
        guard MobileNumerTextField.text != "" else {
            Global.showAlertMessageWithOkButtonAndTitle("Mobile numer is empty", andMessage: "")
            return false
        }
        guard Global.myMobileNumberValidate(MobileNumerTextField.text!) ==  true else {
            Global.showAlertMessageWithOkButtonAndTitle("Mobile number is not valid", andMessage: "")
            return false
        }
        //myMobileNumberValidate
        guard PasswordTextField.text != "" else {
            Global.showAlertMessageWithOkButtonAndTitle("Password is empty", andMessage: "")
            return false
        }
        guard ConfirmPasswordTextField.text != "" else {
            Global.showAlertMessageWithOkButtonAndTitle("Confirm passwor is empty", andMessage: "")
            return false
        }
        guard PasswordTextField.text!.count > 5 || ConfirmPasswordTextField.text!.count > 5 else {
            Global.showAlertMessageWithOkButtonAndTitle("Enter password minimum 6-8 characters long", andMessage: "")
            
            return false
        }
        guard PasswordTextField.text == ConfirmPasswordTextField.text else {
            Global.showAlertMessageWithOkButtonAndTitle("Password does not match", andMessage: "")
            
            return false
        }
        guard termnCondition == "1" else {
            Global.showAlertMessageWithOkButtonAndTitle("Select terms and conditions", andMessage: "")
            
            return false
        }
        //termnCondition
    return true
    }
   
    // ============ API Calling ============
    func registration()
    {
        var dictPost:[String: AnyObject]!
        dictPost = ["firstname":FirstNameTextField.text as AnyObject,"lastname":LastNameTextField.text as AnyObject,"email":EmailTextField.text as AnyObject,"mobile":MobileNumerTextField.text as AnyObject,"password":PasswordTextField.text as AnyObject]
        print("Dictionary:",dictPost)
        
        if self.Validate_text_fields()
        {
            WebHelper.requestPostUrl(strURL: GlobalConstant.register, Dictionary: dictPost, Success:{
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
                    let storyBoardObj = UIStoryboard(name: "Main", bundle: nil)
                    let loginobj = storyBoardObj.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                    self.present(loginobj, animated: true, completion: nil)
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
