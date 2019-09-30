
//class ProfileResultVC: UIViewController {

//
//  ProfileAchievementsVC.swift
//  IGL
//
//  Created by Mac Min on 07/10/18.
//  Copyright © 2018 Mac Min. All rights reserved.
//

import UIKit

class ProfileResultCell: UICollectionViewCell
{
    @IBOutlet weak var TeamNameLabel: UILabel!
    @IBOutlet weak var pointlabel1: UILabel!
    
    @IBOutlet weak var pointlabel2: UILabel!
    @IBOutlet weak var TrophyNameLabel: UILabel!
    @IBOutlet weak var TrophyImage: UIImageView!
    @IBOutlet weak var DateLabel: UILabel!
    
}



class ChallengersCell: UICollectionViewCell
{
    
    @IBOutlet weak var CellProfileImage: UIImageView!
    

}
class ProfileResultVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    
    
    @IBOutlet weak var ProfileResultCollectioView: UICollectionView!
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var CoverImage: UIImageView!
    @IBOutlet weak var UserLabel:UILabel!
    @IBOutlet weak var UserCreditLabel:UILabel!
    
    @IBOutlet weak var LikeView: UIView!
    
    @IBOutlet var MainViewHeightConstrain: NSLayoutConstraint!
    
    @IBOutlet weak var ChallengersCollectionView: UICollectionView!
    
     var ImagePicker = UIImagePickerController()
    var TrophiesArray:NSArray = []
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
         ImagePicker.delegate = self
        ProfileImage.layer.cornerRadius = ProfileImage.frame.size.height/2
        ProfileImage.layer.borderWidth = 1
        ProfileImage.layer.borderColor =  #colorLiteral(red: 0.09019607843, green: 0.7215686275, blue: 0.9803921569, alpha: 1)
        ProfileImage.layer.masksToBounds = true
        ProfileImage.clipsToBounds = true
      //  LikeView.layer.cornerRadius = 10
        
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        //let newHeight = height - XPhoneHeight
        layout.itemSize = CGSize(width: width/2-22, height: 286)
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 15
        ProfileResultCollectioView!.collectionViewLayout = layout
        setHeader()
        ToGetTrophies()

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
     var  fromBanner = ""
    @IBAction func OpenCameraForCover(_ sender: Any) {
        ForGalleryCamera()
        fromBanner = "Banner"    }
    
    @IBOutlet weak var OpenCameraForcover: UIButton!
    
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
        print("count for te trophies array",self.TrophiesArray.count)
        if self.TrophiesArray.count % 2 == 0{
             self.MainViewHeightConstrain.constant = CGFloat((self.TrophiesArray.count / 2 * 286) + 550) // 333
        }else {
             self.MainViewHeightConstrain.constant = CGFloat(((self.TrophiesArray.count + 1) / 2 * 286) + 550) // 450 - 333 = 117
        }
       
      return self.TrophiesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = ProfileResultCollectioView.dequeueReusableCell(withReuseIdentifier: "ProfileResultCell", for: indexPath) as! ProfileResultCell
      print("cell for row at")
        if self.TrophiesArray.count != 0{
            let obj = self.TrophiesArray[indexPath.row] as! NSDictionary
            Global.labelRoundRadius(cell.pointlabel1)
              Global.labelRoundRadius(cell.pointlabel2)
            
            cell.TeamNameLabel.text = Global.getStringValue( obj.value(forKey: "TeamName") as AnyObject)
            cell.TrophyNameLabel.text = Global.getStringValue( obj.value(forKey: "TrophyName") as AnyObject)
            let date = Global.getStringValue( obj.value(forKey: "TrophyDate") as AnyObject)
            cell.DateLabel.text! = Global.getDateFromString(stndFormat: "yyyy-MM-dd", getFormat: "dd-MM-yyyy", dateString: date, isDate: true)
            
            
            let urlstring =    obj.value(forKey: "TrophyImageName") as! String
            let url1 = URL(string:urlstring)
            cell.TrophyImage?.kf.setImage(with: url1,
                                          placeholder:UIImage(named: "placeholder"),
                                          options: [.transition(.fade(1))],
                                          progressBlock: nil,
                                          completionHandler: nil)
        }
       
        
     return cell
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
    
    
    
    func ToGetTrophies(){
        var DicInput = [String:AnyObject]()
        DicInput = ["user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject]
        WebHelper.requestPostUrl(strURL: GlobalConstant.get_trophies, Dictionary: DicInput, Success: {success in
            let status = String(describing: success.value(forKey: "status")!)
            if status == "1"{
                self.TrophiesArray = []
                self.TrophiesArray = success.value(forKey: "TrophyList") as! NSArray
                self.ProfileResultCollectioView.reloadData()
            }
            else if status == "0"{
                
            }
        }, Failure: {failler in
            print("Something went wrong",failler.localizedDescription)
        })
        
        
    }
    
}
