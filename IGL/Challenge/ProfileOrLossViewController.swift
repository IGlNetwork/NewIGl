//
//  ProfileOrLossViewController.swift
//  IGL
//
//  Created by baps on 05/11/18.
//  Copyright © 2018 Mac Min. All rights reserved.
// type: (0,1) (0-dispute, 1-result)
//user_id : logged in user id
//result : (1- win, 2- lost, 3- dispute)
//disputetext: Text in case of dispute
//ResultImage: in case of dispute


import UIKit
import LTHRadioButton
class ProfileOrLossViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var LOstButton: UIButton!
    @IBOutlet weak var WonButton: UIButton!
    @IBOutlet weak var SubMitresultButton: UIButton!
    @IBOutlet weak var chooseButton: UIButton!
    @IBOutlet weak var TeamNameVIew: UIView!
    @IBOutlet weak var OpponentTeamnameView: UIView!
    @IBOutlet weak var UploadImageView: UIView!
    @IBOutlet weak var YourTeamName: UITextField!
    @IBOutlet weak var OpponentTeamName: UITextField!
    @IBOutlet weak var FilePathLabel: UITextField!
    @IBOutlet weak var toplayofYourTeam: NSLayoutConstraint!
    
    @IBOutlet weak var ResultSubmitView: UIView!
    @IBOutlet weak var DisputeRadioButton: LTHRadioButton!
    @IBOutlet weak var SubmitresultButton: LTHRadioButton!
    
    @IBOutlet weak var WonRadioButton: LTHRadioButton!
    @IBOutlet weak var LostRadioButton: LTHRadioButton!
    @IBOutlet weak var toplayouofyouhavelabel: NSLayoutConstraint!
    
    @IBOutlet weak var OpponentNameLabel: UILabel!
    @IBOutlet weak var teamNmaeLabel: UILabel!
    @IBOutlet weak var DisputeView: UIView!
    @IBOutlet weak var DisputeTextView: UITextView!
    @IBOutlet weak var DissPuteSubmitButton: UIButton!
    var Iscoming_From_Recive = false
    var challenge_id = ""
    var type = ""//0-dispute,1-result
    var result = ""//(1- win, 2- lost, 3- dispute)
    var ResultWithDispute = "" //in case of Dispute
    var ImagePicker = UIImagePickerController()
    var yourTeamName = ""
    var opponentTeamName = ""
    var Image:UIImage?
    var isimage = false
    override func viewDidLoad() {
        super.viewDidLoad()
     
          GetSelectRadioButton()
        if Iscoming_From_Recive == true{
            ResultSubmitView.isHidden = true
            toplayofYourTeam.constant = -40
            OpponentTeamnameView.isHidden = true
            TeamNameVIew.isHidden = true
            teamNmaeLabel.isHidden = true
            OpponentNameLabel.isHidden = true
            toplayouofyouhavelabel.constant = -150
            DisputeView.isHidden = false
             SubMitresultButton.isHidden = true
            result = ""
        }else{
            DisputeView.isHidden = true
        }
        
        //  LOstButton.layer.borderWidth = 4
        //  LOstButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        //Global.buttonCornerRadius(LOstButton)
        // Global.buttonCornerRadius(WonButton)
        TeamNameVIew.layer.cornerRadius = 15
        OpponentTeamnameView.layer.cornerRadius = 15
        UploadImageView.layer.cornerRadius = 15
        chooseButton.layer.cornerRadius = 10
        SubMitresultButton.layer.cornerRadius = 15
        DisputeTextView.layer.cornerRadius = 18
        DissPuteSubmitButton.layer.cornerRadius = 15
        ImagePicker.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        YourTeamName.text = self.yourTeamName
        OpponentTeamName.text = self.opponentTeamName
        
    }    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func BackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func NotiAction(_ sender:Any)
    {
        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
        let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(SwreavelObj, animated: true)
    }
    
    // type: (0,1) (0-dispute, 1-result)
    // result : (1- win, 2- lost, 3- dispute)
    
    
    
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
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        print("DidFinish Selected................")
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage
        {
            self.Image = image
            isimage = true
            FilePathLabel.text = "File Chosen"
            print("img Selected................")
        }
        else
        {
            print("Something went wrong")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func GetSelectRadioButton() {
        SubmitresultButton.translatesAutoresizingMaskIntoConstraints = false
        DisputeRadioButton.translatesAutoresizingMaskIntoConstraints = false
        WonRadioButton.translatesAutoresizingMaskIntoConstraints = false
        LostRadioButton.translatesAutoresizingMaskIntoConstraints = false
        
        if  Iscoming_From_Recive == true{
         WonRadioButton.select(animated: true)
        }
        
        WonRadioButton.selectedColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        LostRadioButton.selectedColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        SubmitresultButton.selectedColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        DisputeRadioButton.selectedColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        
    }
    
    
    var count = 0
    @IBAction func DisputeSelectAction(_ sender: Any) {
        if count == 0{
            SubmitresultButton.deselect(animated: true)
            DisputeRadioButton.select(animated: true)
            count = 1
            count1 = 0
            type = "0"
            ResultWithDispute = "3"
            DisputeView.isHidden = false
            SubMitresultButton.isHidden = true
        }
        else{
            DisputeRadioButton.deselect(animated: true)
            DisputeView.isHidden = true
            SubMitresultButton.isHidden = false
            count = 0
            ResultWithDispute = ""
            type = ""
        }
        
        print("count---",count)
    }
    
    var count1 = 0
    @IBAction func SubmitResultSelectAction(_ sender: Any) {
        if count1 == 0{
            DisputeRadioButton.deselect(animated: true)//
            SubmitresultButton.select(animated: true)
            count1 = 1
            count = 0
            type = "1"
            ResultWithDispute = ""
            DisputeView.isHidden = true
            SubMitresultButton.isHidden = false
            
        }
        else{
            
            SubmitresultButton.deselect(animated: true)
            count1 = 0
            type = ""
        }
        print("count1-=-=-=-=-=",count1)
    }
    var count2 = 0
    @IBAction func LostAction(_ sender: Any) {
        if count2 == 0{
            WonRadioButton.deselect(animated: true)
            LostRadioButton.select(animated: true)
            count2 = 1
            result = "2"
            
        }
        else{
            
            LostRadioButton.deselect(animated: true)//select
            count2 = 0
            result = ""
            
        }
    }
    
    
    var count3 = 0
    @IBAction func WonAction(_ sender: Any) {
        if count3 == 0{
            LostRadioButton.deselect(animated: true)
            WonRadioButton.select(animated: true)
            count3 = 1
            result = "1"
            
        }
        else{
            
            WonRadioButton.deselect(animated: true)//select
            count3 = 0
            result = ""
            
        }
    }
    
    @IBAction func SibmitWithDisputeAction(_ sender: Any) {
        if Iscoming_From_Recive{
            if DisputeTextView.text == "" || DisputeTextView.text == nil{
                Global.showAlertMessageWithOkButtonAndTitle("", andMessage: "Dispute field cantnot blank")
            }
            else if isimage == false{
                Global.showAlertMessageWithOkButtonAndTitle("", andMessage: "Select Image of Your Game")
            }else{
                var DicInput = [String:AnyObject]()
                DicInput = ["challenge_id":self.challenge_id as AnyObject,"type":self.type as AnyObject,"user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject,"disputetext":self.DisputeTextView.text! as AnyObject,"result":"1" as AnyObject]
                print("Input of the data is taht which is coming form teh My App is-=-=-=-=----------------",DicInput)
                WebHelper.requestPostUrlWithImage(strURL: GlobalConstant.submit_challenge_result, Dictionary: DicInput, AndImage: self.Image!, forImageParameterName: "ResultImage", Success: {success in
                    let status = success.object(forKey: "status") as! String
                    if status == "1"{
                        
                        self.DissmisPopUpwithMessage(Message:success.value(forKey: "msg") as! String)
                       //  Global.showAlertMessageWithOkButtonAndTitle("", andMessage: success.value(forKey: "msg") as! String)
                    }
                }, Failure: {failler in
                    Global.showAlertMessageWithOkButtonAndTitle("", andMessage: failler.localizedDescription)
                })
            }
        }else{
            if self.ResultWithDispute == "" {
                Global.showAlertMessageWithOkButtonAndTitle("", andMessage: "Select Dispute")
                
            }
            else if DisputeTextView.text == "" || DisputeTextView.text == nil{
                Global.showAlertMessageWithOkButtonAndTitle("", andMessage: "Dispute field cantnot blank")
            }
            else if isimage == false{
                Global.showAlertMessageWithOkButtonAndTitle("", andMessage: "Select Image of Your Game")
            }else{
                SubMitResultWithImage(Result: self.ResultWithDispute)
            }
        }
        
    }
    
    @IBAction func SubmitResultAction(_ sender: Any) {
        if self.type == "" {
            Global.showAlertMessageWithOkButtonAndTitle("", andMessage: "Select Dispute/Submit result")
        }else if self.result == ""{
            Global.showAlertMessageWithOkButtonAndTitle("", andMessage: "Select Won/Loss")
        }
        else if self.Image == nil{
            Global.showAlertMessageWithOkButtonAndTitle("", andMessage: "Select Image of Your Game")
        }
        else{
            SubMitResultWithImage(Result: self.result)
        }
        
    }
    
    func SubMitResultWithImage(Result:String) {
        var DicInput = [String:AnyObject]()
        DicInput = ["challenge_id":self.challenge_id as AnyObject,"type":self.type as AnyObject,"user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject,"disputetext":self.DisputeTextView.text! as AnyObject,"result":Result as AnyObject]
        print("Input of the data is taht which is coming form teh My App is-=-=-=-=----------------",DicInput)
        WebHelper.requestPostUrlWithImage(strURL: GlobalConstant.submit_challenge_result, Dictionary: DicInput, AndImage: self.Image!, forImageParameterName: "ResultImage", Success: {success in
            let status = success.object(forKey: "status") as! String
            if status == "1"{
                
                self.DissmisPopUpwithMessage(Message:success.value(forKey: "msg") as! String)
                // Global.showAlertMessageWithOkButtonAndTitle("", andMessage: success.value(forKey: "msg") as! String)
            }
        }, Failure: {failler in
            Global.showAlertMessageWithOkButtonAndTitle("", andMessage: failler.localizedDescription)
        })
        
    }
    
    func DissmisPopUpwithMessage(Message:String)  {
        let AlertObj = UIAlertController(title: "", message: Message, preferredStyle: UIAlertControllerStyle.alert)
        let okk = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel,handler: {
            (Alert:UIAlertAction) in
            // WinnerViewController  ChallengeRMadeViewController
           let StoryObj = UIStoryboard(name: "Main", bundle: nil)
           let vcobj = StoryObj.instantiateViewController(withIdentifier: "ChallengeRMadeViewController") as! ChallengeRMadeViewController
            vcobj.iscoming_fromResult = true
           // vcobj.challenge_id = self.challenge_id
            self.navigationController?.pushViewController(vcobj, animated: true)
           // self.navigationController?.popViewController(animated:true)
        })
        AlertObj.addAction(okk)
        self.present(AlertObj, animated: true, completion: nil)
    }
}
