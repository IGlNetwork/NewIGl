//
//  ProfileAchievementsVC.swift
//  IGL
//
//  Created by Mac Min on 07/10/18.
//  Copyright © 2018 Mac Min. All rights reserved.
//

import UIKit

class AchievementCell: UICollectionViewCell
{
    @IBOutlet weak var CellTitle: UILabel!
    // @IBOutlet weak var CellDescriptions: UILabel!
    @IBOutlet weak var CellButton: UIButton!
}

class ProfileAchievementsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    
    
    @IBOutlet weak var AchievementCollectionView: UICollectionView!
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var LikeView: UIView!
    @IBOutlet weak var CoverImage: UIImageView!
    @IBOutlet weak var UserLabel:UILabel!
    @IBOutlet weak var UserCreditLabel:UILabel!
    var ImagePicker = UIImagePickerController()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        get_achievments()
        AchievementCollectionView.isUserInteractionEnabled = false
        ImagePicker.delegate = self
        ProfileImage.layer.cornerRadius = ProfileImage.frame.size.height/2
        ProfileImage.layer.borderWidth = 1
        ProfileImage.layer.borderColor =  #colorLiteral(red: 0.09019607843, green: 0.7215686275, blue: 0.9803921569, alpha: 1)
        ProfileImage.layer.masksToBounds = true
        ProfileImage.clipsToBounds = true
        //LikeView.layer.cornerRadius = 10
        
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        //let newHeight = height - XPhoneHeight
        layout.itemSize = CGSize(width: width/2-22, height: 150.0)
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 15
        AchievementCollectionView!.collectionViewLayout = layout
        setHeader()
        //UpComingTMCollectionView.isScrollEnabled = false
        // Do any additional setup after loading the view.
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
        return self.AchievmentsArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = AchievementCollectionView.dequeueReusableCell(withReuseIdentifier: "AchievementCell", for: indexPath) as! AchievementCell
        cell.CellButton.layer.borderWidth = 1.5
        cell.CellButton.layer.borderColor = #colorLiteral(red: 0.09019607843, green: 0.7215686275, blue: 0.9803921569, alpha: 1)
        print("inside the method of the class is",indexPath.row)
        let dict = self.AchievmentsArr[indexPath.row] as! NSDictionary
        cell.CellTitle.text! = dict.value(forKey: "Text") as! String
        let str = String(describing: dict.value(forKey: "Iglcoins")!) + " IGL COIN'S"
        cell.CellButton.setTitle(str, for: UIControlState.normal)
        
        return cell
    }
    @IBAction func BackAction(_sender:Any)
    {
        //        let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
        //        let vc : SWRevealViewController = mainStoryboard.instantiateViewController(withIdentifier: "SW-Reaveal")as! SWRevealViewController
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func NotiAction(_ sender:Any)
    {
        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
        let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(SwreavelObj, animated: true)
    }
    
    var AchievmentsArr = [Any]()
    
    func get_achievments()
    {
        var DicInput = [String:AnyObject]()
        DicInput = ["user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject]
        print("input data is...........",DicInput)
        WebHelper.requestPostUrl(strURL: GlobalConstant.get_achievments, Dictionary: DicInput, Success: {success in
            print("Scuuess::",success)
            let status = String(describing: success.value(forKey: "status")!)
            
            if status == "1"
            {
                self.AchievmentsArr = success.value(forKey: "Achievments") as! [Any]
                self.AchievementCollectionView.reloadData()
            }
            else if status == "0"{
                
            }
        }, Failure: {failler in
            print("something wrong happend",failler.localizedDescription)
        })
    }
    
    
    
}
