//
//  PersonalProfileViewController.swift
//  IGL
//
//  Created by baps on 30/09/18.
//  Copyright © 2018 Mac Min. All rights reserved.
//

import UIKit

class PersonalProfileViewController: UIViewController,SWRevealViewControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    @IBOutlet weak var ProfileImageView: UIImageView!
    @IBOutlet weak var LikeView: UIView!
    @IBOutlet weak var CrateTeanButton: UIButton!
    @IBOutlet weak var Menubutton: UIBarButtonItem!
    @IBOutlet weak var UsernameLabel:UILabel!
    @IBOutlet weak var profileCoverImage:UIImageView!
    @IBOutlet weak var Creditlabel:UILabel!
    @IBOutlet weak var PerosonalUsernamelabel:UILabel!
    @IBOutlet weak var GenderNameLabel:UILabel!
    @IBOutlet weak var Emaillabel:UILabel!
    @IBOutlet weak var MobileNumberlabel:UILabel!
    @IBOutlet weak var BioOfUserlabel:UILabel!
    @IBOutlet weak var PsIdlabel:UILabel!
    @IBOutlet weak var NintendoLabel:UILabel!
    @IBOutlet weak var SteamLabel:UILabel!
    @IBOutlet weak var xboxLabel:UILabel!
    @IBOutlet weak var changeCoverImgButton: UIButton!
    @IBOutlet weak var changeProfileImgButton: UIButton!
     @IBOutlet weak var Nameeditbtn: UIButton!
     @IBOutlet weak var Gendereditbtn: UIButton!
     @IBOutlet weak var gmaileditbtn: UIButton!
     @IBOutlet weak var mobilenumbereditbtn: UIButton!
     @IBOutlet weak var bioeditbtn: UIButton!
     @IBOutlet weak var ps4editbtn: UIButton!
     @IBOutlet weak var nintendoeditbtn: UIButton!
     @IBOutlet weak var xboxeditbtn: UIButton!
     @IBOutlet weak var steameditbtn: UIButton!
    var ImagePicker = UIImagePickerController()
    var user_id = ""
    var isLoggedInUser = true
    var otherUserId = ""
    var profile_id = ""
    var COmingFromLandingScreen = false
  override func viewDidLoad() {
        super.viewDidLoad()
        ImagePicker.delegate = self
        Global.roundRadius(ProfileImageView)
        ProfileImageView.layer.borderWidth = 2
        ProfileImageView.layer.borderColor = #colorLiteral(red: 0.1098039216, green: 0.5725490196, blue: 0.9137254902, alpha: 1)
      //  LikeView.layer.cornerRadius = 13
        profileCoverImage.clipsToBounds = true
        CrateTeanButton.layer.cornerRadius = 15
        if COmingFromLandingScreen == true{
        user_id = Global.getStringValue(UserDefaults.standard.value(forKey: "user_id") as AnyObject)
        }
        else
        {
            CrateTeanButton.isHidden = true
            changeCoverImgButton.isHidden = true
            changeProfileImgButton.isHidden = true
            user_id = otherUserId
            Nameeditbtn.isHidden = true
            Gendereditbtn.isHidden = true
            gmaileditbtn.isHidden = true
            mobilenumbereditbtn.isHidden = true
            bioeditbtn.isHidden = true
            ps4editbtn.isHidden = true
            nintendoeditbtn.isHidden = true
            xboxeditbtn.isHidden = true
            steameditbtn.isHidden = true
            print("is coming from the notification center????",otherUserId)
        }
      
         Get_personalInfo()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        OpenSideMenu()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func BackAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func GoToAddTeamAction(_ sender: UIButton) {
        let StoryBoardObj = UIStoryboard(name: "Main", bundle: nil)
        let AddTeamObj = StoryBoardObj.instantiateViewController(withIdentifier: "ProfileCreateTeamVC") as! ProfileCreateTeamVC
       self.navigationController?.pushViewController(AddTeamObj, animated: true)
    }
    func OpenSideMenu()  {
//        //Actions for the SideMenu.
//        Menubutton.target = revealViewController()
//        Menubutton.action = #selector(SWRevealViewController.revealToggle(_:))
//        //set the delegate to the SWRevealviewcontroller
//       // revealViewController().delegate = self
//        //self.revealViewController().rearViewRevealWidth = 240
//        if self.revealViewController() != nil {
//            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
//            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
//        }
    }
    //for dissable homescreen
    public func revealController(_ revealController: SWRevealViewController!, willMoveTo position: FrontViewPosition) {
        
        let tagId = 112151
        if revealController.frontViewPosition == FrontViewPosition.right {
            
            let lock = self.view.viewWithTag(tagId)
            
            UIView.animate(withDuration: 0.25, animations: {
                
                lock?.alpha = 0
                
            }, completion: {(finished: Bool) in
                
                lock?.removeFromSuperview()
            })
            lock?.removeFromSuperview()
        } else if revealController.frontViewPosition == FrontViewPosition.left {
            
            let lock = UIView(frame: self.view.bounds)
            
            lock.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            lock.tag = tagId
            
            lock.alpha = 0
            
            lock.backgroundColor = UIColor.black
            
            lock.addGestureRecognizer(UITapGestureRecognizer(target: self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:))))
            
            self.view.addSubview(lock)
            
            UIView.animate(withDuration: 0.75, animations: {
                
                lock.alpha = 0.333})
        }
        
    }
    @IBAction func NotiAction(_ sender:Any)
    {
        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
        let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(SwreavelObj, animated: true)
 
    
    
    }
    
    var fromBanner = ""
    @IBAction func ChangeBannermage(_ sender: Any) {
        fromBanner = "Banner"
        self.ForGalleryCamera()
    }
    
    
    @IBAction func ChangeProfileAction(_ sender: Any) {
         self.ForGalleryCamera()
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
        
        /*If you want work actionsheet on ipad
         then you have to use popoverPresentationController to present the actionsheet,
         otherwise app will crash on iPad */
//        switch UIDevice.current.userInterfaceIdiom {
//        case .pad:
//            alert.popoverPresentationController?.sourceView = sender as! UIView
//            alert.popoverPresentationController?.sourceRect = (sender as AnyObject).bounds
//            alert.popoverPresentationController?.permittedArrowDirections = .up
//        default:
//            break
//        }
        
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
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage
        {
            if fromBanner == "Banner"{
                self.profileCoverImage.image = image
                fromBanner = ""
                var DicInput = [String:AnyObject]()
                DicInput = ["user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject]
                print("input data from the app is to the server is ",DicInput)
                WebHelper.requestPostUrlWithImage(strURL:GlobalConstant.update_coverpic, Dictionary: DicInput, AndImage: self.ProfileImageView.image!, forImageParameterName: "UserCoverImage", Success: {success in
                    let status = String(describing: success.value(forKey: "status")!)
                    if status == "1"
                    {
                        
                    }
                    else if status == "0"{
                        
                    }
                }, Failure: {failler in
                    Global.showAlertMessageWithOkButtonAndTitle("", andMessage: failler.localizedDescription)
                })
                
            }
            else{
                self.ProfileImageView.image = image
                var DicInput = [String:AnyObject]()
                DicInput = ["user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject]
                print("input data from the app is to the server is ",DicInput)
                WebHelper.requestPostUrlWithImage(strURL: GlobalConstant.update_profilepic, Dictionary: DicInput, AndImage: self.ProfileImageView.image!, forImageParameterName: "UserProfileImage", Success: {success in
                    let status =  String(describing: success.value(forKey: "status")!)
                    if status == "1"{
                        Global.showAlertMessageWithOkButtonAndTitle("", andMessage: success.value(forKey: "msg") as! String)
                    }
                }, Failure: {failler in
                    Global.showAlertMessageWithOkButtonAndTitle("", andMessage: failler.localizedDescription)
                })
            }
        }
        else
        {
            print("Something went wrong")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func Get_personalInfo(){
        var dictPost:[String: AnyObject]!
        dictPost = ["user_id":user_id as AnyObject,"profile_id":"" as AnyObject]
        print("input data is......",dictPost)
        WebHelper.requestPostUrl(strURL:GlobalConstant.get_personlinfo, Dictionary: dictPost, Success: {
            success in
            print("sucess from the server is",success)
            
            if Global.getStringValue(success.value(forKey: "status") as AnyObject) == "1"
            {
                let UserPersonalInfo = success["UserPersonalInfo"] as! NSDictionary
                let firstname = UserPersonalInfo["firstname"] as! String
                let lastname = UserPersonalInfo["lastname"] as! String
                self.UsernameLabel.text =  UserPersonalInfo["username"] as! String
                self.Emaillabel.text = UserPersonalInfo["email"] as! String
                self.PerosonalUsernamelabel.text = UserPersonalInfo["username"] as! String
                self.MobileNumberlabel.text = UserPersonalInfo["mobile"] as! String
                let url1 = URL(string:UserPersonalInfo["UserCoverImage"] as! String)
                self.profileCoverImage?.kf.setImage(with: url1,
                                                    placeholder:UIImage(named: "placeholder"),
                                                    options: [.transition(.fade(1))],
                                                    progressBlock: nil,
                                                    completionHandler: nil)
                let url2 = URL(string:UserPersonalInfo["UserProfileImage"] as! String)
                self.ProfileImageView?.kf.setImage(with: url2,
                                                   placeholder:UIImage(named: "placeholder"),
                                                   options: [.transition(.fade(1))],
                                                   progressBlock: nil,
                                                   completionHandler: nil)
                self.BioOfUserlabel.text =  UserPersonalInfo["UserBio"] as! String
                let credit =   UserPersonalInfo["UserCredit"] as! String
                self.Creditlabel.text = "CURRENT BALANCE:₹\(10*Int(credit)!) (\(credit) IGL COINS)"
                //0 for male , 1 for female
                if UserPersonalInfo["UserGender"] as! String == "0"{
                    self.GenderNameLabel.text = "Male"
                }
                else if UserPersonalInfo["UserGender"] as! String == "1"{
                    self.GenderNameLabel.text = "Female"
                }
                else if UserPersonalInfo["UserGender"] as! String == "1"{
                    self.GenderNameLabel.text = "Custom"
                }
                //for Gaming plateform
                self.PsIdlabel.text = UserPersonalInfo["UserPSID"] as! String
                self.NintendoLabel.text = UserPersonalInfo["UserNintendoID"] as! String
                self.SteamLabel.text = UserPersonalInfo["UserSteamID"] as! String
                self.xboxLabel.text = UserPersonalInfo["UserXboxID"] as! String
                
            }
            else
            {
                
            }
            
           
            
        }, Failure: {failler in
            
        })
    }
    
    @IBAction func EditUserName(_ sender: UIButton) {
       if  COmingFromLandingScreen == true{
           ToUpadetprofileInfo()
        }else{
            
        }
    }
    
 @IBAction func EditGender(_ sender: Any) {
        if COmingFromLandingScreen == true{
             ToUpadetprofileInfo()
        }
    }
    
    @IBAction func EditEmail(_ sender: Any) {
        if COmingFromLandingScreen == true{
            ToUpadetprofileInfo()
        }
    }
    
    @IBAction func EditMobileNumber(_ sender: Any) {
        if COmingFromLandingScreen == true{
            ToUpadetprofileInfo()
        }
    }
    
    @IBAction func EditBio(_ sender: Any) {
        if COmingFromLandingScreen == true{
            //Coming_from_Bio
            let VcObj = storyboard?.instantiateViewController(withIdentifier: "SettingUpdateViewController") as! SettingUpdateViewController
            VcObj.iscoming_From_PRofile = true
            VcObj.Coming_from_Bio = true
            self.navigationController?.pushViewController(VcObj, animated: true)
           // ToUpadetprofileInfo()
        }
    }
    
    
    @IBAction func PsEditAction(_ sender: Any) {
        if COmingFromLandingScreen == true{
            ToUpadetprofileInfo()
        }
    }
    
    
    @IBAction func NintendoAction(_ sender: UIButton) {
        if COmingFromLandingScreen == true{
            ToUpadetprofileInfo()
        }
    }
    
    @IBAction func XboxAction(_ sender: Any) {
        if COmingFromLandingScreen == true{
            ToUpadetprofileInfo()
        }
   }
    
    @IBAction func SteamAction(_ sender: Any) {
        if COmingFromLandingScreen == true{
            ToUpadetprofileInfo()
        }
   }
    
    
    
    func ToUpadetprofileInfo(){
        let VcObj = storyboard?.instantiateViewController(withIdentifier: "SettingUpdateViewController") as! SettingUpdateViewController
        VcObj.iscoming_From_PRofile = true
        self.navigationController?.pushViewController(VcObj, animated: true)
    }
}


