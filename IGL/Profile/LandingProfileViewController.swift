//
//  LandingProfileViewController.swift
//  IGL
//
//  Created by Mac Min on 05/10/18.
//  Copyright © 2018 Mac Min. All rights reserved.
//

import UIKit
import SafariServices


struct LandingScreen{
    var title = ""
    var imageNAme = ""
}


class LandingProfileCell: UICollectionViewCell {
    @IBOutlet weak var IMageVIew:UIImageView!
    @IBOutlet weak var TitleLabel:UILabel!
    @IBOutlet weak var widthOfImage: NSLayoutConstraint!
}



class LandingProfileViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,SWRevealViewControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var HeightNavBar: NSLayoutConstraint!
    @IBOutlet weak var MenuButton:UIBarButtonItem!
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var CoverImageView:UIImageView!
    @IBOutlet weak var LikeView: UIView!
    @IBOutlet weak var CollectionView: UICollectionView!
    @IBOutlet weak var  ProfileNameLabel:UILabel!
    @IBOutlet weak var Creditlabel:UILabel!
    
    var LandingDataArray =   [LandingScreen]()
    var ImagePicker = UIImagePickerController()
    var iglcoin = ""
    var ledgericon = ""
   override func viewDidLoad() {
        super.viewDidLoad()
    ImagePicker.delegate = self
    //for profile image
    let tap = UITapGestureRecognizer(target: self, action: #selector(LandingProfileViewController.OpenCameraOrGalleryForProfile))
    ProfileImage.addGestureRecognizer(tap)
    ProfileImage.isUserInteractionEnabled = true
    let tatusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
    tatusBar.backgroundColor = Global.hexStringToUIColor("#3486CC")
    guard let tabBar = tabBarController?.tabBar else { return }
    tabBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    tabBar.selectionIndicatorImage = UIImage().makeImageWithColorAndSize(color: #colorLiteral(red: 0.04705882353, green: 0.09019607843, blue: 0.168627451, alpha: 1), size: CGSize(width: tabBar.frame.width/5, height: tabBar.frame.height))
    tabBar.unselectedItemTintColor = UIColor.white

     //Actions for the SideMenu.
    MenuButton.target = revealViewController()
    MenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
    //set the delegate to teh SWRevealviewcontroller
    revealViewController().delegate = self
    self.revealViewController().rearViewRevealWidth = 280
    if self.revealViewController() != nil {
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }
            StoreArrayData()
    //LikeView.layer.cornerRadius = 12
    ProfileImage.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
    ProfileImage.layer.borderWidth = 2
    Global.roundRadius(ProfileImage)
    
 
    // NavViewBar.titleTextAttributes =  attributes
    if UIDevice().userInterfaceIdiom == .phone {
        switch UIScreen.main.nativeBounds.height {
        case 1136:
 print("iPhone 5 or 5S or 5C")
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            let width = UIScreen.main.bounds.width
            let height = UIScreen.main.bounds.height
            //let newHeight = height - XPhoneHeight
            layout.itemSize = CGSize(width: width/4+5, height:width/4+5)
            layout.minimumInteritemSpacing = 1
           // layout.minimumLineSpacing =
            CollectionView!.collectionViewLayout = layout
        
        case 1334:
            print("iPhone 6/6S/7/8")
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            let width = UIScreen.main.bounds.width
            let height = UIScreen.main.bounds.height
            //let newHeight = height - XPhoneHeight
            layout.itemSize = CGSize(width: width/4+10, height:  width/4+10)
            layout.minimumInteritemSpacing = 1
            layout.minimumLineSpacing = 15
            CollectionView!.collectionViewLayout = layout
        case 2208:
            print("iPhone 6+/6S+/7+/8+")
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            let width = UIScreen.main.bounds.width
            let height = UIScreen.main.bounds.height
            //let newHeight = height - XPhoneHeight
            layout.itemSize = CGSize(width: width/4+13, height: width/4+13)
            layout.minimumInteritemSpacing = 1
            layout.minimumLineSpacing = 12
            CollectionView!.collectionViewLayout = layout
        case 2436:
            print("iPhone X")
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            let width = UIScreen.main.bounds.width
            let height = UIScreen.main.bounds.height
            //let newHeight = height - XPhoneHeight
            layout.itemSize = CGSize(width: width/4+12, height: width/4+12)
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 8
            CollectionView!.collectionViewLayout = layout
        default:
            print("unknown")
        }
    }
   Get_ProfileHeaderdetails()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func OpenCameraOrgalleryProfile(_ sender: Any) {
        ForGalleryCamera()
    }
    
    @objc func OpenCameraOrGalleryForProfile()
    {
       
    }
     var  fromBanner = ""
    @IBAction func OpenCameraOrGalleryCover(_ sender: Any) {
        ForGalleryCamera()
        fromBanner = "Banner"
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
                self.CoverImageView.image = image
                fromBanner = ""
                var DicInput = [String:AnyObject]()
                DicInput = ["user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject]
                print("input data from the app is to the server is ",DicInput)
                WebHelper.requestPostUrlWithImage(strURL:GlobalConstant.update_coverpic, Dictionary: DicInput, AndImage: self.CoverImageView.image!, forImageParameterName: "UserCoverImage", Success: {success in
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
    
    
    func StoreArrayData() {
        let obj1 = LandingScreen(title: "PROFILE", imageNAme: "avtar-icon")
        LandingDataArray.append(obj1)
        let obj2 = LandingScreen(title: "GAMES", imageNAme: "gamepad-icon")
        LandingDataArray.append(obj2)
        let obj3 = LandingScreen(title: "TOURNAMENTS", imageNAme: "trophy-1")
        LandingDataArray.append(obj3)
        let obj4 = LandingScreen(title: "CHALLENGES", imageNAme: "challenges-1")
        LandingDataArray.append(obj4)
        let obj5 = LandingScreen(title: "TEAMS", imageNAme: "team_icon_profile")
        LandingDataArray.append(obj5)
        let obj6 = LandingScreen(title: "TROPHIES", imageNAme: "trophies_icon_profile")
        LandingDataArray.append(obj6)
        let obj7 = LandingScreen(title: "WALLET", imageNAme: "wallet-icon")
        LandingDataArray.append(obj7)
        let obj8 = LandingScreen(title: "ACHIEVEMENTS", imageNAme: "achivments-icon")
        LandingDataArray.append(obj8)
        let obj9 = LandingScreen(title: "FAVOURITE TEAMS", imageNAme: "heart-blank")
        LandingDataArray.append(obj9)
      }
   func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return LandingDataArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LandingProfileCell", for: indexPath) as! LandingProfileCell
        let obj = LandingDataArray[indexPath.row]
        cell.IMageVIew.image = UIImage(named: obj.imageNAme)
        cell.TitleLabel.text = obj.title
        if indexPath.row == 7 {
            cell.widthOfImage.constant = 25
        }else if indexPath.row == 8
        {
            cell.widthOfImage.constant = 35
        }
        cell.layer.shadowRadius = 10.0
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        guard let tabBar = tabBarController?.tabBar else { return }
        tabBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        tabBar.selectionIndicatorImage = UIImage().makeImageWithColorAndSize(color: #colorLiteral(red: 0.04705882353, green: 0.09019607843, blue: 0.168627451, alpha: 1), size: CGSize(width: tabBar.frame.width/5, height: tabBar.frame.height))
        tabBar.unselectedItemTintColor = UIColor.white
    }
    //for dissable homescreen
    public func revealController(_ revealController: SWRevealViewController!, willMoveTo position: FrontViewPosition) {
        
        let tagId = 112151
        
        print("revealController delegate called")
        
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
        }}
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
            let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
            if indexPath.row == 0
            {
                print("Task indexPath.row:",indexPath.row)
                let vc : PersonalProfileViewController = mainStoryboard.instantiateViewController(withIdentifier: "PersonalProfileViewController")as! PersonalProfileViewController
                vc.COmingFromLandingScreen = true
                self.navigationController?.pushViewController(vc, animated: true)
               
            }
            else if indexPath.row == 1
            {
                //let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
                let vc : ProGameLibraryViewController = mainStoryboard.instantiateViewController(withIdentifier: "ProGameLibraryViewController")as! ProGameLibraryViewController
               self.navigationController?.pushViewController(vc, animated: true)
                
            }
            else if indexPath.row == 2
            {
               
               // let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
                let vc : ProUpcomingTMViewController = mainStoryboard.instantiateViewController(withIdentifier: "ProUpcomingTMViewController")as! ProUpcomingTMViewController
               self.navigationController?.pushViewController(vc, animated: true)
            }
             else if indexPath.row == 3
            {
               // let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
                let vc : ChallengeRMadeViewController = mainStoryboard.instantiateViewController(withIdentifier: "ChallengeRMadeViewController")as! ChallengeRMadeViewController
                vc.isComingFromWinnerViewController = false
               self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexPath.row == 4
            {
               
              //  let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
                let vc : ProfileOpponentsVC = mainStoryboard.instantiateViewController(withIdentifier: "ProfileOpponentsVC")as! ProfileOpponentsVC
               self.navigationController?.pushViewController(vc, animated: true)
                
            }
            else if indexPath.row == 5
            {
               
                //let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
                let vc : ProfileResultVC = mainStoryboard.instantiateViewController(withIdentifier: "ProfileResultVC")as! ProfileResultVC
               self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexPath.row == 6
            {
                
               let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
               let vc : WalletViewController = mainStoryboard.instantiateViewController(withIdentifier: "WalletViewController")as! WalletViewController
                vc.IGLCoinsVar = self.iglcoin
                vc.iglledgercoin = self.ledgericon
               self.navigationController?.pushViewController(vc, animated: true)
               
                
            }
            else if indexPath.row == 7
            {
                let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
                let vc : ProfileAchievementsVC = mainStoryboard.instantiateViewController(withIdentifier: "ProfileAchievementsVC")as! ProfileAchievementsVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexPath.row == 8
            {
               let vc : FavouriteTeamViewController = mainStoryboard.instantiateViewController(withIdentifier: "FavouriteTeamViewController") as! FavouriteTeamViewController
                self.navigationController?.pushViewController(vc, animated: true)
          }
            return true
   
    
    }

    @IBAction func GoToNotification(_ sender: UIBarButtonItem) {
        let storyObj = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyObj.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension LandingProfileViewController{
    func Get_ProfileHeaderdetails(){
        var dictPost:[String: AnyObject]!
        dictPost = ["user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject,"profile_id":"" as AnyObject]
        print("input data is......",dictPost)
        WebHelper.requestPostUrl(strURL:GlobalConstant.profile, Dictionary: dictPost, Success: {
            success in
            print("sucess from the server is",success)
            let userDetails = success["UserHeaderDetails"] as! NSDictionary
            UserDefaults.standard.set(userDetails.value(forKey: "UserCoverImage") as! String, forKey: "UserCoverImage")
            UserDefaults.standard.set(userDetails.value(forKey: "UserProfileImage") as! String, forKey: "UserProfileImage")
            UserDefaults.standard.set(userDetails.value(forKey: "username") as! String, forKey: "username")
            UserDefaults.standard.set(userDetails.value(forKey: "UserCredit") as! String, forKey: "UserCredit")
            
            let url1 = URL(string:userDetails["UserCoverImage"] as! String)
            self.CoverImageView?.kf.setImage(with: url1,
                                                placeholder:UIImage(named: "profile-top-banner"),
                                                options: [.transition(.fade(1))],
                                                progressBlock: nil,
                                                completionHandler: nil)
            let url2 = URL(string:userDetails["UserProfileImage"] as! String)
            self.ProfileImage?.kf.setImage(with: url2,
                                             placeholder:UIImage(named: "vikings-war-of-clans_min"),
                                             options: [.transition(.fade(1))],
                                             progressBlock: nil,
                                             completionHandler: nil)
            let username = userDetails["username"] as! String
            let firstname = userDetails["firstname"] as! String
            let lastname = userDetails["lastname"] as! String
            if let iglcoin = userDetails["IGLCOIN"] as? String{
              self.ledgericon =  userDetails["IGLCOIN"] as! String
            }
            self.ProfileNameLabel.text =  userDetails["username"] as! String
            let credit = userDetails["UserCredit"] as! String
            self.iglcoin =  userDetails["UserCredit"] as! String
            self.Creditlabel.text = "CURRENT BALANCE:₹\(10*Int(credit)!) (\(credit) IGL COINS)"
            
            
        }, Failure: {failler in
            
        })
    }
}
/*

 "username": "ravi",
 "firstname": "Ravinder",
 
 */
