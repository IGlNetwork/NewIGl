//
//  SettingUpdateViewController.swift
//  IGL
//
//  Created by baps on 04/11/18.
//  Copyright © 2018 Mac Min. All rights reserved.
//

import UIKit

class SettingUpdateViewController: UIViewController {

    
    
    @IBOutlet weak var MenuBtn:UIBarButtonItem!
//    @IBOutlet weak var UpdateProfileButton: UIButton!
//
//    @IBOutlet weak var ChangeBioButton: UIButton!
    //UIView
    @IBOutlet weak var SettingOptionView: UIView!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var ChangeProfileView: UIView!
    @IBOutlet weak var ChangePasswordView: UIView!
    @IBOutlet weak var changeBioView: UIView!
    //View For Chnage Password
    
    @IBOutlet weak var CurrentPasswordView: UIView!
    @IBOutlet weak var NewPasswordView: UIView!
    @IBOutlet weak var ConfirmPasswordView: UIView!
    
    //view for update profile
    @IBOutlet weak var NameView: UIView!
    @IBOutlet weak var EmailView: UIView!
    @IBOutlet weak var Mobileview: UIView!
    @IBOutlet weak var View2: UIView!
    @IBOutlet weak var View3: UIView!
    @IBOutlet weak var View1: UIView!
    @IBOutlet weak var View4: UIView!
    @IBOutlet weak var View5: UIView!
    
    //For Update Profile
     @IBOutlet weak var UpdateProfile:UIView!
    //button
    @IBOutlet weak var MaleRadioButton: UIButton!
    @IBOutlet weak var FemaleRadioButton: UIButton!
    @IBOutlet weak var CustomRadioButton: UIButton!
    @IBOutlet weak var UpdateprofileBurtton: UIButton!
     @IBOutlet weak var ChangeBIOButton: UIButton!
     @IBOutlet weak var ChangePasswordButton: UIButton!
    //TextField
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var EmailIdtextField: UITextField!
    @IBOutlet weak var MobileTextfield: UITextField!
    @IBOutlet weak var GameOneTextField: UITextField!
    @IBOutlet weak var GameTwotextField: UITextField!
    @IBOutlet weak var GameThreeTextField: UITextField!
    @IBOutlet weak var GameFourTextField: UITextField!
    @IBOutlet weak var gameFiveTextField: UITextField!
    ///............................For Cange password
    
    @IBOutlet weak var CurrentPasswordTextFiled: UITextField!
    @IBOutlet weak var NewPasswordTextField: UITextField!
    @IBOutlet weak var ConfirmPasswordtextField: UITextField!
    @IBOutlet weak var Updatepassword: UIView!
    //Gaming Plateform editing
    
    @IBOutlet weak var PSGamingTextField: UITextField!
    @IBOutlet weak var XBOXtextField: UITextField!
    @IBOutlet weak var SteamGametextField: UITextField!
    @IBOutlet weak var NintedoGameTextField: UITextField!
    @IBOutlet weak var MobilegameTextField: UITextField!
    
    //Change BIo
    @IBOutlet weak var BIODescriptionTextView: UITextView!
    
    /*1. PS , 2. nintendo, 3. steam , 4. xbox*/
    var UserGender = ""
    var Userfemalgender = ""
    var UserCustomGender = ""
    var iscoming_From_PRofile = false
    var Coming_from_Bio = false
    @IBOutlet weak var UpdateBioView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //add padding to the textview
        BIODescriptionTextView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10)
         BIODescriptionTextView.layer.cornerRadius = 4
        if Coming_from_Bio == true{
            ChangePasswordView.isHidden = true
            changeBioView.isHidden = false
            ChangeProfileView.isHidden = true
             ChangeBIOButton.backgroundColor = #colorLiteral(red: 0.1137254902, green: 0.3333333333, blue: 0.5176470588, alpha: 1)
             UpdateprofileBurtton.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.5254901961, blue: 0.8, alpha: 1)
        }else{
            ChangePasswordView.isHidden = true
            changeBioView.isHidden = true
            ChangeProfileView.isHidden = false
            UpdateprofileBurtton.backgroundColor = #colorLiteral(red: 0.1137254902, green: 0.3333333333, blue: 0.5176470588, alpha: 1)
        }
        
             Global.buttonCornerRadius(MaleRadioButton)
             Global.buttonCornerRadius(FemaleRadioButton)
             Global.buttonCornerRadius(CustomRadioButton)
             CustomRadioButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
             UpdateProfile.layer.cornerRadius = 15
             UpdateprofileBurtton.roundedButton()
             ChangeBIOButton.RightroundedButton()
             SettingOptionView.layer.cornerRadius = 45
        
            //for change password
             CurrentPasswordView.layer.cornerRadius = 12
             NewPasswordView.layer.cornerRadius = 12
             ConfirmPasswordView.layer.cornerRadius = 12
        
            //for the update profile
             NameView.layer.cornerRadius = 12
             EmailView.layer.cornerRadius = 12
             Mobileview.layer.cornerRadius = 12
             View2.layer.cornerRadius = 12
             View3.layer.cornerRadius = 12
             View1.layer.cornerRadius = 12
             View4.layer.cornerRadius = 12
             View5.layer.cornerRadius = 12

    }
    override func viewWillAppear(_ animated: Bool) {
        self.Get_personalInfo()
    }
   
    
    
   
    var flag1 = 0
    @IBAction func MaleAction(_ sender: UIButton) {
        if flag1 == 0{
            self.MaleRadioButton.layer.borderWidth = 5
            self.MaleRadioButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.MaleRadioButton.backgroundColor = UIColor.clear
            
            self.FemaleRadioButton.layer.borderWidth = 0
            FemaleRadioButton.backgroundColor = UIColor.white
            
            self.CustomRadioButton.layer.borderWidth = 0
            self.CustomRadioButton.backgroundColor = UIColor.white
            self.UserGender = "0"
            flag1 = 1
            flag2 = 0
            flag3 = 0        }
        else{
            self.MaleRadioButton.layer.borderWidth = 0.0
            self.MaleRadioButton.backgroundColor = UIColor.white
            flag1 = 0
            
        }
        
    }
    
    var flag2 = 0
    @IBAction func Femaleaction(_ sender: Any) {
        if flag2 == 0{
            self.UserGender = "1"
            self.FemaleRadioButton.layer.borderWidth = 5
            self.FemaleRadioButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.FemaleRadioButton.backgroundColor = UIColor.clear
            
            self.MaleRadioButton.layer.borderWidth = 0
           self.MaleRadioButton.backgroundColor = UIColor.white
            
            self.CustomRadioButton.layer.borderWidth = 0
            self.CustomRadioButton.backgroundColor = UIColor.white
            
            flag2 = 1
            flag1 = 0
            flag3 = 0
        }
        else{
            self.FemaleRadioButton.layer.borderWidth = 0.0
            self.FemaleRadioButton.backgroundColor = UIColor.white
            flag2 = 0
            
        }
    }
    
    var flag3 = 0
    @IBAction func CustomAction(_ sender: Any) {
        if flag3 == 0{
            
            self.CustomRadioButton.layer.borderWidth = 5
            self.CustomRadioButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.CustomRadioButton.backgroundColor = UIColor.clear
            
            self.MaleRadioButton.layer.borderWidth = 0
          self.MaleRadioButton.backgroundColor = UIColor.white
            
            self.FemaleRadioButton.layer.borderWidth = 0
          self.FemaleRadioButton.backgroundColor = UIColor.white
             self.UserGender = "3"
            flag3 = 1
            flag2 = 0
            flag1 = 0
                  }
        else{
            self.CustomRadioButton.layer.borderWidth = 0.0
            self.CustomRadioButton.backgroundColor = UIColor.white
            flag3 = 0
            
        }
    }
   
    @IBAction func SubmitEditedProfileAction(_ sender: Any) {
      Update_Profile()
   }
    
    
    @IBAction func UpdateBIo(_ sender: Any) {
         Update_Profile()
    }
    
    
    @IBAction func UpdatePasswordAction(_ sender: Any) {
        
        if CurrentPasswordTextFiled.text == nil || CurrentPasswordTextFiled.text! == ""{
            Global.showAlertMessageWithOkButtonAndTitle("", andMessage: "Current password cannot be blank")
        }
        else if NewPasswordTextField.text! == "" || NewPasswordTextField.text! == nil{
            Global.showAlertMessageWithOkButtonAndTitle("", andMessage: "New password cannot be blank")
        }
        else if ConfirmPasswordtextField.text! == "" || ConfirmPasswordtextField.text! == nil{
            Global.showAlertMessageWithOkButtonAndTitle("", andMessage: "Confirm password cannot be blank")
        }
        else if NewPasswordTextField.text! == ConfirmPasswordtextField.text!{
            ChangPassword(newPassword: NewPasswordTextField.text!)
        }
        else{
            Global.showAlertMessageWithOkButtonAndTitle("", andMessage: "Confirm password and New password does not match")
        }
    }
    
    
    
    var Updateprofile = 1
    @IBAction func UpdateProfileAction(_ sender: UIButton) {
        Updateprofile = 1
        UpdateprofileBurtton.backgroundColor = #colorLiteral(red: 0.1137254902, green: 0.3333333333, blue: 0.5176470588, alpha: 1)
        ChangeBIOButton.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.4823529412, blue: 0.7725490196, alpha: 1)
        ChangePasswordButton.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.4823529412, blue: 0.7725490196, alpha: 1)
        ChangePasswordView.isHidden = true
        changeBioView.isHidden = true
         ChangeProfileView.isHidden = false
        TitleLabel.text = "PERSONAL INFORMATION"
         UpdateProfile.layer.cornerRadius = 15
    }
   
    var changePassword = 0
    @IBAction func ChangePasswordAction(_ sender: Any) {
        changePassword = 1
        ChangePasswordButton.backgroundColor = #colorLiteral(red: 0.1137254902, green: 0.3333333333, blue: 0.5176470588, alpha: 1)
        UpdateprofileBurtton.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.4823529412, blue: 0.7725490196, alpha: 1)
        ChangeBIOButton.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.4823529412, blue: 0.7725490196, alpha: 1)
        ChangePasswordView.isHidden = false
        ChangeProfileView.isHidden = true
        changeBioView.isHidden = true
        TitleLabel.text = "UPDATE PASSWORD"
        Updatepassword.layer.cornerRadius = 15
    }
    var changeBio = 0
    @IBAction func ChangeBioAction(_ sender: UIButton) {
        changeBio = 1
        ChangeBIOButton.backgroundColor = #colorLiteral(red: 0.1137254902, green: 0.3333333333, blue: 0.5176470588, alpha: 1)
        UpdateprofileBurtton.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.4823529412, blue: 0.7725490196, alpha: 1)
        ChangePasswordButton.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.4823529412, blue: 0.7725490196, alpha: 1)
        ChangePasswordView.isHidden = true
        ChangeProfileView.isHidden = true
        changeBioView.isHidden = false
        TitleLabel.text = "UPDATE BIO"
        UpdateBioView.layer.cornerRadius = 15
    }
    
    @IBAction func BackAction(_ sender: UIButton) {
        if iscoming_From_PRofile == true{
          self.navigationController?.popViewController(animated: true)
        }else{
            let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
            let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"SW-Reaveal") as! SWRevealViewController
            self.present(SwreavelObj, animated: true, completion: nil)
        }
        
    }
    @IBAction func NotiAction(_ sender:Any)
    {
        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
        let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(SwreavelObj, animated: true)
    }
    
    func Get_personalInfo(){
        var dictPost:[String: AnyObject]!
        dictPost = ["user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject,"profile_id":"" as AnyObject]
        print("input data is......",dictPost)
        WebHelper.requestPostUrl(strURL:GlobalConstant.get_personlinfo, Dictionary: dictPost, Success: {
            success in
            print("sucess from the server is",success)
            let UserPersonalInfo = success["UserPersonalInfo"] as! NSDictionary
            let firstname = UserPersonalInfo["firstname"] as! String
            let lastname = UserPersonalInfo["lastname"] as! String
            self.NameTextField.text = UserPersonalInfo["username"] as! String

            self.EmailIdtextField.text = UserPersonalInfo["email"] as! String
          
            self.MobileTextfield.text = UserPersonalInfo["mobile"] as! String
           
            self.BIODescriptionTextView.text =  UserPersonalInfo["UserBio"] as! String
            if UserPersonalInfo["UserXboxID"] as! String != ""{
                
                self.XBOXtextField.text = UserPersonalInfo["UserXboxID"] as! String
            }else{
                 self.XBOXtextField.text = "Xbox Live ID"
            }
            if UserPersonalInfo["UserPSID"] as! String != ""{
               self.PSGamingTextField.text = UserPersonalInfo["UserPSID"] as! String
            }else{
                self.PSGamingTextField.text =  "PSN ID"
            }
            if UserPersonalInfo["UserNintendoID"] as! String != ""{
               self.NintedoGameTextField.text = UserPersonalInfo["UserNintendoID"] as! String
            }else{
                self.NintedoGameTextField.text = " Nintendo ID"
            }
            if UserPersonalInfo["UserSteamID"] as! String != ""{
              self.SteamGametextField.text = UserPersonalInfo["UserSteamID"] as! String
            }else{
               self.SteamGametextField.text = "Steam ID"
            }
            if UserPersonalInfo["UserMobileID"] as! String != ""{
               self.MobilegameTextField.text = UserPersonalInfo["UserMobileID"] as! String
            }else{
                self.MobilegameTextField.text = "Mobile Number"
            }
            print("UserMobileID----------------", UserPersonalInfo["UserMobileID"] as! String)
           
            //0 for male , 1 for female
            if UserPersonalInfo["UserGender"] as! String == "0"{
                self.MaleRadioButton.layer.borderWidth = 5
                self.MaleRadioButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                 self.MaleRadioButton.backgroundColor = UIColor.clear
            }
            else if UserPersonalInfo["UserGender"] as! String == "1"{
               self.FemaleRadioButton.layer.borderWidth = 5
                self.FemaleRadioButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                self.FemaleRadioButton.backgroundColor = UIColor.clear
            }
            else{
                self.CustomRadioButton.layer.borderWidth = 5
                self.CustomRadioButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                self.CustomRadioButton.backgroundColor = UIColor.clear
            }
        }, Failure: {failler in
        Global.showAlertMessageWithOkButtonAndTitle("", andMessage: failler.localizedDescription)
        })
    }
   
    func Update_Profile(){
        var dictPost:[String: AnyObject]!
        dictPost = ["user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject,"username":self.NameTextField.text! as AnyObject,"email":EmailIdtextField.text! as AnyObject ,"mobile":MobileTextfield.text! as AnyObject,"gender":self.UserGender as AnyObject,"bio":BIODescriptionTextView.text! as AnyObject,"UserPSID":self.PSGamingTextField.text! as AnyObject,"UserSteamID":SteamGametextField.text! as AnyObject,"UserXboxID": XBOXtextField.text! as AnyObject,"UserNintendoID":NintedoGameTextField.text! as AnyObject,"UserMobileID":MobileTextfield.text! as AnyObject]
        print("input data is......",dictPost)
        WebHelper.requestPostUrl(strURL:GlobalConstant.edit_personlinfo, Dictionary: dictPost, Success:{
            success in
            print("sucess from the server is",success)
            if  success.object(forKey: "status") as! String == "1"{
            Global.showAlertMessageWithOkButtonAndTitle("", andMessage: success["msg"] as! String)
                self.navigationController?.popViewController(animated: true)
            }
           }, Failure: {failler in
            Global.showAlertMessageWithOkButtonAndTitle("", andMessage: failler.localizedDescription)
        })
    }
   
    
    func ChangPassword(newPassword:String)  {
        var DicInput = [String:AnyObject]()
        DicInput = ["user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject,"oldpassword":CurrentPasswordTextFiled.text! as AnyObject,"newpassword":newPassword as AnyObject]
        WebHelper.requestPostUrl(strURL: GlobalConstant.change_password, Dictionary: DicInput, Success: {success in
            let status = String(describing: success.value(forKey: "status")!)
            if status == "1"{
                self.Showpopupdismiss(message: success.value(forKey: "msg") as! String)
            }
        }, Failure: {failler in
            Global.showAlertMessageWithOkButtonAndTitle("", andMessage: failler.localizedDescription)
        })
        
    }
   
    
    func Showpopupdismiss(message:String){

        let AlertObj = UIAlertController(title: "", message:message, preferredStyle: UIAlertControllerStyle.alert)
        let okk = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel) { (UIAlertAction) in
        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
            let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"SW-Reaveal") as! SWRevealViewController
            self.present(SwreavelObj, animated: true, completion: nil)
        }
        AlertObj.addAction(okk)
        self.present(AlertObj, animated: true, completion: nil)
    }
}
extension UIButton{
    func roundedButton(){
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.topLeft , .bottomLeft],
                                     cornerRadii: CGSize(width: 12, height: 12))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
    func RightroundedButton(){
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.topRight , .bottomRight],
                                     cornerRadii: CGSize(width: 12, height: 12))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
}
