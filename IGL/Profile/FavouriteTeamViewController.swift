//
//  FavouriteTeamViewController.swift
//  IGL
//
//  Created by baps on 11/11/18.
//  Copyright © 2018 Mac Min. All rights reserved.
//

import SafariServices
import UIKit

class FavouriteCel: UICollectionViewCell
{
    @IBOutlet weak var FavouritellImage: UIImageView!
    @IBOutlet weak var TeamNameLabel: UILabel!
    @IBOutlet weak var USERNAMElabel: UILabel!
    @IBOutlet weak var PointLabel1: UILabel!
    @IBOutlet weak var Pointlabel2: UILabel!
    @IBOutlet weak var pontlabel3: UILabel!
    @IBOutlet weak var Usergameidlabel: UILabel!
    
}



class ChallengersCel: UICollectionViewCell
{
    
    @IBOutlet weak var CellProfileImage: UIImageView!
    
    
}
class FavouriteTeamViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    
    @IBOutlet weak var FavouriteTeamCollectioView: UICollectionView!
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var CoverImage: UIImageView!
    @IBOutlet weak var UserLabel:UILabel!
    @IBOutlet weak var UserCreditLabel:UILabel!
    @IBOutlet weak var LikeView: UIView!
    
    @IBOutlet weak var MainViewHeightConstrain: NSLayoutConstraint!
    
    var ImagePicker = UIImagePickerController()
    var favouriteTeam:NSArray = []
    override func viewDidLoad()
    {
        super.viewDidLoad()
       
          ImagePicker.delegate = self
        ProfileImage.layer.cornerRadius = ProfileImage.frame.size.height/2
        ProfileImage.layer.borderWidth = 1
        ProfileImage.layer.borderColor =  #colorLiteral(red: 0.09019607843, green: 0.7215686275, blue: 0.9803921569, alpha: 1)
        ProfileImage.layer.masksToBounds = true
        ProfileImage.clipsToBounds = true
       // LikeView.layer.cornerRadius = 10
        
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        //let newHeight = height - XPhoneHeight
        layout.itemSize = CGSize(width: width/2-22, height: 250)
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 15
        FavouriteTeamCollectioView!.collectionViewLayout = layout
        setHeader()
        }
    func setHeader(){
        let urlstring =  UserDefaults.standard.value(forKey: "UserCoverImage") as! String
        let url1 = URL(string:urlstring)
        self.CoverImage?.kf.setImage(with: url1,
                                     placeholder:UIImage(named: "profile-top-banner"),
                                     options: [.transition(.fade(1))],
                                     progressBlock: nil,
                                     completionHandler: nil)
        
        let ProfileUrl = URL(string:UserDefaults.standard.value(forKey: "UserProfileImage") as! String)
        self.ProfileImage?.kf.setImage(with: ProfileUrl,
                                       placeholder:UIImage(named: "vikings-war-of-clans_min"),
                                       options: [.transition(.fade(1))],
                                       progressBlock: nil,
                                       completionHandler: nil)
        
        UserLabel.text = UserDefaults.standard.value(forKey: "username") as! String
        let credit = UserDefaults.standard.value(forKey: "UserCredit") as! String
        UserCreditLabel.text = "CURRENT BALANCE:₹\(10*Int(credit)!) (\(credit) IGL COINS)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
         TogetFavirateTeam()
    }
    
    
    @IBOutlet weak var OpenCameraForCover: UIButton!
    
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
        if self.favouriteTeam.count % 2 == 0{
            self.MainViewHeightConstrain.constant = CGFloat((self.favouriteTeam.count / 2 * 286) + 400) // 333
        }else {
            self.MainViewHeightConstrain.constant = CGFloat(((self.favouriteTeam.count + 1) / 2 * 286) + 400) // 450 - 333 = 117
        }
        
       return self.favouriteTeam.count
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = FavouriteTeamCollectioView.dequeueReusableCell(withReuseIdentifier: "FavouriteCel", for: indexPath) as! FavouriteCel
                let obj = self.favouriteTeam[indexPath.row] as! NSDictionary
                    cell.TeamNameLabel.text = obj.value(forKey: "TeamName") as! String
                    cell.USERNAMElabel.text = obj.value(forKey: "username") as! String
                    let urlstring =  obj.value(forKey: "TeamImage") as! String
                    let url1 = URL(string:urlstring)
                   cell.FavouritellImage?.kf.setImage(with: url1,
                                                 placeholder:UIImage(named: "placeholder"),
                                                 options: [.transition(.fade(1))],
                                                 progressBlock: nil,
                                                 completionHandler: nil)
                    Global.labelRoundRadius(cell.PointLabel1)
                     Global.labelRoundRadius(cell.Pointlabel2)
                      // Global.labelRoundRadius(cell.pontlabel3)
       cell.FavouritellImage.clipsToBounds = true

        return cell
       
   }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
         let obj = self.favouriteTeam[indexPath.row] as! NSDictionary
        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
        let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"TeamDeatilsViewController") as! TeamDeatilsViewController
        SwreavelObj.team_id = Global.getStringValue(obj.value(forKey: "TeamID") as AnyObject)
        self.navigationController?.pushViewController(SwreavelObj, animated: true)
//
//        let dict = self.favouriteTeam[indexPath.row] as! NSDictionary
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
    }
    @IBAction func NotiAction(_ sender:Any)
    {
        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
        let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(SwreavelObj, animated: true)
    }
    @IBAction func BackAction(_sender:Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func TogetFavirateTeam() {
        var DicInput = [String:AnyObject]()
        DicInput = ["user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject]
        
        WebHelper.requestPostUrl(strURL: GlobalConstant.get_favoriteteams, Dictionary: DicInput, Success: {success in
            let status = String(describing: success.value(forKey: "status")!)
            if status == "1"{
                 self.favouriteTeam = []
                self.favouriteTeam = success.value(forKey: "FavoriteteamList") as! NSArray
                self.FavouriteTeamCollectioView.reloadData()
            }
            else if status == "0"{
                
            }
        }, Failure: {failler in
            print("something went wrong",failler.localizedDescription)
        })
        
    }
}
