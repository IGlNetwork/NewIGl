//
//  TournamentSubmitResultVC.swift
//  IGL
//
//  Created by baps on 14/01/19.
//  Copyright © 2019 Mac Min. All rights reserved.
//

import UIKit
import LTHRadioButton

class TournamentSubmitResultVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate
{

    @IBOutlet weak var TeamNameView: UIView!
    @IBOutlet weak var TeamNameTextField: UITextField!
    @IBOutlet weak var YourGameIDView: UIView!
    @IBOutlet weak var YourGameIdTextField: UITextField!
    @IBOutlet weak var RoundView: UIView!
    @IBOutlet weak var RoundTextView: UITextField!
    
    @IBOutlet weak var UploadImageView: UIView!
    @IBOutlet weak var SubmitResultRadioButton: LTHRadioButton!
    @IBOutlet weak var DisputeRadioButton: LTHRadioButton!
    @IBOutlet weak var WonRadioButton: LTHRadioButton!
    @IBOutlet weak var LostRadioButton: LTHRadioButton!
    @IBOutlet weak var SubmitResultButton: UIButton!
    @IBOutlet weak var CameraGalleybutton: UIButton!
    @IBOutlet weak var FilePathLabel: UITextField!
    @IBOutlet weak var SubmitWithDisputeButton: UIButton!
    
    @IBOutlet weak var DisputeTextField: UITextView!
    @IBOutlet weak var disputetext: UIView!
    var tournament_id = ""
    var team_id = ""
    var isdispute = ""
    var status = "" // 0- loose, 1- won)
    var ImagePicker = UIImagePickerController()
    var Image:UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
         DisputeTextField.layer.cornerRadius = 18
         TeamNameView.layer.cornerRadius = 18
         YourGameIDView.layer.cornerRadius = 18
         RoundView.layer.cornerRadius = 18
         UploadImageView.layer.cornerRadius = 18
         SubmitResultButton.layer.cornerRadius = 18
         CameraGalleybutton.layer.cornerRadius = 10
        SubmitWithDisputeButton.layer.cornerRadius = 18
         ImagePicker.delegate = self
         GetSelectRadioButton()
         tournamentsumit_details()
        disputetext.isHidden = true
    }
    
    var count = 0
    @IBAction func SubmitresultSelectButton(_ sender: Any) {
        if count == 0{
            DisputeRadioButton.deselect(animated: true)
            SubmitResultRadioButton.select(animated: true)
            disputetext.isHidden = true
            SubmitResultButton.isHidden = false
            isdispute = "1"
            count = 1
             count1 = 0
            self.DisputeTextField.text = ""
          }
        else{
            SubmitResultRadioButton.deselect(animated: true)
           count = 0
            isdispute = ""
        }
        print("submit count ",count)
    }
    
    var count1 = 0
    @IBAction func DisputeSelctButton(_ sender: Any) {
        if count1 == 0{
            SubmitResultRadioButton.deselect(animated: true)
            DisputeRadioButton.select(animated: true)
            disputetext.isHidden = false
            SubmitResultButton.isHidden = true
            count1 = 1
             count = 0
              isdispute = "0"
          }
        else{
            DisputeRadioButton.deselect(animated: true)
            isdispute = ""
//            disputetext.isHidden = true
//            SubmitResultButton.isHidden = false
            count1 = 0
         }
        print("submit count ",count1)
    }
    
   var count3 = 0
    @IBAction func selectWonRadioButton(_ sender: Any) {
        if count3 == 0{
            LostRadioButton.deselect(animated: true)
            WonRadioButton.select(animated: true)
            status = "1"
            count3 = 1
       }
        else{
            
            WonRadioButton.deselect(animated: true)//select
            status = ""
            count3 = 0
        }
    }
    
     var count2 = 0
    @IBAction func LostSelectRadioButton(_ sender: Any) {
        if count2 == 0{
            WonRadioButton.deselect(animated: true)
            LostRadioButton.select(animated: true)
            status = "0"
            count2 = 1
        }
        else{
            LostRadioButton.deselect(animated: true)//select
            
            status = ""
            count2 = 0
            
            
        }
    }
    
    @IBAction func BackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    func GetSelectRadioButton() {
        SubmitResultRadioButton.translatesAutoresizingMaskIntoConstraints = false
        DisputeRadioButton.translatesAutoresizingMaskIntoConstraints = false
        WonRadioButton.translatesAutoresizingMaskIntoConstraints = false
        LostRadioButton.translatesAutoresizingMaskIntoConstraints = false
        WonRadioButton.selectedColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        LostRadioButton.selectedColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        SubmitResultRadioButton.selectedColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        DisputeRadioButton.selectedColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    
    @IBAction func ChooseFileAction(_ sender: Any) {
        ForGalleryCamera()
    }
    
    func ForGalleryCamera()  {
        
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
            ImagePicker.sourceType = UIImagePickerControllerSourceType.camera
            ImagePicker.allowsEditing = true
            self.present(ImagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func openGallary()
    {
        ImagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        ImagePicker.allowsEditing = true
        self.present(ImagePicker, animated: true, completion: nil)
    }
    var isImgUploaded = false
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        print("DidFinish Selected................")
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage
        {
            self.Image = image
            isImgUploaded = true
            FilePathLabel.text! = "File Chosen"
            print("img Selected................")
        }
        else
        {
            print("Something went wrong")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func SubmitResultAction(_ sender: Any) {
        if isImgUploaded == true
        {
            if self.isdispute  != ""{
            if self.status != ""{
                SubMitResultWithImage()
            }else{
                Global.showAlertMessageWithOkButtonAndTitle("", andMessage: "Please select You are Won OR Loss?")
            }
            }else{
               Global.showAlertMessageWithOkButtonAndTitle("", andMessage: "Please select 'Submit Result' OR 'Dispute'")
            }
        }
        else
        {
            Global.showAlertMessageWithOkButtonAndTitle("", andMessage: "Please upload your score image")
        }
      
    }
    
    
    @IBAction func SubmitResultWithDispute(_ sender: Any) {
        if isImgUploaded == true
        {
            if self.DisputeTextField.text! != "" {
                if self.status != ""{
                 SubMitResultWithImage()
                }else{
                  Global.showAlertMessageWithOkButtonAndTitle("", andMessage: "Please select You are Won OR Loss?")
                }
                
                
            }else{
              Global.showAlertMessageWithOkButtonAndTitle("", andMessage: "Dispute field can not be blank")
            }
           
        }
        else
        {
            Global.showAlertMessageWithOkButtonAndTitle("", andMessage: "Please upload your score image")
        }
        //SubMitResultWithImage()
    }
    
    
    
    func tournamentsumit_details()
    {
        var dictPost:[String: AnyObject]!
        dictPost = ["tournament_id":self.tournament_id as AnyObject,"user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject]
        print("tournamentsumit_details Dictionary:",dictPost)

        WebHelper.requestPostUrl(strURL: GlobalConstant.tournamentsumit_details, Dictionary: dictPost, Success:{
            success in
            let status = success.object(forKey: "status") as! String
            print("tournamentsumit_details  success:",success)
            /// Result fail
            if status == "0"
            {
            }
                /// Result success
            else if status == "1"
            {
                     let dict = success.object(forKey: "SubmitDetails") as! NSDictionary
                     self.team_id = dict.value(forKey: "TeamID") as! String
                self.TeamNameTextField.text! = dict.value(forKey: "TeamName") as! String
                self.YourGameIdTextField.text! = dict.value(forKey: "TeamID") as! String
                if dict.value(forKey: "RoundId") != nil
                {
                    self.RoundTextView.text! = dict.value(forKey: "RoundId") as! String
                }
                // self.RoundTextView.text! = ""
                
            }  /// Result nil
            else
            {
                Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage: "Internal Server Error")
            }
        }, Failure: {
            failure in
            Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage: failure.localizedDescription)

        })
    }
    
    
    /*
     user_id,tournament_id,team_id,status,isdispute,disputetext,rid,ScoreImage
     isdispute - 0 - Dsipiute , 1- Submit result?status - 0 -Loss, 1- Won??
     */
    func SubMitResultWithImage()
    {
        var DicInput = [String:AnyObject]()
        DicInput = ["status":self.status as AnyObject,"team_id":self.team_id as AnyObject,"tournament_id":self.tournament_id as AnyObject,"user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject,"disputetext": self.DisputeTextField.text! as AnyObject,"isdispute":isdispute as AnyObject,"rid":self.RoundTextView.text! as AnyObject]
        print("tournamentsumit_details Dictionary:",DicInput)
        
        WebHelper.requestPostUrlWithImage(strURL: GlobalConstant.tournamentsubmitresult, Dictionary: DicInput, AndImage: self.Image ?? #imageLiteral(resourceName: "challenge-listing-img"), forImageParameterName: "ScoreImage", Success: {success in
            let status = success.object(forKey: "status") as! String
            if status == "1"{
                Global.showAlertMessageWithOkButtonAndTitle("", andMessage: success.value(forKey: "msg") as! String)
                self.navigationController?.popViewController(animated: true)
            }
        }, Failure: {failler in
            //Global.showAlertMessageWithOkButtonAndTitle("", andMessage: failler.localizedDescription)
        })
        
    }
    
    
    
    
}
