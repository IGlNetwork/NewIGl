//
//  ProfileCreateTeamVC.swift
//  IGL
//
//  Created by Mac Min on 30/09/18.
//  Copyright © 2018 Mac Min. All rights reserved.
//

class TeammeberTableViewCell: UITableViewCell {
    @IBOutlet weak var TeamMemberNAmeLAbel:UILabel!
}




import UIKit
import Photos
class ProfileCreateTeamVC: UIViewController,UIPopoverPresentationControllerDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var CoverImage: UIImageView!
    @IBOutlet weak var ProfileImage: UIImageView!
    
    
    @IBOutlet weak var UserLabel:UILabel!
    @IBOutlet weak var UserCreditLabel:UILabel!
    @IBOutlet weak var Backgroundview: UIView!
    @IBOutlet weak var teammembersView: UIView!
    @IBOutlet weak var teammemberListTableView: UITableView!
    @IBOutlet weak var  CurrentBalanceLabel: UILabel!
    @IBOutlet weak var  LikesView: UIView!
    @IBOutlet weak var  LikesLabel: UILabel!
    @IBOutlet weak var  CreateYourTeamLabel: UILabel!
    
    @IBOutlet weak var TeamNameTextField: UITextField!
    @IBOutlet weak var TeamGameId: UITextField!
    
    @IBOutlet weak var GamingPlateformTextField: UITextField!
    @IBOutlet weak var TeamWebsiteTextField: UITextField!
    @IBOutlet weak var CreateATeam: UIButton!
    @IBOutlet weak var TeamMembers1: UITextField!
    @IBOutlet weak var SelectRole1: UITextField!
    @IBOutlet weak var TeamMembers2: UITextField!
    @IBOutlet weak var SelectRole2: UITextField!
    @IBOutlet weak var TeamMembers3: UITextField!
    @IBOutlet weak var SelectRole3: UITextField!
    @IBOutlet weak var TeamMembers4: UITextField!
    @IBOutlet weak var SelectRole4: UITextField!
    @IBOutlet weak var TeamMembers5: UITextField!
    @IBOutlet weak var SelectRole5: UITextField!
    @IBOutlet weak var TeamMembers6: UITextField!
    @IBOutlet weak var SelectRole6: UITextField!
    
    @IBOutlet weak var TeamSizetextField: UITextField!
    @IBOutlet weak var SelectGameIdtextField: UITextField!
    
    @IBOutlet weak var GameIDTextField: UITextField!
    @IBOutlet weak var TeamNameView: UIView!
    @IBOutlet weak var YourRoleView: UIView!
    @IBOutlet weak var TeamWebsiteView: UIView!
    @IBOutlet weak var GamingPlateform: UIView!
    @IBOutlet weak var ChoseImageView: UIView!
    @IBOutlet weak var ChooseImageButton: UIButton!
    
    @IBOutlet weak var TeamMemberView1: UIView!
    @IBOutlet weak var TeamMemberView2: UIView!
    @IBOutlet weak var TeamMemberView3: UIView!
    @IBOutlet weak var TeamMemberView4: UIView!
    @IBOutlet weak var TeamMemberView5: UIView!
    @IBOutlet weak var TeamMemberView6: UIView!
    
    @IBOutlet weak var SelectRoleView1: UIView!
    @IBOutlet weak var SelectRoleView2: UIView!
    @IBOutlet weak var SelectRoleView3: UIView!
    @IBOutlet weak var SelectRoleView4: UIView!
    @IBOutlet weak var SelectRoleView5: UIView!
    @IBOutlet weak var SelectRoleView6: UIView!
    @IBOutlet weak var TeamSizeView: UIView!
    @IBOutlet weak var GameIdView: UIView!
    @IBOutlet weak var Create_A_Team: UIButton!
    @IBOutlet weak var SelectGameView: UIView!
    @IBOutlet weak var plateformdropdownbutton: UIButton!
    @IBOutlet weak var GameDropDown: UIButton!
    @IBOutlet var SelctTeamSizeView: UIView!
    @IBOutlet var TeamSizeTableView: UITableView!//SelctTeamSizeView
    @IBOutlet weak var CreateButtonTopConstrain: NSLayoutConstraint!
    //Drop down Button
    @IBOutlet weak var ropDownButton: UIButton!
    @IBOutlet weak var DropDownButton2: UIButton!
    @IBOutlet weak var DropDownButton3: UIButton!
    @IBOutlet weak var DropDownButton4: UIButton!
    @IBOutlet weak var DropDownButton5: UIButton!
    @IBOutlet weak var DropDownButton6: UIButton!
    @IBOutlet var coverImgButton: UIImageView!
    @IBOutlet var profileImgButton: UIImageView!
    
    @IBOutlet weak var imgFileChoosenLabel: UITextField!
    
    
    @IBOutlet weak var selectPltfrmButton: UIButton!
    @IBOutlet weak var selectGameButton: UIButton!
    @IBOutlet weak var selectTeamSize: UIButton!
    // GameIDTextField for Game Id
    
    
    
    var ScreenWidth = UIScreen.main.bounds.width
    static var PlateformArray:NSArray = []
    static var arrTeamSize = [String]()
    static var game_id = ""
    var TeamPlateForm_Id = ""
    var NoOfPlayer = ""
    static var isOpenTeamSizePopUp = false
    var ImagePicker = UIImagePickerController()
    var image_var:UIImage?
    
    var gameObj:NSDictionary?
    
    var isComingFromTournamentDeatils = false
    
    var prePopulateArr = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.When_viewDidLoads()
         DecorateView()
        ImagePicker.delegate = self
        TeamMembers1.delegate = self
        setHeader()
        ProfileCreateTeamVC.GetPlateformList()
        tohidetheviews()
        getAllUsersList()
        AddFunction()
        
        prePopulateData()
        
        
    }
    
    
    /*
     GameBannerImage = "http://iglnetwork.com/beta/assets/uploads/games/1564747347game_banner_fortnite.jpg";
     GameID = 13;
     GameImagePath = "http://iglnetwork.com/beta/assets/uploads/games/1564747347game_image_thumb_fortnite.jpg";
     GamePlayers = 4;
     GamePlayersType = 2;
     GameTitle = Fortnite;
     PlatformID = 1;
     PlatformName = PC;
     UserGameGameUID = 252720;
     
     
     TournamentTeamMembers = 5          // 6
     TournamentGame = "DOTA 2";        // 0
     TournamentGameID = 12;            // 1
     TournamentPlatform = PC;          // 3
     TournamentPlatformID = 1;         // 4
     GamePlayersType = 2;               // 5
     UserGameGameUID = testgamer1;     // 2
     
     @IBOutlet weak var selectPltfrmButton: UIButton!
     @IBOutlet weak var selectGameButton: UIButton!
     @IBOutlet weak var selectTeamSize: UIButton!
     // GameIDTextField for Game Id
     */
    
    
    
    func prePopulateData()
    {
        print("isComingFromTournamentDeatils",isComingFromTournamentDeatils)
        if isComingFromTournamentDeatils {
            
            if prePopulateArr.count == 7{
                self.SelectGameIdtextField.text! = prePopulateArr[0]  // Game name title
                ProfileCreateTeamVC.game_id = prePopulateArr[1]   // Game id
                GameIDTextField.text! = prePopulateArr[2]   // Game Unique Id
                self.GamingPlateformTextField.text!  = prePopulateArr[3] // Platform Name
                self.TeamPlateForm_Id = prePopulateArr[4]  // Platform id
                
                let TeamSizetype = prePopulateArr[5]   // GamePlayersType
                let noOfPlayers = prePopulateArr[6]  // GamePlayers
                
                print("TeamSizetype:\(TeamSizetype):::noOfPlayers::\(noOfPlayers)")
                
              //  let numberOfPlayer = Int(noOfPlayers)
               // print("numberOfPlayer:::::::::\(numberOfPlayer)")
               
                // Working.......... Here................
                if TeamSizetype == "1"{
                    TeamSizetextField.text = noOfPlayers
                    ProfileCreateTeamVC.isOpenTeamSizePopUp = false
                   
                }else if TeamSizetype == "2"{
                    TeamSizetextField.text = noOfPlayers
                    ProfileCreateTeamVC.arrTeamSize = ["1",noOfPlayers]
                    ProfileCreateTeamVC.isOpenTeamSizePopUp = true
                }else if TeamSizetype == "3"{
                    TeamSizetextField.text = noOfPlayers
                    ProfileCreateTeamVC.arrTeamSize = ["1","2",noOfPlayers]
                    ProfileCreateTeamVC.isOpenTeamSizePopUp = true
                }
                
                 self.GamingPlateformTextField.isUserInteractionEnabled = false
                 selectPltfrmButton.isUserInteractionEnabled = false
                if GameIDTextField.text! != ""{ // sometimes it comes NULL
                      GameIDTextField.isUserInteractionEnabled = false
                }
               
                HideShowTextViews(noofplayers: noOfPlayers)
                // teamMemberTextFields(indexPath: IndexPath(row: numberOfPlayer!, section: 0))
                 self.SelectGameIdtextField.isUserInteractionEnabled = false
                 selectGameButton.isUserInteractionEnabled = false
                
                 TeamSizetextField.isUserInteractionEnabled = false
                 selectTeamSize.isUserInteractionEnabled = false
                 print("===========================",ProfileCreateTeamVC.arrTeamSize.count)
               
//                for i in 0..<ProfileCreateTeamVC.arrTeamSize.count
//                {
//                    print(":::::::::::::::::::::::::::::::;")
//                    print(TeamSizetextField.text!,"==",ProfileCreateTeamVC.arrTeamSize[i])
//                    if TeamSizetextField.text! == ProfileCreateTeamVC.arrTeamSize[i]{
//                         teamMemberTextFields(indexPath: IndexPath(row: i, section: 0))
//                        break
//                    }
//                }
                
               
            }
           
            
        }
        else{
            self.SelectGameIdtextField.text! = Global.getStringValue(gameObj?.value(forKey: "GameTitle") as AnyObject)
            ProfileCreateTeamVC.game_id = Global.getStringValue(gameObj?.value(forKey: "GameID") as AnyObject)
            GameIDTextField.text! = Global.getStringValue(gameObj?.value(forKey: "UserGameGameUID") as AnyObject)
            self.GamingPlateformTextField.text! = Global.getStringValue(gameObj?.value(forKey: "PlatformName") as AnyObject)
            self.TeamPlateForm_Id = Global.getStringValue(gameObj?.value(forKey: "PlatformID") as AnyObject)
            
            let TeamSizetype = Global.getStringValue(gameObj?.value(forKey: "GamePlayersType") as AnyObject)
            let noOfPlayers = Global.getStringValue(gameObj?.value(forKey: "GamePlayers") as AnyObject)
            
            if TeamSizetype == "1"{
                TeamSizetextField.text = noOfPlayers
                ProfileCreateTeamVC.isOpenTeamSizePopUp = false
            }else if TeamSizetype == "2"{
                ProfileCreateTeamVC.arrTeamSize = ["1",noOfPlayers]
                ProfileCreateTeamVC.isOpenTeamSizePopUp = true
            }else if TeamSizetype == "3"{
                ProfileCreateTeamVC.arrTeamSize = ["1","2",noOfPlayers]
                ProfileCreateTeamVC.isOpenTeamSizePopUp = true
            }
            
            
            // HideShowTextViews(noofplayers: noOfPlayers)
        }
       
    }
    
    
  
    @IBAction func CloseAction(_ sender: Any) {
        Backgroundview.isHidden = true
        SelctTeamSizeView.isHidden = true
    }
    
    
    @IBAction func SelectTeamSize(_ sender: UIButton) {
        if ProfileCreateTeamVC.isOpenTeamSizePopUp == true{
            Backgroundview.isHidden = false
            SelctTeamSizeView.isHidden = false
            print("team's array count",ProfileCreateTeamVC.arrTeamSize.count)
            TeamSizeTableView.reloadData()
        }
       
    }
    
    
    
    @IBAction func SelectGamePlateform(_ sender: Any) {
        let obj = self.storyboard!.instantiateViewController(withIdentifier: "dropdowncon") as! DropDownViewController
        obj.CreateTeamObj = self
        obj.modalPresentationStyle = UIModalPresentationStyle.popover
        obj.preferredContentSize = CGSize(width:ScreenWidth, height: 150)
        obj.popoverPresentationController!.delegate = self
        self.present(obj, animated: true, completion: nil)
        let popover = obj.popoverPresentationController
        popover!.sourceView = plateformdropdownbutton
        popover!.sourceRect =  plateformdropdownbutton.bounds
        popover!.permittedArrowDirections = UIPopoverArrowDirection.up
        view.endEditing(true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == TeamSizeTableView{
            return ProfileCreateTeamVC.arrTeamSize.count
            print("Tea size is ????",ProfileCreateTeamVC.arrTeamSize.count)
        }else{
             return DropDownViewController.userLiatarray.count
        }
      
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = teammemberListTableView.dequeueReusableCell(withIdentifier: "TeammeberTableViewCell", for: indexPath) as! TeammeberTableViewCell
        if tableView == TeamSizeTableView{
          cell.TeamMemberNAmeLAbel!.text = ProfileCreateTeamVC.arrTeamSize[indexPath.row]
        }else{
            let obj = DropDownViewController.userLiatarray[indexPath.row] as! NSDictionary
            cell.TeamMemberNAmeLAbel!.text = obj.value(forKey: "username") as! String
        }
       
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if TeamSizeTableView == tableView{
           teamMemberTextFields(indexPath: indexPath)
        }else{
            if self.NoOfPlayer == "1"{
                let obj = DropDownViewController.userLiatarray[indexPath.row] as! NSDictionary
                if let UserGameGameUID = obj.value(forKey: "UserGameGameUID") as? String{
                  SelectRole1.text = obj.value(forKey: "UserGameGameUID") as! String
                }
               
                TeamMembers1.text = obj.value(forKey: "username") as! String
            }
            else if self.NoOfPlayer == "2"{
                let obj = DropDownViewController.userLiatarray[indexPath.row] as! NSDictionary
                if let UserGameGameUID = obj.value(forKey: "UserGameGameUID") as? String{
                  SelectRole2.text = obj.value(forKey: "UserGameGameUID") as! String
                }
                TeamMembers2.text = obj.value(forKey: "username") as! String
            }
            else if self.NoOfPlayer == "3"{
                let obj = DropDownViewController.userLiatarray[indexPath.row] as! NSDictionary
                if let UserGameGameUID = obj.value(forKey: "UserGameGameUID") as? String{
                SelectRole3.text = obj.value(forKey: "UserGameGameUID") as! String
                }
               TeamMembers3.text = obj.value(forKey: "username") as! String
            }
            else if self.NoOfPlayer == "4"{
                let obj = DropDownViewController.userLiatarray[indexPath.row] as! NSDictionary
                if let UserGameGameUID = obj.value(forKey: "UserGameGameUID") as? String{
                    SelectRole4.text = obj.value(forKey: "UserGameGameUID") as! String
                }
               
                TeamMembers4.text = obj.value(forKey: "username") as! String
            }
            else if self.NoOfPlayer == "6"{
                let obj = DropDownViewController.userLiatarray[indexPath.row] as! NSDictionary
                if let UserGameGameUID = obj.value(forKey: "UserGameGameUID") as? String{
                     SelectRole5.text = obj.value(forKey: "UserGameGameUID") as! String
                }
               TeamMembers5.text = obj.value(forKey: "username") as! String
            }
            else if self.NoOfPlayer == "5"{
                let obj = DropDownViewController.userLiatarray[indexPath.row] as! NSDictionary
                if let UserGameGameUID = obj.value(forKey: "UserGameGameUID") as? String{
                     SelectRole1.text = obj.value(forKey: "UserGameGameUID") as! String
                }
             
                TeamMembers6.text = obj.value(forKey: "username") as! String
            }
            self.Backgroundview.isHidden = true
            self.teammembersView.isHidden = true
        }
       
    }
    @IBAction func SelectGameName(_ sender: Any) {
        tohidetheviews()
        let obj = self.storyboard!.instantiateViewController(withIdentifier: "dropdowncon") as! DropDownViewController
        obj.CreateTeamObj = self
        obj.commingfrom = "Game"
        obj.modalPresentationStyle = UIModalPresentationStyle.popover
        obj.preferredContentSize = CGSize(width:ScreenWidth, height: 150)
        obj.popoverPresentationController!.delegate = self
        self.present(obj, animated: true, completion: nil)
        let popover = obj.popoverPresentationController
        popover!.sourceView = GameDropDown
        popover!.sourceRect = GameDropDown.bounds
        popover!.permittedArrowDirections = UIPopoverArrowDirection.up
        view.endEditing(true)
    }
    
    func teamMemberTextFields(indexPath:IndexPath)
    {
        self.TeamSizetextField.text = ProfileCreateTeamVC.arrTeamSize[indexPath.row]
        Backgroundview.isHidden = true
        SelctTeamSizeView.isHidden = true
        let noofplayers = ProfileCreateTeamVC.arrTeamSize[indexPath.row]
        if noofplayers == "1"{
            TeamMemberView1.isHidden = true
            SelectRoleView1.isHidden = true
            TeamMemberView2.isHidden = true
            SelectRoleView2.isHidden = true
            TeamMemberView3.isHidden = true
            SelectRoleView3.isHidden = true
            TeamMemberView4.isHidden = true
            SelectRoleView4.isHidden = true
            TeamMemberView5.isHidden = true
            SelectRoleView5.isHidden = true
            CreateButtonTopConstrain.constant = 20
            
        }
        else if noofplayers == "2"{
            TeamMemberView1.isHidden = false
            SelectRoleView1.isHidden = false
            TeamMemberView2.isHidden = true
            SelectRoleView2.isHidden = true
            TeamMemberView3.isHidden = true
            SelectRoleView3.isHidden = true
            TeamMemberView4.isHidden = true
            SelectRoleView4.isHidden = true
            TeamMemberView5.isHidden = true
            SelectRoleView5.isHidden = true
            CreateButtonTopConstrain.constant = 120-35
        }
        else if noofplayers == "3"{
            TeamMemberView1.isHidden = false
            SelectRoleView1.isHidden = false
            TeamMemberView2.isHidden = false
            SelectRoleView2.isHidden = false
            TeamMemberView3.isHidden = true
            SelectRoleView3.isHidden = true
            TeamMemberView4.isHidden = true
            SelectRoleView4.isHidden = true
            TeamMemberView5.isHidden = true
            SelectRoleView5.isHidden = true
            CreateButtonTopConstrain.constant = 170-35
        }
        else if noofplayers == "4"{
            TeamMemberView1.isHidden = false
            SelectRoleView1.isHidden = false
            TeamMemberView2.isHidden = false
            SelectRoleView2.isHidden = false
            TeamMemberView3.isHidden = false
            SelectRoleView3.isHidden = false
            TeamMemberView4.isHidden = true
            SelectRoleView4.isHidden = true
            TeamMemberView5.isHidden = true
            SelectRoleView5.isHidden = true
            CreateButtonTopConstrain.constant = 200-35
        }
        else if noofplayers == "5"{
            TeamMemberView1.isHidden = false
            SelectRoleView1.isHidden = false
            TeamMemberView2.isHidden = false
            SelectRoleView2.isHidden = false
            TeamMemberView3.isHidden = false
            SelectRoleView3.isHidden = false
            TeamMemberView4.isHidden = false
            SelectRoleView4.isHidden = false
            TeamMemberView5.isHidden = true
            SelectRoleView5.isHidden = true
            CreateButtonTopConstrain.constant = 250-35
            
        }
        else if noofplayers == "6"{
            TeamMemberView1.isHidden = false
            SelectRoleView1.isHidden = false
            TeamMemberView2.isHidden = false
            SelectRoleView2.isHidden = false
            TeamMemberView3.isHidden = false
            SelectRoleView3.isHidden = false
            TeamMemberView4.isHidden = false
            SelectRoleView4.isHidden = false
            TeamMemberView5.isHidden = false
            SelectRoleView5.isHidden = false
            CreateButtonTopConstrain.constant = 295-35
        }
    }
    
    
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle
    {
        return UIModalPresentationStyle.none
    }
    
    var fromBanner = ""
   
    @objc func coverImage()
    {
        ForGalleryCamera()
        fromBanner = "Banner"
    }
    
    @objc func profileImage()
    {
        ForGalleryCamera()
        fromBanner = "Profile"
    }
    
    
    
    @IBAction func ChooseImageAction(_ sender: Any) {
        ForGalleryCamera()
        fromBanner = "Choose"
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
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage
        {  if fromBanner == "Banner"{
                self.CoverImage.image = image
                var DicInput = [String:AnyObject]()
                DicInput = ["user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject]
                WebHelper.requestPostUrlWithImage(strURL:GlobalConstant.update_coverpic, Dictionary: DicInput, AndImage: self.CoverImage.image!, forImageParameterName: "UserCoverImage", Success: {success in
                    let status = String(describing: success.value(forKey: "status")!)
                    if status == "1"
                    {
                        Global.showAlertMessageWithOkButtonAndTitle("", andMessage: success.value(forKey: "msg") as! String)
                        UserDefaults.standard.set(Global.getStringValue(success.value(forKey: "UserCoverImage") as AnyObject), forKey: "UserCoverImage")
                    }
                    else if status == "0"{
                    }
                }, Failure: {failler in
                    Global.showAlertMessageWithOkButtonAndTitle("", andMessage: failler.localizedDescription)
                })
            }
            else if fromBanner == "Profile"{
                self.ProfileImage.image = image
                var DicInput = [String:AnyObject]()
                DicInput = ["user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject]
                WebHelper.requestPostUrlWithImage(strURL: GlobalConstant.update_profilepic, Dictionary: DicInput, AndImage: self.ProfileImage.image!, forImageParameterName: "UserProfileImage", Success: {success in
                    let status =  String(describing: success.value(forKey: "status")!)
                    if status == "1"{
                        Global.showAlertMessageWithOkButtonAndTitle("", andMessage: success.value(forKey: "msg") as! String)
                        UserDefaults.standard.set(Global.getStringValue(success.value(forKey: "UserProfileImage") as AnyObject), forKey: "UserProfileImage")
                    }
                }, Failure: {failler in
                    Global.showAlertMessageWithOkButtonAndTitle("", andMessage: failler.localizedDescription)
                })
            }
            else
            {
                self.image_var =  image
                self.imgFileChoosenLabel.text! = "File Chosen"
            }
        }
        else
        { print("Something went wrong")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func getFileName(info: [String : Any]) -> String {
        
        if let imageURL = info[UIImagePickerControllerReferenceURL] as? URL {
            let result = PHAsset.fetchAssets(withALAssetURLs: [imageURL], options: nil)
            let asset = result.firstObject
            let fileName = asset?.value(forKey:"filename")
            let fileUrl = URL(string: fileName as! String)
            if let name = fileUrl?.deletingPathExtension().lastPathComponent {
                print(name)
                return name
            }
        }
        return ""
        
    }
   
    func setHeader(){
        let urlstring =  UserDefaults.standard.value(forKey: "UserCoverImage") as! String
        let url1 = URL(string:urlstring)
        self.CoverImage?.kf.setImage(with: url1,
                                     placeholder:UIImage(named: "placeholder"),
                                     options: [.transition(.fade(1))],
                                     progressBlock: nil,
                                     completionHandler: nil)
        
        let ProfileUrl = URL(string:UserDefaults.standard.value(forKey: "UserProfileImage") as! String)
        self.ProfileImage?.kf.setImage(with: ProfileUrl,
                                       placeholder:UIImage(named: "placeholder"),
                                       options: [.transition(.fade(1))],
                                       progressBlock: nil,
                                       completionHandler: nil)
        
        UserLabel.text = UserDefaults.standard.value(forKey: "username") as! String
        let credit = UserDefaults.standard.value(forKey: "UserCredit") as! String
        UserCreditLabel.text = "CURRENT BALANCE:₹\(10*Int(credit)!) (\(credit) IGL COINS)"
        print("credit is ",credit)
    }
    
   
   
    //***** Here is UserCreated methodas  ****//
    func When_viewDidLoads()
    {
        // write code when viewDidLoad loads
        ProfileImage.layer.borderWidth = 5.0
        ProfileImage.layer.masksToBounds = false
        ProfileImage.layer.borderColor = #colorLiteral(red: 0.2588235294, green: 0.5215686275, blue: 0.7529411765, alpha: 1)
        ProfileImage.layer.cornerRadius = ProfileImage.frame.size.height/2
        ProfileImage.clipsToBounds = true
    }
    
    @IBAction func NotiAction(_ sender:Any)
    {
        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
        let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(SwreavelObj, animated: true)
    }
    
    func Validate_text_fields()
    {
            guard TeamNameTextField.text != "" else {
            Global.showAlertMessageWithOkButtonAndTitle("User name is empty", andMessage: "")
            return
        }
    }
    
    @IBAction func BackAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func TogetUserList(_ sender: UITextField) {
       
       
    }
    
    func getAllUsersList(){
        var DicInput = ["usernametext": "" as AnyObject ,"game_id": ProfileCreateTeamVC.game_id as AnyObject,"user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject]
        print("input data is...........",DicInput)//
        WebHelper.requestPostUrl(strURL: GlobalConstant.gameusers, Dictionary: DicInput, Success: {success in
            let status = String(describing: success.value(forKey: "status")!)
            
            if status == "1"
            {
                print("data fromthe serve ris this which is coming right now",success)
                DropDownViewController.userLiatarray = success.object(forKey: "UserGameInfo") as! NSArray
                self.teammemberListTableView.reloadData()
          }
            else if status == "0"{
                
            }
        }, Failure: {failler in
            print("something wrong happend",failler.localizedDescription)
        })
    }
    
    @IBAction func backaction(_ sender: Any) {
        Backgroundview.isHidden = true
        teammembersView.isHidden = true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let touch = touches.first!
        if touch.view == Backgroundview{
            Backgroundview.isHidden = true
            teammembersView.isHidden = true
            SelctTeamSizeView.isHidden = true
            
        }
    }
    
    
    @IBAction func TeamOnebtn(_ sender: Any) {//1
        self.view.endEditing(true)
        self.NoOfPlayer = "1"
        Backgroundview.isHidden = false
        teammembersView.isHidden = false
        getAllUsersList()
    }
    
    
    @IBAction func Teamtwobtn(_ sender: Any) {//2
        self.view.endEditing(true)
          self.NoOfPlayer = "2"
        Backgroundview.isHidden = false
        teammembersView.isHidden = false
        getAllUsersList()
    }
    
    
    @IBAction func TeamThreebtrn(_ sender: Any) {//3
        self.view.endEditing(true)
          self.NoOfPlayer = "3"
        Backgroundview.isHidden = false
        teammembersView.isHidden = false
        getAllUsersList()
    }
    
    @IBAction func TeamFourbtn(_ sender: Any) {
        self.view.endEditing(true)
        self.NoOfPlayer = "4"
        Backgroundview.isHidden = false
        teammembersView.isHidden = false
        getAllUsersList()
    }
    @IBAction func TeamFivebtn(_ sender: Any) {
        self.view.endEditing(true)
          self.NoOfPlayer = "5"
        Backgroundview.isHidden = false
        teammembersView.isHidden = false
        getAllUsersList()
    }
    
    @IBAction func TeamSixbtn(_ sender: Any) {
        self.view.endEditing(true)
        self.NoOfPlayer = "6"
        Backgroundview.isHidden = false
        teammembersView.isHidden = false
        getAllUsersList()
    }
    
    
    @IBAction func TOgetUser2(_ sender: UITextField) {
       

    }
    
    @IBAction func Togetuser3(_ sender: UITextField) {
        self.view.endEditing(true)
        Backgroundview.isHidden = false
        teammembersView.isHidden = false
        getAllUsersList()
    }
    
    @IBAction func GetUserLists5(_ sender: UITextField) {
        self.view.endEditing(true)
        Backgroundview.isHidden = false
        teammembersView.isHidden = false
        getAllUsersList()
    }
    
    @IBAction func GetUserLists4(_ sender: UITextField) {
        self.view.endEditing(true)
        Backgroundview.isHidden = false
        teammembersView.isHidden = false
        getAllUsersList()

    }
    
    //            if canOpenURL(TeamWebsiteTextField.text!)
    //            {
    //            }
    //            else
    //            {
    //            Global.showAlertMessageWithOkButtonAndTitle("", andMessage: "Invalid URL")
    //            }
    
    @IBAction func Cteate_TeamAction(_ sender: UIButton)
    {
                    if TeamNameTextField.text! == "" || TeamNameTextField.text! == nil
                    {
                    Global.showAlertMessageWithOkButtonAndTitle("", andMessage: "Enter team name")
                    }
                    else if TeamNameTextField.text!.count < 5{
                       Global.showAlertMessageWithOkButtonAndTitle("", andMessage: "Team name must be greater than 4 characters")
                    }
                    else if TeamNameTextField.text!.count > 20{
                        Global.showAlertMessageWithOkButtonAndTitle("", andMessage: "Team name must be less than 20 characters")
                    }
                    else if GamingPlateformTextField.text! == "" || GamingPlateformTextField.text! == nil
                    {
                    Global.showAlertMessageWithOkButtonAndTitle("", andMessage: "Select gaming platform")
                    }
                    else if SelectGameIdtextField.text! == "" || SelectGameIdtextField.text! == nil
                    {
                    Global.showAlertMessageWithOkButtonAndTitle("", andMessage: "Select game")
                    }
                    else if TeamSizetextField.text! == "" || TeamSizetextField.text! == nil
                    {
                    Global.showAlertMessageWithOkButtonAndTitle("", andMessage: "Select team size")
                    }
                    else if GameIDTextField.text! == "" || GameIDTextField.text! == nil
                    {
                    Global.showAlertMessageWithOkButtonAndTitle("", andMessage: "Enter the gameid")
                    }
                    else if self.image_var == nil
                    {
                    Global.showAlertMessageWithOkButtonAndTitle("", andMessage: "Select image ")
                    }
                    else{
                    CteateTeam()
                    }
        }
    
    
    @IBAction func TogetuserList6(_ sender: UITextField) {
        self.view.endEditing(true)
        var DicInput = ["usernametext": sender.text! as AnyObject ,"game_id":ProfileCreateTeamVC.game_id as AnyObject]
        print("input data is...........",DicInput)
        WebHelper.requestPostUrl(strURL: GlobalConstant.gameusers, Dictionary: DicInput, Success: {success in
            let status = String(describing: success.value(forKey: "status")!)
            
            if status == "1"
            {
                print("data fromthe serve ris this which is coming right now",success)
                DropDownViewController.userLiatarray = success.object(forKey: "UserGameInfo") as! NSArray
                let obj = self.storyboard!.instantiateViewController(withIdentifier: "dropdowncon") as! DropDownViewController
                obj.CreateTeamObj = self
                obj.commingfrom = "Player6"
                obj.modalPresentationStyle = UIModalPresentationStyle.popover
                obj.preferredContentSize = CGSize(width:150, height: 150)
                obj.popoverPresentationController!.delegate = self
                self.present(obj, animated: true, completion: nil)
                let popover = obj.popoverPresentationController
                popover!.sourceView = self.DropDownButton6
                popover!.sourceRect = self.DropDownButton6.bounds
                popover!.permittedArrowDirections = UIPopoverArrowDirection.up
                
            }
            else if status == "0"{
                
            }
        }, Failure: {failler in
            print("something wrong happend",failler.localizedDescription)
        })
        
    }
    
}


extension ProfileCreateTeamVC{
    
    static func GetPlateformList(){
        
        var DicInput = [String:AnyObject]()
        WebHelper.requestPostUrlWithoutprogressHud(strURL: GlobalConstant.get_platforms, Dictionary: DicInput, Success: {success in
            let status = String(describing: success.value(forKey: "status")!)
            if status == "1"
            {
                ProfileCreateTeamVC.PlateformArray = success.object(forKey: "Platformlist") as! NSArray
            }
            else if status == "0"{
                
            }
        }, Failure: {failler in
            print("faller occured")
        })
        
    }
    
    
    func getUserNameList(textByUser:String) {
        var DicInput = ["usernametext": textByUser as AnyObject ,"game_id":ProfileCreateTeamVC.game_id as AnyObject]
        print("input data is...........",DicInput)
        WebHelper.requestPostUrl(strURL: GlobalConstant.gameusers, Dictionary: DicInput, Success: {success in
            let status = String(describing: success.value(forKey: "status")!)
            
            if status == "1"
            {
                print("data fromthe serve ris this which is coming right now",success)
                DropDownViewController.userLiatarray = success.object(forKey: "UserGameInfo") as! NSArray
            }
            else if status == "0"{
                
            }
        }, Failure: {failler in
            print("something wrong happend",failler.localizedDescription)
        })
    }
    
    
    func canOpenURL(_ string: String?) -> Bool
    {
        guard let urlString = string,
            let url = URL(string: urlString)
            else { return false }
        
        if !UIApplication.shared.canOpenURL(url) { return false }
        
        let regEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[regEx])
        return predicate.evaluate(with: string)
    }
    
    
    
    func CteateTeam() {
        
        var DicInput = [String:AnyObject]()
        var MemberList:NSArray?
        print("self.NoOfPlayer::::::::::::::",self.NoOfPlayer)
        if self.NoOfPlayer == "1"{
            let obj1:NSDictionary  = ["memberusername":TeamMembers1.text! as  String,"memberrole":"4" as  String]
            MemberList = [obj1]
        }else if self.NoOfPlayer == "2"{
            
            let obj1:NSDictionary  = ["memberusername":TeamMembers1.text! as  String,"memberrole":"4" as  String]
            let obj2:NSDictionary  = ["memberusername":TeamMembers2.text! as  String,"memberrole":"4" as  String]
            MemberList = [obj1,obj2]
        }
        else if self.NoOfPlayer == "3"{
            let obj1:NSDictionary  = ["memberusername":TeamMembers1.text! as  AnyObject,"memberrole":"4" as  AnyObject]
            let obj2:NSDictionary  = ["memberusername":TeamMembers2.text! as  AnyObject ,"memberrole":"4" as  AnyObject]
            let obj3:NSDictionary  = ["memberusername":TeamMembers3.text! as  AnyObject,"memberrole":"4" as  AnyObject]
            MemberList = [obj1,obj2,obj3]
            
        }
        else if self.NoOfPlayer == "4"{
            let obj1:NSDictionary  = ["memberusername":TeamMembers1.text! as  AnyObject,"memberrole":"4" as  AnyObject]
            let obj2:NSDictionary  = ["memberusername":TeamMembers2.text! as  AnyObject ,"memberrole":"4" as  AnyObject]
            let obj3:NSDictionary  = ["memberusername":TeamMembers3.text! as  AnyObject,"memberrole":"4" as  AnyObject]
            let obj4:NSDictionary  = ["memberusername":TeamMembers4.text! as  AnyObject,"memberrole":"4" as  AnyObject]
            MemberList = [obj1,obj2,obj3,obj4]
            
        }
        else if self.NoOfPlayer == "5"{
            let obj1:NSDictionary  = ["memberusername":TeamMembers1.text! as  AnyObject,"memberrole":"4" as  AnyObject]
            let obj2:NSDictionary  = ["memberusername":TeamMembers2.text! as  AnyObject ,"memberrole":"4" as  AnyObject]
            let obj3:NSDictionary  = ["memberusername":TeamMembers3.text! as  AnyObject,"memberrole":"4" as  AnyObject]
            let obj4:NSDictionary  = ["memberusername":TeamMembers4.text! as  AnyObject,"memberrole":"4" as  AnyObject]
            let obj5:NSDictionary  = ["memberusername":TeamMembers5.text! as  AnyObject,"memberrole":"4" as  AnyObject]
            MemberList = [obj1,obj2,obj3,obj4,obj5]
            
        }
        else if self.NoOfPlayer == "6"{
            let obj1:NSDictionary  = ["memberusername":TeamMembers1.text! as  AnyObject,"memberrole":"4" as  AnyObject]
            let obj2:NSDictionary  = ["memberusername":TeamMembers2.text! as  AnyObject,"memberrole":"4" as  AnyObject]
            let obj3:NSDictionary  = ["memberusername":TeamMembers3.text! as  AnyObject,"memberrole":"4" as  AnyObject]
            let obj4:NSDictionary  = ["memberusername":TeamMembers4.text! as  AnyObject,"memberrole":"4" as  AnyObject]
            let obj5:NSDictionary  = ["memberusername":TeamMembers5.text! as  AnyObject,"memberrole":"4" as  AnyObject]
            let obj6:NSDictionary  = ["memberusername":TeamMembers6.text! as  AnyObject,"memberrole":"4" as  AnyObject]
            MemberList = [obj1,obj2,obj3,obj4,obj5,obj6]
            
        }
        else
        {
           // let obj1:NSDictionary  = ["memberusername":TeamMembers1.text! as  String,"memberrole":"4" as  String]
            MemberList = []
        }
        
        print("MemberList::::::::::",MemberList,"===:::::::")
        DicInput = ["user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject,"TeamName":TeamNameTextField.text! as AnyObject,"TeamPlatformID":self.TeamPlateForm_Id as AnyObject,"TeamWebsite": TeamWebsiteTextField.text! as AnyObject,"TeamGameID": ProfileCreateTeamVC.game_id as AnyObject,"TeamGameUserID":TeamGameId.text! as AnyObject,"memberlist":MemberList!.toJSOnString() as AnyObject]
        print("DicInput json input",DicInput)
        WebHelper.requestPostUrlWithImage(strURL: GlobalConstant.create_team, Dictionary: DicInput, AndImage: self.image_var ?? #imageLiteral(resourceName: "find challenger"), forImageParameterName: "TeamImage", Success: {success in
            let status = String(describing: success.object(forKey: "status")!)
            if status == "1"{
                Global.showAlertMessageWithOkButtonAndTitle("", andMessage: success.value(forKey: "msg") as! String)
                self.navigationController?.popViewController(animated: true)
            }
            else if status == "0"{
                
            }
        }, Failure: {faller in
            print("somwthing went wrong in thius description",faller.localizedDescription)
        })
        
    }
    
    func AddFunction(){
        let tapGest1 = UITapGestureRecognizer(target: self, action: #selector(coverImage))
        coverImgButton.addGestureRecognizer(tapGest1)
        coverImgButton.isUserInteractionEnabled = true
        let tapGest2 = UITapGestureRecognizer(target: self, action: #selector(profileImage))
        profileImgButton.addGestureRecognizer(tapGest2)
        profileImgButton.isUserInteractionEnabled = true
    }
    
    func DecorateView(){
        TeamSizeTableView.separatorStyle = .none
        teammemberListTableView.separatorStyle = .none
        TeamNameView.layer.cornerRadius = 16
        YourRoleView.layer.cornerRadius = 16
        GamingPlateform.layer.cornerRadius = 16
        TeamWebsiteView.layer.cornerRadius = 16
        TeamMemberView1.layer.cornerRadius = 16
        TeamMemberView2.layer.cornerRadius = 16
        TeamMemberView3.layer.cornerRadius = 16
        TeamMemberView4.layer.cornerRadius = 16
        TeamMemberView5.layer.cornerRadius = 16
        TeamMemberView6.layer.cornerRadius = 16
        SelectRoleView1.layer.cornerRadius = 16
        SelectRoleView2.layer.cornerRadius = 16
        SelectRoleView3.layer.cornerRadius = 16
        SelectRoleView4.layer.cornerRadius = 16
        SelectRoleView5.layer.cornerRadius = 16
        SelectRoleView6.layer.cornerRadius = 16
        SelectGameView.layer.cornerRadius = 16
        ChoseImageView.layer.cornerRadius = 16
        TeamSizeView.layer.cornerRadius = 16
        ChooseImageButton.layer.borderWidth = 0.3
        ChooseImageButton.layer.borderColor = UIColor.lightGray.cgColor
        LikesView.layer.cornerRadius = 16
        Create_A_Team.layer.cornerRadius = 16
        GameIdView.layer.cornerRadius = 16
    }
    
    func tohidetheviews() {
        TeamMemberView1.isHidden = true
        TeamMemberView2.isHidden = true
        TeamMemberView3.isHidden = true
        TeamMemberView4.isHidden = true
        TeamMemberView5.isHidden = true
        TeamMemberView6.isHidden = true
        SelectRoleView1.isHidden = true
        SelectRoleView2.isHidden = true
        SelectRoleView3.isHidden = true
        SelectRoleView4.isHidden = true
        SelectRoleView5.isHidden = true
        SelectRoleView6.isHidden = true
        CreateButtonTopConstrain.constant = 30
        LikesView.isHidden = true
        Backgroundview.isHidden = true
        teammembersView.isHidden = true
        SelctTeamSizeView.isHidden = true
        
    }
    
    func HideShowTextViews(noofplayers:String)
    {
       
        Backgroundview.isHidden = true
        SelctTeamSizeView.isHidden = true
        let noofplayers = noofplayers
        if noofplayers == "1"{
            TeamMemberView1.isHidden = true
            SelectRoleView1.isHidden = true
            TeamMemberView2.isHidden = true
            SelectRoleView2.isHidden = true
            TeamMemberView3.isHidden = true
            SelectRoleView3.isHidden = true
            TeamMemberView4.isHidden = true
            SelectRoleView4.isHidden = true
            TeamMemberView5.isHidden = true
            SelectRoleView5.isHidden = true
            CreateButtonTopConstrain.constant = 20
            
        }
        else if noofplayers == "2"{
            TeamMemberView1.isHidden = false
            SelectRoleView1.isHidden = false
            TeamMemberView2.isHidden = true
            SelectRoleView2.isHidden = true
            TeamMemberView3.isHidden = true
            SelectRoleView3.isHidden = true
            TeamMemberView4.isHidden = true
            SelectRoleView4.isHidden = true
            TeamMemberView5.isHidden = true
            SelectRoleView5.isHidden = true
            CreateButtonTopConstrain.constant = 120-35
        }
        else if noofplayers == "3"{
            TeamMemberView1.isHidden = false
            SelectRoleView1.isHidden = false
            TeamMemberView2.isHidden = false
            SelectRoleView2.isHidden = false
            TeamMemberView3.isHidden = true
            SelectRoleView3.isHidden = true
            TeamMemberView4.isHidden = true
            SelectRoleView4.isHidden = true
            TeamMemberView5.isHidden = true
            SelectRoleView5.isHidden = true
            CreateButtonTopConstrain.constant = 170-35
        }
        else if noofplayers == "4"{
            TeamMemberView1.isHidden = false
            SelectRoleView1.isHidden = false
            TeamMemberView2.isHidden = false
            SelectRoleView2.isHidden = false
            TeamMemberView3.isHidden = false
            SelectRoleView3.isHidden = false
            TeamMemberView4.isHidden = true
            SelectRoleView4.isHidden = true
            TeamMemberView5.isHidden = true
            SelectRoleView5.isHidden = true
            CreateButtonTopConstrain.constant = 200-35
        }
        else if noofplayers == "5"{
            TeamMemberView1.isHidden = false
            SelectRoleView1.isHidden = false
            TeamMemberView2.isHidden = false
            SelectRoleView2.isHidden = false
            TeamMemberView3.isHidden = false
            SelectRoleView3.isHidden = false
            TeamMemberView4.isHidden = false
            SelectRoleView4.isHidden = false
            TeamMemberView5.isHidden = true
            SelectRoleView5.isHidden = true
            CreateButtonTopConstrain.constant = 250-35
            
        }
        else if noofplayers == "6"{
            TeamMemberView1.isHidden = false
            SelectRoleView1.isHidden = false
            TeamMemberView2.isHidden = false
            SelectRoleView2.isHidden = false
            TeamMemberView3.isHidden = false
            SelectRoleView3.isHidden = false
            TeamMemberView4.isHidden = false
            SelectRoleView4.isHidden = false
            TeamMemberView5.isHidden = false
            SelectRoleView5.isHidden = false
            CreateButtonTopConstrain.constant = 295-35
        }
    }
    
    
    
}








extension NSDictionary {
    func toJSonString() -> String {
        
        let dict = self
        var jsonString = "";
        
        do {
            
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
            
        } catch {
            print(error.localizedDescription)
        }
        
        return jsonString;
    }
}



extension NSArray
{
    func toJSOnString() -> String
    {
        let arr = self
        var jsonString = "";
        
        do {
            
            let jsonData = try JSONSerialization.data(withJSONObject: arr, options: .prettyPrinted)
            jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
            
        } catch {
            print(error.localizedDescription)
        }
        
        return jsonString;
        
        
    }
}
