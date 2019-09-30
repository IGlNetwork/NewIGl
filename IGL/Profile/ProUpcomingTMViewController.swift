//
//  ProUpcomingTMViewController.swift
//  IGL
//
//  Created by baps on 07/10/18.
//  Copyright © 2018 Mac Min. All rights reserved.
//

import UIKit
import SafariServices

class ProUPComingTMCel: UICollectionViewCell {
    @IBOutlet weak var Imageview:UIImageView!
    @IBOutlet weak var Tournament: UILabel!
    @IBOutlet weak var DateLabel:UILabel!
    @IBOutlet weak var PrizeMoney:UILabel!
    @IBOutlet weak var JoinView:UIView!
    @IBOutlet weak var viewdetailbtn: UIButton!
    
}
class ProUpcomingTMViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    @IBOutlet weak var TorunamentCollectionview: UICollectionView!
    @IBOutlet weak var LikeView: UIView!
    @IBOutlet weak var ProfileImageview: UIImageView!
    @IBOutlet weak var CoverImage: UIImageView!
    @IBOutlet weak var PastREsultView: UIView!
    @IBOutlet weak var UserLabel:UILabel!
    @IBOutlet weak var UserCreditLabel:UILabel!
    var Tournamentlist = [Any]()
    @IBOutlet weak var HeightofMainView: NSLayoutConstraint!
    
    var ImagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        CoverImage.clipsToBounds = true
        ProfileImageview.clipsToBounds = true
        usertournaments()
        ImagePicker.delegate = self
        PastREsultView.isHidden = true
        PastREsultView.layer.cornerRadius = 15
        //  LikeView.layer.cornerRadius = 15
        Global.roundRadius(ProfileImageview)
        ProfileImageview.layer.borderWidth = 0.8
        ProfileImageview.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        //let newHeight = height - XPhoneHeight
        layout.itemSize = CGSize(width: width/2-15, height: 235.0)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        TorunamentCollectionview!.collectionViewLayout = layout
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
        self.ProfileImageview?.kf.setImage(with: ProfileUrl,
                                           placeholder:UIImage(named: "vikings-war-of-clans_min"),
                                           options: [.transition(.fade(1))],
                                           progressBlock: nil,
                                           completionHandler: nil)
        
        UserLabel.text = UserDefaults.standard.value(forKey: "username") as! String
        let credit = UserDefaults.standard.value(forKey: "UserCredit") as! String
        UserCreditLabel.text = "CURRENT BALANCE:₹\(10*Int(credit)!) (\(credit) IGL COINS)"
        
    }
    
    
    @IBAction func OprncameraforProfile(_ sender: Any) {
        ForGalleryCamera()
    }
    
    var  fromBanner = ""
    @IBAction func OpemCameraforcoverpic(_ sender: Any) {
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
                self.ProfileImageview.image = image
                var DicInput = [String:AnyObject]()
                DicInput = ["user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject]
                print("input data from the app is to the server is ",DicInput)
                WebHelper.requestPostUrlWithImage(strURL: GlobalConstant.update_profilepic, Dictionary: DicInput, AndImage: self.ProfileImageview.image!, forImageParameterName: "UserProfileImage", Success: {success in
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
        if self.Tournamentlist.count % 2 == 0{
            print("Even..........................................",CGFloat((((self.Tournamentlist.count )) / 2 * 259) + 360))
            
            self.HeightofMainView.constant = CGFloat((((self.Tournamentlist.count )) / 2 * 259) + 380)
        }
        else
        {
            print("Odd..........................................",CGFloat((((self.Tournamentlist.count ) + 1 ) / 2 * 259) + 360))
            self.HeightofMainView.constant = CGFloat((((self.Tournamentlist.count ) + 1 ) / 2 * 259) + 380)
        }
        
        
        return Tournamentlist.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProUPComingTMCel", for: indexPath) as! ProUPComingTMCel
        cell.JoinView.layer.cornerRadius = 13
        let dict = Tournamentlist[indexPath.row] as! NSDictionary
        cell.Tournament.text = dict.value(forKey: "TournamentTitle") as! String
        cell.PrizeMoney.text = (dict.value(forKey: "TournamentWinnerPrize") as! String)+" IGL COINS"
        cell.DateLabel.text = dict.value(forKey: "TournamentDate") as! String
        let url = URL(string: dict.value(forKey: "TournamentLogo") as! String)
        cell.Imageview.clipsToBounds = true
        cell.viewdetailbtn.tag = indexPath.row
        cell.Imageview?.kf.setImage(with: url,
                                    placeholder:UIImage(named: "placeholder"),
                                    options: [.transition(.fade(1))],
                                    progressBlock: nil,
                                    completionHandler: nil)
        return cell
    }
    
    
    @IBAction func gotodetails(_ sender: UIButton) {
        
        
        let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
        let vc : TournamentDetailsVC = mainStoryboard.instantiateViewController(withIdentifier: "TournamentDetailsVC") as! TournamentDetailsVC
        let dict = Tournamentlist[sender.tag] as! NSDictionary
        vc.tournament_id =  dict.value(forKey: "TournamentID") as! String
        vc.title = dict.value(forKey: "TournamentTitle") as! String
        vc.Tournamentitle = dict.value(forKey: "TournamentTitle") as! String
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        
        print("Task indexPath.row:",indexPath.row)
        let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
        let vc : TournamentDetailsVC = mainStoryboard.instantiateViewController(withIdentifier: "TournamentDetailsVC") as! TournamentDetailsVC
        let dict = Tournamentlist[indexPath.row] as! NSDictionary
        vc.tournament_id =  dict.value(forKey: "TournamentID") as! String
        vc.title = dict.value(forKey: "TournamentTitle") as! String
        vc.Tournamentitle = dict.value(forKey: "TournamentTitle") as! String
        self.navigationController?.pushViewController(vc, animated: true)
        
        return true
    }
    
    @IBAction func BackAction(_sender:Any)
    {
        //        let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
        //        let vc : SWRevealViewController = mainStoryboard.instantiateViewController(withIdentifier: "SW-Reaveal")as! SWRevealViewController
        //  self.present(vc, animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func PastResultAction(_ sender : UIButton)
    {
        
        //https://iglnetwork.com/beta/profile/results/<username>/<teamid>
        let user_id = UserDefaults.standard.value(forKey: "user_id") as! String
        let url = "https://iglnetwork.com/beta/stores/index/\(user_id)"
        print("url is coming",url)
        let svc = SFSafariViewController(url: URL(string: url)!, entersReaderIfAvailable: true)
        svc.preferredBarTintColor =   #colorLiteral(red: 0.06274509804, green: 0.1411764706, blue: 0.2705882353, alpha: 1)
        svc.preferredControlTintColor = #colorLiteral(red: 0.06274509804, green: 0.1411764706, blue: 0.2705882353, alpha: 1)
        present(svc, animated: true, completion: nil)
        if #available(iOS 11.0, *) {
            svc.dismissButtonStyle = .close
        } else {
            // Fallback on earlier versions
        }
        
        
        
        
        //
        //        let StoryBoardObj = UIStoryboard(name: "Main", bundle: nil)
        //        let AddTeamObj = StoryBoardObj.instantiateViewController(withIdentifier: "ProfileResultVC") as! ProfileResultVC
        //        self.navigationController?.pushViewController(AddTeamObj, animated: true)
    }
    
    @IBAction func GoToNotification(_ sender: UIBarButtonItem) {
        
        let storyObj = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyObj.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func usertournaments()
    {
        var dictPost:[String: AnyObject]!
        dictPost = ["user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject]
        WebHelper.requestPostUrl(strURL: GlobalConstant.usertournaments, Dictionary: dictPost, Success:{
            success in
            let status = success.object(forKey: "status") as! String
            print("usergames -->success:::",success)
            /// Result fail
            if status == "0"
            {
                
            }/// Result success
            else if status == "1"
            {
                self.Tournamentlist =  success.object(forKey: "Tournamentlist") as! [Any]
                
                self.TorunamentCollectionview.reloadData()
                
            }  /// Result nil
            else
            {
                // self.HeightofMainView.constant = 1000
                Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage: "Internal Server Error")
            }
        }, Failure: {
            failure in
            Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage: failure.localizedDescription)
            
        })
        
    }
}

