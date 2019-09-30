//
//  ProGameLibraryViewController.swift
//  IGL
//
//  Created by baps on 07/10/18.
//  Copyright © 2018 Mac Min. All rights reserved.
//

import UIKit

class GameSelectedCell: UICollectionViewCell {
    @IBOutlet weak var ImageView:UIImageView!
    @IBOutlet weak var NameOfGame:UILabel!
    @IBOutlet weak var PlayerNameLabel:UILabel!
    
}

class GmLibararyCell: UICollectionViewCell
{
    @IBOutlet weak var Imageview:UIImageView!
    @IBOutlet weak var GameName:UILabel!
    @IBOutlet weak var AddButton:UIButton!
}

class ProGameLibraryViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    @IBOutlet weak var LikeView:UIView!
    @IBOutlet weak var ProfileImage:UIImageView!
     @IBOutlet weak var CoverImage:UIImageView!
    @IBOutlet weak var UserLabel:UILabel!
    @IBOutlet weak var UserCreditLabel:UILabel!
    @IBOutlet weak var GameSelectedCollectionView:UICollectionView!
    @IBOutlet weak var GamesLibararyCollectionView:UICollectionView!
    var Gamelist = [Any]()
      var ImagePicker = UIImagePickerController()
      override func viewDidLoad() {
        super.viewDidLoad()
         ImagePicker.delegate = self
       // LikeView.layer.cornerRadius = 15
        ProfileImage.layer.borderWidth = 0.8
        ProfileImage.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        Global.roundRadius(ProfileImage)
        self.usergames()
//        if UIDevice().userInterfaceIdiom == .phone {
//            switch UIScreen.main.nativeBounds.height {
//            case 1136:
//                print("iPhone 5 or 5S or 5C")
//                let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//                layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//                let width = UIScreen.main.bounds.width
//                let height = UIScreen.main.bounds.height
//                //let newHeight = height - XPhoneHeight
//                layout.itemSize = CGSize(width: GameSelectedCollectionView.frame.width/2-1 , height: height/4)
//                layout.minimumInteritemSpacing = 1
//                layout.minimumLineSpacing = 11
//                //  GamesLibararyCollectionView!.collectionViewLayout = layout
//                GameSelectedCollectionView!.collectionViewLayout = layout
//
//            case 1334:
//                print("iPhone 6/6S/7/8")
//                let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//                layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//                let width = UIScreen.main.bounds.width
//                let height = UIScreen.main.bounds.height
//                //let newHeight = height - XPhoneHeight
//                layout.itemSize = CGSize(width: width/3+38, height: height/5+30)
//                layout.minimumInteritemSpacing = 1
//                layout.minimumLineSpacing = 11
//                //GamesLibararyCollectionView!.collectionViewLayout = layout
//                GameSelectedCollectionView!.collectionViewLayout = layout
//            case 2208:
//                print("iPhone 6+/6S+/7+/8+")
//                let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//                layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//                let width = UIScreen.main.bounds.width
//                let height = UIScreen.main.bounds.height
//                layout.itemSize = CGSize(width: width/3+43, height: height/5+25)
//                layout.minimumInteritemSpacing = 1
//                layout.minimumLineSpacing = 11
//                //  GamesLibararyCollectionView!.collectionViewLayout = layout
//                GameSelectedCollectionView!.collectionViewLayout = layout
//            case 2436:
//                print("iPhone X")
//                let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//                layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//                let width = UIScreen.main.bounds.width
//                let height = UIScreen.main.bounds.height
//                //let newHeight = height - XPhoneHeight
//                layout.itemSize = CGSize(width: width/3+36, height: height/5)
//                layout.minimumInteritemSpacing = 1
//                layout.minimumLineSpacing = 11
//                // GamesLibararyCollectionView!.collectionViewLayout = layout
//                GameSelectedCollectionView!.collectionViewLayout = layout
//            default:
//                print("unknown")
//                let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//                layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//                let width = UIScreen.main.bounds.width
//                let height = UIScreen.main.bounds.height
//                //let newHeight = height - XPhoneHeight
//                layout.itemSize = CGSize(width: width/2.5+15 , height: height/6+25)
//                layout.minimumInteritemSpacing = 1
//                layout.minimumLineSpacing = 10
//                //GamesLibararyCollectionView!.collectionViewLayout = layout
//                GameSelectedCollectionView!.collectionViewLayout = layout
//            }
//
//        }
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        layout.itemSize = CGSize(width: width/2.5+15 , height: 180)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 10
        GameSelectedCollectionView!.collectionViewLayout = layout
        setHeader()
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
    
    
    @IBAction func OpenCaemragForProfileImage(_ sender: Any) {
        ForGalleryCamera()
    }
    
    var  fromBanner = ""
    @IBAction func OpenCameraForCoverPicture(_ sender: Any) {
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == GameSelectedCollectionView
        {
            return self.Gamelist.count
        }
            //        else if collectionView == GamesLibararyCollectionView
            //        {
            //            return 15
            //        }
        else
        {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == GameSelectedCollectionView
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameSelectedCell", for: indexPath) as! GameSelectedCell
            let dict = self.Gamelist[indexPath.row] as! NSDictionary
            cell.NameOfGame.text = dict.value(forKey: "GameTitle") as! String
            let platform =  dict.value(forKey: "GamePlatform") as! String
            cell.PlayerNameLabel.text = "PLATFORM : " + platform
            let url = URL(string: dict.value(forKey: "GameImagePath") as! String)
            cell.ImageView.clipsToBounds = true
            cell.ImageView?.kf.setImage(with: url,
                                        placeholder:UIImage(named: "placeholder"),
                                        options: [.transition(.fade(1))],
                                        progressBlock: nil,
                                        completionHandler: nil)
            return cell
        }
            //        else if collectionView == GamesLibararyCollectionView
            //        {
            //            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GmLibararyCell", for: indexPath) as! GmLibararyCell
            //            return cell
            //        }
        else{
            let cell = UICollectionViewCell()
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        if collectionView == GameSelectedCollectionView
        {
            print("Task indexPath.row:",indexPath.row)
            let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
            let vc : GameDetailsVC = mainStoryboard.instantiateViewController(withIdentifier: "GameDetailsVC")as! GameDetailsVC
            let dict = self.Gamelist[indexPath.row] as! NSDictionary
            vc.game_id = dict.value(forKey: "GameID") as! String
            vc.title = dict.value(forKey: "GameTitle") as! String
            vc.Game_Image_url = dict.value(forKey: "GameImagePath") as! String
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
       return true
    }
    
    @IBAction func BackAction(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func NotiAction(_ sender:Any)
    {
        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
        let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(SwreavelObj, animated: true)
    }
    
    
    func usergames()
    {
        var dictPost:[String: AnyObject]!
        dictPost = ["user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject]
        WebHelper.requestPostUrl(strURL: GlobalConstant.usergames, Dictionary: dictPost, Success:{
            success in
            //let st1 =
          //  print(st1,"dfhjg dfhgdfjl gdfhjlgdlfj gdlfjgldjfh gh ldfhjgdljkf dfjklfghj kdfjhgdjkldfjkl fghjldfjklghdfjk")
            print("usergames -->success:::",success)
          let status = success.object(forKey: "status") as! String
            
            if status == "0"
            {
               
            }
            else
            {
                 self.Gamelist =  success.object(forKey: "Gamelist") as! [Any]
                 self.GameSelectedCollectionView.reloadData()
            }
            
            
            /// Result fail
//            if String(describing: success.value(forKey: "status")!) == "0"//success.value(forKey: "status") as! String == "0"
//            {
//
//            }/// Result success
//            else if String(describing: success.value(forKey: "status")!) == "1"
//            {
//               // self.Gamelist =  success.object(forKey: "Gamelist") as! [Any]
//                //self.GameSelectedCollectionView.reloadData()
//
//            }  /// Result nil
//            else
//            {
//                Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage: "Internal Server Error")
//            }
        }, Failure: {
            failure in
            Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage: failure.localizedDescription)
            
        })
        
    }
}
