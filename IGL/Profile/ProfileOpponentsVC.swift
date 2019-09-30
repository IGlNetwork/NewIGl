
//class ProfileOpponentsVC: UIViewController {


//class ProfileResultVC: UIViewController {

//
//  ProfileAchievementsVC.swift
//  IGL
//
//  Created by Mac Min on 07/10/18.
//  Copyright © 2018 Mac Min. All rights reserved.
//

import UIKit
import SafariServices
class TournamentOpponentCell: UICollectionViewCell
{
    
    @IBOutlet weak var CellImage: UIImageView!
    @IBOutlet weak var CellTitle: UILabel!
    @IBOutlet weak var CellOwnerName: UILabel!
    @IBOutlet weak var CellMembers: UILabel!
    @IBOutlet weak var CellGame: UILabel!
    @IBOutlet weak var CellGameID: UILabel!
    @IBOutlet weak var CellPlatform: UILabel!
    
    
    @IBOutlet weak var teamMember: UIButton!
    
    @IBOutlet weak var circleLabel1: UILabel!
    @IBOutlet weak var circlelabel2: UILabel!
    @IBOutlet weak var circlelabel3: UILabel!
    @IBOutlet weak var circlelabel4: UILabel!
    @IBOutlet weak var circlelabel5: UILabel!
    
}




//class ChallengeOpponentCell: UICollectionViewCell
//{
//
////  @IBOutlet weak var CellProfileImage: UIImageView!
//
//
//}
class ProfileOpponentsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    
    
    @IBOutlet weak var TournamentOpponentCollectionView: UICollectionView!
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var CoverImage: UIImageView!
    @IBOutlet weak var UserLabel:UILabel!
    @IBOutlet weak var UserCreditLabel:UILabel!
    @IBOutlet weak var BACKGROUNDVIEW: UIView!
    @IBOutlet weak var HeightofMainView: NSLayoutConstraint!
    @IBOutlet weak var MembersListView: UIView!
    @IBOutlet weak var MembersListTableView: UITableView!
    
   
    @IBOutlet weak var createTeamButton: UIButton!
    
    
    
    var ImagePicker = UIImagePickerController()
    var temaMemberList :NSArray = []
    override func viewDidLoad()
    {
        super.viewDidLoad()
      
        MembersListTableView.separatorStyle = .none
        ImagePicker.delegate = self
        ProfileImage.layer.cornerRadius = ProfileImage.frame.size.height/2
        ProfileImage.layer.borderWidth = 1
        ProfileImage.layer.borderColor =  #colorLiteral(red: 0.09019607843, green: 0.7215686275, blue: 0.9803921569, alpha: 1)
        ProfileImage.layer.masksToBounds = true
        ProfileImage.clipsToBounds = true
        BACKGROUNDVIEW.isHidden = true
        MembersListView.isHidden = true
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        layout.itemSize = CGSize(width: width/2-22, height: 360)
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 15
        createTeamButton.layer.cornerRadius = 12.5
        TournamentOpponentCollectionView!.collectionViewLayout = layout
        setHeader()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
          userprofileteams()
    }
    @IBAction func GoToAddTeamAction(_ sender: Any) {
        let StoryBoardObj = UIStoryboard(name: "Main", bundle: nil)
        let AddTeamObj = StoryBoardObj.instantiateViewController(withIdentifier: "ProfileCreateTeamVC") as! ProfileCreateTeamVC
        self.navigationController?.pushViewController(AddTeamObj, animated: true)
    }
    
    
    @IBAction func closeaction(_ sender: Any) {
        BACKGROUNDVIEW.isHidden = true
        MembersListView.isHidden = true
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
        
    }
    
    var  fromBanner = ""
    @IBAction func OpenCameraForCover(_ sender: Any) {
        ForGalleryCamera()
        fromBanner = "Banner"
    }
    
    @IBAction func OpenCameraForProfile(_ sender: Any) {
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
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage
        {
            if fromBanner == "Banner"{
                self.CoverImage.image = image
                fromBanner = ""
                var DicInput = [String:AnyObject]()
                DicInput = ["user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject]
                print("input data from the app is to the server is ",DicInput)
                WebHelper.requestPostUrlWithImage(strURL:GlobalConstant.update_coverpic, Dictionary: DicInput, AndImage: self.CoverImage.image!, forImageParameterName: "UserCoverImage", Success: {success in
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
                self.ProfileImage.image = image
                var DicInput = [String:AnyObject]()
                DicInput = ["user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject]
                print("input data from the app is to the server is ",DicInput)
                WebHelper.requestPostUrlWithImage(strURL: GlobalConstant.update_profilepic, Dictionary: DicInput, AndImage: self.ProfileImage.image!, forImageParameterName: "UserProfileImage", Success: {success in
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
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.TeamListArr.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = TournamentOpponentCollectionView.dequeueReusableCell(withReuseIdentifier: "TournamentOpponentCell", for: indexPath) as! TournamentOpponentCell
        let dict = self.TeamListArr[indexPath.row] as! NSDictionary
        cell.CellImage.layer.cornerRadius = cell.CellImage.frame.size.height / 2
        cell.CellImage.clipsToBounds = true
        cell.CellImage.layer.masksToBounds = true
        let url = URL(string:dict.value(forKey: "TeamImage") as! String)
        cell.CellImage?.kf.setImage(with: url,
                                    placeholder:UIImage(named: "placeholder"),
                                    options: [.transition(.fade(1))],
                                    progressBlock: nil,
                                    completionHandler: nil)
        cell.teamMember.tag = indexPath.row
        cell.CellTitle.text! = dict.value(forKey: "TeamName") as! String
        cell.CellMembers.text! = dict.value(forKey: "MemberCount") as! String
        cell.CellGame.text! = dict.value(forKey: "GameTitle") as! String
        cell.CellGameID.text! = dict.value(forKey: "TeamUserGameID") as! String
        cell.CellPlatform.text = dict.value(forKey: "PlatformName") as! String
        
        cell.CellOwnerName.text! = Global.getStringValue(dict.value(forKey: "username") as AnyObject)
        
        
        cell.circleLabel1.layer.cornerRadius = cell.circleLabel1.frame.size.height / 2
        cell.circleLabel1.clipsToBounds =  true
        cell.circlelabel2.layer.cornerRadius = cell.circlelabel2.frame.size.height / 2
        cell.circlelabel2.clipsToBounds =  true
        cell.circlelabel3.layer.cornerRadius = cell.circlelabel3.frame.size.height / 2
        cell.circlelabel3.clipsToBounds =  true
        cell.circlelabel4.layer.cornerRadius = cell.circlelabel4.frame.size.height / 2
        cell.circlelabel4.clipsToBounds =  true
        cell.circlelabel5.layer.cornerRadius = cell.circlelabel5.frame.size.height / 2
        cell.circlelabel5.clipsToBounds =  true
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let dict = self.TeamListArr[indexPath.row] as! NSDictionary
//        let teamid = dict.value(forKey: "TeamID") as! String
//        let user_id = UserDefaults.standard.value(forKey: "user_id") as! String
//        let url = "https://iglnetwork.com/beta/profile/teamdetails/\(teamid)/\(user_id)"
//        print("url is coming",url)
//        let svc = SFSafariViewController(url: URL(string: url)!, entersReaderIfAvailable: true)
//        svc.preferredBarTintColor =   #colorLiteral(red: 0.06274509804, green: 0.1411764706, blue: 0.2705882353, alpha: 1)
//        svc.preferredControlTintColor = #colorLiteral(red: 0.06274509804, green: 0.1411764706, blue: 0.2705882353, alpha: 1)
//        present(svc, animated: true, completion: nil)
//        if #available(iOS 11.0, *) {
//            svc.dismissButtonStyle = .close
//        } else {
//            // Fallback on earlier versions
//        }
         let dict = self.TeamListArr[indexPath.row] as! NSDictionary
        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
        let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"TeamDeatilsViewController") as! TeamDeatilsViewController
        SwreavelObj.team_id =  Global.getStringValue(dict.value(forKey: "TeamID") as AnyObject)
        self.navigationController?.pushViewController(SwreavelObj, animated: true)
    }
    
    
    @IBAction func ToGetAllMembersList(_ sender: UIButton){
        let obj = self.TeamListArr[sender.tag] as! NSDictionary
        let  TeamID = obj.value(forKey: "TeamID") as! String//  TeamID = 2208;
        TogetAllMemberList(team_id: TeamID)
        
    }
    
    func TogetAllMemberList(team_id:String)  {
        var dicInput  = [String:AnyObject]()
        dicInput = ["team_id":team_id as AnyObject]
        WebHelper.requestPostUrl(strURL: GlobalConstant.get_teammemberlist, Dictionary: dicInput, Success: {success in
            let status = String(describing: success.value(forKey: "status")!)
            if status == "1"{
                print("success is coming is ???",success)
                self.temaMemberList = success.value(forKey: "Userlist") as! NSArray
                self.MembersListTableView.reloadData()
                self.BACKGROUNDVIEW.isHidden = false
                self.MembersListView.isHidden = false
            }else{
                
            }
        }, Failure: {failler in
            print("something went wrong is ",failler.localizedDescription)
            Global.showAlertMessageWithOkButtonAndTitle("", andMessage: failler.localizedDescription)
        })
    }
    
    
    
    @IBAction func BackAction(_sender:Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func NotiAction(_ sender:Any)
    {
        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
        let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(SwreavelObj, animated: true)
    }
    
    var TeamListArr = [Any]()
    func userprofileteams()
    {   var DicInput = [String:AnyObject]()
        DicInput = ["user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject]
        print("input data is...........",DicInput)
        WebHelper.requestPostUrl(strURL: GlobalConstant.userprofileteams, Dictionary: DicInput, Success: {success in
            print("Scuuess::",success)
            let status = String(describing: success.value(forKey: "status")!)
            if status == "1"
            {
                self.TeamListArr = success.value(forKey: "TeamList") as! [Any]
                self.HeightofMainView.constant = CGFloat(((self.TeamListArr.count))*200)+400
                self.TournamentOpponentCollectionView.reloadData()
            }
            else if status == "0"{
                self.TeamListArr.removeAll()
                self.HeightofMainView.constant = 900
                self.TournamentOpponentCollectionView.reloadData()
            }
        }, Failure: {failler in
            print("something wrong happend",failler.localizedDescription)
            Global.showAlertMessageWithOkButtonAndTitle("", andMessage: failler.localizedDescription)
        })
    }
    
}

extension ProfileOpponentsVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.temaMemberList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
        Global.roundRadius(cell.ProfileImageView)
        let obj = self.temaMemberList[indexPath.row] as! NSDictionary
        cell.UserNameLabel.text = obj.value(forKey: "username") as! String
        let ProfileUrl = URL(string: obj.value(forKey: "UserProfileImage") as! String)
        cell.ProfileImageView?.kf.setImage(with: ProfileUrl,
                                           placeholder:UIImage(named: "placeholder"),
                                           options: [.transition(.fade(1))],
                                           progressBlock: nil,
                                           completionHandler: nil)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
        print("Task indexPath.row:",indexPath.row)
        let vc : PersonalProfileViewController = mainStoryboard.instantiateViewController(withIdentifier: "PersonalProfileViewController")as! PersonalProfileViewController
        let obj = self.temaMemberList[indexPath.row] as! NSDictionary
        let userid  = obj.value(forKey: "id") as! String
        vc.otherUserId = userid
        vc.COmingFromLandingScreen = false
        print("user id is coming", vc.otherUserId)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


