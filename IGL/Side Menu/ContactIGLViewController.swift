//
//  ContactIGLViewController.swift
//  IGL
//
//  Created by Mac Min on 03/11/18.
//  Copyright © 2018 Mac Min. All rights reserved.
//

import UIKit

class ContactIGLViewController: UIViewController,UITextViewDelegate{

    @IBOutlet weak var TopLayOutOfLabel: NSLayoutConstraint!
    
    @IBOutlet weak var FirstNameView: UIView!
    @IBOutlet weak var LastNameView: UIView!
    @IBOutlet weak var EmailView: UIView!
    @IBOutlet weak var MobileNumberView: UIView!
    @IBOutlet weak var MessageTextView: UITextView!
    @IBOutlet weak var SendMesageView: UIView!
    
    @IBOutlet weak var FirstNameTextField: UITextField!
    @IBOutlet weak var LastNameTextField: UITextField!
    @IBOutlet weak var Emailtextfield: UITextField!
    @IBOutlet weak var MobilenumberTextfield: UITextField!
    @IBOutlet weak var checkbutton: UIButton!
    
    //image outlet
    @IBOutlet weak var ImgFacebook: UIImageView!
    //https://twitter.com/IGLeSports
    @IBOutlet weak var imgTwiter: UIImageView!
    
    //https://www.instagram.com/iglnetwork/
    @IBOutlet weak var Instagram: UIImageView!
    //https://www.youtube.com/c/iglesports
    @IBOutlet weak var imgYoutube: UIImageView!
    
    var issubcribe = "0"
    
    func prePopulateData()
    {
        
        FirstNameTextField.text! = Global.getStringValue(UserDefaults.standard.value(forKey: "firstname") as AnyObject)
        LastNameTextField.text! = Global.getStringValue(UserDefaults.standard.value(forKey: "lastname") as AnyObject)
        Emailtextfield.text! = Global.getStringValue(UserDefaults.standard.value(forKey: "email") as AnyObject)
        MobilenumberTextfield.text! = Global.getStringValue(UserDefaults.standard.value(forKey: "mobile") as AnyObject)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prePopulateData()
        MessageTextView.delegate = self
        MessageTextView.text = "Message for IGL"
        MessageTextView.textColor = UIColor.lightGray
        // Do any additional setup after loading the view.
        // NavViewBar.titleTextAttributes =  attributes
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("iPhone 5 or 5S or 5C")
            case 1334:
                print("iPhone 6/6S/7/8")
                case 2208:
                print("iPhone 6+/6S+/7+/8+")
                case 2436:
                print("iPhone X")
                //TopLayOutOfLabel.constant = 100
            default:
                print("unknown")
            }
        }
        DecorateView()
        
      let tapGestureFacebook = UITapGestureRecognizer(target: self, action: #selector(ContactIGLViewController.FaceBookTap(_:)))
       ImgFacebook.isUserInteractionEnabled = true
       ImgFacebook.addGestureRecognizer(tapGestureFacebook)
        
        let tapGestureInsta = UITapGestureRecognizer(target: self, action: #selector(ContactIGLViewController.InstaTap(_:)))
        Instagram.isUserInteractionEnabled = true
        Instagram.addGestureRecognizer(tapGestureInsta)
        
        let tapGestureTwiter = UITapGestureRecognizer(target: self, action: #selector(ContactIGLViewController.TwiterTap(_:)))
        imgTwiter.isUserInteractionEnabled = true
        imgTwiter.addGestureRecognizer(tapGestureTwiter)
        
        let tapGestureYoutube = UITapGestureRecognizer(target: self, action: #selector(ContactIGLViewController.YoutubeTap(_:)))
        imgYoutube.isUserInteractionEnabled = true
        imgYoutube.addGestureRecognizer(tapGestureYoutube)
        
    }
    
    @objc func FaceBookTap(_ sender:AnyObject){
        print("you tap image number: \(sender.view.tag)")
        UIApplication.shared.openURL( URL(string: "https://www.facebook.com/IGLnetwork/")!)
    }
    @objc func InstaTap(_ sender:AnyObject){
       UIApplication.shared.openURL( URL(string: "https://www.instagram.com/iglnetwork/")!)
    }
    @objc func YoutubeTap(_ sender:AnyObject){
       UIApplication.shared.openURL( URL(string: "https://www.youtube.com/c/iglesports")!)
    }
    @objc func TwiterTap(_ sender:AnyObject){
        print("you tap image number: \(sender.view.tag)")
        UIApplication.shared.openURL( URL(string: "https://twitter.com/IGLeSports")!)
    }
    
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Message for IGL"
            textView.textColor = UIColor.lightGray
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func DecorateView(){
         FirstNameView.layer.cornerRadius = 12
         LastNameView.layer.cornerRadius = 12
         EmailView.layer.cornerRadius = 12
         MobileNumberView.layer.cornerRadius = 12
         MessageTextView.layer.cornerRadius = 10
         SendMesageView.layer.cornerRadius = 16
        
    }
    
    var flag = 0
    //issubcribe : 0 or 1(0 default , 1 if checkbox checked)

    @IBAction func CheckBoxaction(_ sender: Any) {
        if flag == 0{//with check//without check
            checkbutton.setImage(UIImage(named: "with check"), for: UIControlState.normal)
            print("with check")
            flag = 1
            issubcribe = "1"
        }
        else {
            checkbutton.setImage(UIImage(named: "without check"), for: UIControlState.normal)
            issubcribe = "0"
            flag = 0
        }
        
        
    }
    
    
    
    
    
    @IBAction func SendMessagevAction(_ sender: Any) {
        
        if FirstNameTextField.text! == nil || FirstNameTextField.text! == "" || FirstNameTextField.text! == "First Name"
        {
            
           Global.showAlertMessageWithOkButtonAndTitle("", andMessage: "First name cannot be blank")
        }
        else if LastNameTextField.text! == nil || LastNameTextField.text! == "" || LastNameTextField.text! ==  "Last Name"{
            Global.showAlertMessageWithOkButtonAndTitle("", andMessage: "Last name cannot be blank")
        }
        else if Emailtextfield.text! == "" || Emailtextfield.text! == nil || Emailtextfield.text! == "Email"{
            Global.showAlertMessageWithOkButtonAndTitle("", andMessage: "Email cannot be blank")
        }
        else if MobilenumberTextfield.text! == "" || MobilenumberTextfield.text! == nil || MobilenumberTextfield.text! == "Mobile Number"{
            Global.showAlertMessageWithOkButtonAndTitle("", andMessage: "Mobile number cannot be blank")
        }
        else if MessageTextView.text! == nil || MessageTextView.text! == "" || MessageTextView.textColor == UIColor.lightGray
        {
            Global.showAlertMessageWithOkButtonAndTitle("", andMessage: "Message cannot be blank")
        }
        else {
            Contact()
        }
        
        
    }
    
    
    @IBAction func BackAction(_ sender: UIButton) {
        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
        let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"SW-Reaveal") as! SWRevealViewController
        self.present(SwreavelObj, animated: true, completion: nil)
    }
    @IBAction func NotiAction(_ sender:Any)
    {
        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
        let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(SwreavelObj, animated: true)
    }
    
    
    func Contact() {
        var DicInput = [String:AnyObject]()
        DicInput = ["firstname":FirstNameTextField.text! as AnyObject,"lastname":LastNameTextField.text! as AnyObject,"email":Emailtextfield.text! as AnyObject,"mobile": MobilenumberTextfield.text! as AnyObject,"message":MessageTextView.text! as AnyObject,"issubcribe":self.issubcribe as! AnyObject]
        print("input data is",DicInput)
        WebHelper.requestPostUrl(strURL: GlobalConstant.contactus, Dictionary: DicInput, Success: {success in
            let status = String(describing: success.value(forKey: "status")!)
            if status == "1"{
                self.MessageTextView.text = "Message for IGL"
                self.MessageTextView.textColor = UIColor.lightGray
                self.MessageTextView.resignFirstResponder()
                self.Showpopupdismiss(message: success.value(forKey: "msg") as! String)
            }
            else if status == "0"
            {
                
            }
        }, Failure: {failler in
            //Global.showAlertMessageWithOkButtonAndTitle("", andMessage: failler.localizedDescription)
            
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
