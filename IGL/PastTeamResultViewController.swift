//
//  PastTeamResultViewController.swift
//  IGL
//
//  Created by Apple on 30/07/19.
//  Copyright © 2019 Mac Min. All rights reserved.
//

import UIKit
class PastTournamentResultCell: UICollectionViewCell {
    @IBOutlet weak var TeamNameLabel: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var ResultNameLabel: UILabel!
    @IBOutlet weak var TournamentTitleLabel: UILabel!
    @IBOutlet weak var TournamentDateLAbel: UILabel!
 
    @IBOutlet var clickButton: UIButton!
    
    
}
class PastChallengesResultCell: UICollectionViewCell {
    
    @IBOutlet weak var TeamNameLabel: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var ResultNameLabel: UILabel!
    @IBOutlet weak var GameTitleLabel: UILabel!
    @IBOutlet weak var TournamentDateLAbel: UILabel!
   
}








class PastTeamResultViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDelegateFlowLayout{
    @IBOutlet weak var CoverImage: UIImageView!
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var PastTournamentCollectionView: UICollectionView!
    @IBOutlet weak var PastChallengesCollectionView: UICollectionView!
   // @IBOutlet weak var TorunamentHeight: NSLayoutConstraint!
    @IBOutlet var TitleTextLabel: UILabel!
    
    @IBOutlet var errormessagelabel2: UILabel!
    @IBOutlet var errormessagelabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var IGlCoinLabel: UILabel!
    //@IBOutlet weak var ChallengeHeight: NSLayoutConstraint!
    @IBOutlet weak var MainHeightOfView: NSLayoutConstraint!
    var team_id = ""
    var TournamentArr:NSArray = []
    var ChallengeArr:NSArray = []
    
      var ImagePicker = UIImagePickerController()
    
    @IBOutlet var Tournamentbtn: UIButton!
    @IBOutlet var challengebtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ImagePicker.delegate = self
        setHeader()
        ProfileImage.layer.cornerRadius = ProfileImage.frame.height/2
        ProfileImage.clipsToBounds = true
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        layout.itemSize = CGSize(width: width/2-22, height: 300)
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 15
        PastTournamentCollectionView!.collectionViewLayout = layout
       // PastChallengesCollectionView!.collectionViewLayout = layout
        GetPastResult()
        errormessagelabel.isHidden = true
         errormessagelabel2.isHidden = true
        setHeader()
        PastChallengesCollectionView.isHidden = true
        PastTournamentCollectionView.isHidden = false
        //PastTournamentCollectionView.reloadData()
//        if self.TournamentArr.count%2 == 0{
//            MainHeightOfView.constant = CGFloat(((self.TournamentArr.count)/2)*300+500)
//        }else{
//            MainHeightOfView.constant = CGFloat(((self.TournamentArr.count+1)/2)*300+500)
//        }
//
    }
    
    
    
    
    func setHeader(){
        let urlstring =  UserDefaults.standard.value(forKey: "UserCoverImage") as! String
        let url1 = URL(string:urlstring)
        self.CoverImage?.kf.setImage(with: url1,
                                     placeholder:UIImage(named: "placeholder"),
                                     options: [.transition(.fade(1))],
                                     progressBlock: nil,
                                     completionHandler: nil)
          self.CoverImage.clipsToBounds = true
        let ProfileUrl = URL(string:UserDefaults.standard.value(forKey: "UserProfileImage") as! String)
        self.ProfileImage?.kf.setImage(with: ProfileUrl,
                                         placeholder:UIImage(named: "placeholder"),
                                         options: [.transition(.fade(1))],
                                         progressBlock: nil,
                                         completionHandler: nil)
        
        usernameLabel.text = UserDefaults.standard.value(forKey: "username") as! String
        let credit = UserDefaults.standard.value(forKey: "UserCredit") as! String
        IGlCoinLabel.text = "CURRENT BALANCE:₹\(10*Int(credit)!) (\(credit) IGL COINS)"
        
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == PastTournamentCollectionView{
            if self.TournamentArr.count == 0{
               errormessagelabel.isHidden = false
               //errormessagelabel2.isHidden = true
            }else{
                errormessagelabel.isHidden = true
               // errormessagelabel2.isHidden = true
            }
            return self.TournamentArr.count
            print("count of the Tournament Array is ??",self.TournamentArr.count)
        }else{
            print("COunt of the challenges array is ???",ChallengeArr.count)
            if ChallengeArr.count == 0{
                 errormessagelabel.isHidden = false
                // errormessagelabel.isHidden = true
            }else{
                 errormessagelabel.isHidden = true
                // errormessagelabel.isHidden = true
            }
            return ChallengeArr.count
        }
          }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == PastTournamentCollectionView{
            let cell = PastTournamentCollectionView.dequeueReusableCell(withReuseIdentifier: "PastTournamentResultCell", for: indexPath) as! PastTournamentResultCell
            let dict = self.TournamentArr[indexPath.row] as! NSDictionary
            let url = URL(string:dict.value(forKey: "TeamImage") as! String)
            cell.ImageView?.kf.setImage(with: url,
                                        placeholder:UIImage(named: "placeholder"),
                                        options: [.transition(.fade(1))],
                                        progressBlock: nil,
                                        completionHandler: nil)
            cell.TeamNameLabel.text! = dict.value(forKey: "TeamName") as! String
            cell.ResultNameLabel.text! = Global.getStringValue(dict.value(forKey: "TournamentResult") as AnyObject)//dict.value(forKey: "TournamentResult") as! String
            cell.TournamentTitleLabel.text! = dict.value(forKey: "TournamentTitle") as! String
            cell.TournamentDateLAbel.text! = dict.value(forKey: "TournamentDate") as! String
              print("index row is PastTournamentCollectionView ???",indexPath.row,dict.value(forKey: "TournamentDate") as! String)
            cell.ImageView.clipsToBounds = true
            cell.clickButton.tag = indexPath.row
//            if self.TournamentArr.count%2 == 0{
//                MainHeightOfView.constant = CGFloat((self.TournamentArr.count/2)*300+450)
//            }else{
//                MainHeightOfView.constant = CGFloat(((self.TournamentArr.count+1)/2)*300+450)
//            }
           return cell
        }else{
           let cell = PastChallengesCollectionView.dequeueReusableCell(withReuseIdentifier: "PastChallengesResultCell", for: indexPath) as! PastChallengesResultCell
            let dict = self.ChallengeArr[indexPath.row] as! NSDictionary
            let url = URL(string:dict.value(forKey: "TeamImage") as! String)
            cell.ImageView?.kf.setImage(with: url,
                                        placeholder:UIImage(named: "placeholder"),
                                        options: [.transition(.fade(1))],
                                        progressBlock: nil,
                                        completionHandler: nil)
              cell.ImageView.clipsToBounds = true
             cell.TeamNameLabel.text! = dict.value(forKey: "TeamName") as! String
             cell.ResultNameLabel.text! = Global.getStringValue(dict.value(forKey: "ChallengeResult") as AnyObject)
            cell.GameTitleLabel.text! = dict.value(forKey: "GameTitle") as! String
            cell.TournamentDateLAbel.text! = dict.value(forKey: "ChallengeDate") as! String
              print("index row is PastChallengesCollectionView ???",indexPath.row,(dict.value(forKey: "ChallengeDate") as! String))
//            if self.ChallengeArr.count%2 == 0{
//               MainHeightOfView.constant = CGFloat(((self.ChallengeArr.count)/2)*300+450)
//            }else{
//                MainHeightOfView.constant = CGFloat(((self.ChallengeArr.count+1)/2)*300+450)
//            }
           return cell
        }
      
    }
   
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool
    {
          if collectionView == PastTournamentCollectionView
          {
            
            
          }
          else
          {
            
          }
        
        return true
    }
    
    
    @IBAction func cellClickAction(_ sender: Any) {
        
        
    }
    
    
    
    @IBAction func BackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
   
    func GetPastResult(){
        var InputIdc = [String:AnyObject]()
        InputIdc = ["team_id":self.team_id as AnyObject]
        print("input dictionary is",InputIdc)
        WebHelper.requestPostUrl(strURL: GlobalConstant.teamresult, Dictionary: InputIdc, Success: {success in
            print("Team id:::",InputIdc,"........",success)
            let status = String(describing: success.value(forKey: "status")!)
            if status == "1"{
                self.TournamentArr = success.value(forKey: "TournamentResults") as!  NSArray
                self.ChallengeArr = success.value(forKey: "ChallengeResults") as!  NSArray
                self.PastChallengesCollectionView.reloadData()
               self.PastTournamentCollectionView.reloadData()
                let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                let width = UIScreen.main.bounds.width
                layout.itemSize = CGSize(width: width/2-22, height: 300)
                self.PastChallengesCollectionView!.collectionViewLayout = layout
//                if (self.TournamentArr.count+self.ChallengeArr.count)%2 == 0{
//                    self.MainHeightOfView.constant = CGFloat(((self.TournamentArr.count+self.ChallengeArr.count))/2*300+450)
//                }else{
//                   self.MainHeightOfView.constant = CGFloat(((self.TournamentArr.count+self.ChallengeArr.count+1))/2*300+450)
//                }
                }else{
               print("Something went wrong!!!")
                self.TournamentArr = []
                 self.ChallengeArr = []
                self.errormessagelabel.isHidden = false
            }
        }, Failure:{failler in
           print("Something went wrong!!!",failler.localizedDescription)
        })
    }
    
    @IBAction func TournamentAction(_ sender: UIButton){
        PastChallengesCollectionView.isHidden = true
        PastTournamentCollectionView.isHidden = false
        challengebtn.backgroundColor = #colorLiteral(red: 0.1098039216, green: 0.2549019608, blue: 0.4196078431, alpha: 1)
        Tournamentbtn.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.5254901961, blue: 0.8, alpha: 1)
        PastTournamentCollectionView.reloadData()
        TitleTextLabel.text = "PREVIOUS TOURNAMENT RESULTS"
        GetPastResult()
        PastTournamentCollectionView.reloadData()
        if self.TournamentArr.count%2 == 0{
            MainHeightOfView.constant = CGFloat(((self.TournamentArr.count)/2)*300+500)
        }else{
            MainHeightOfView.constant = CGFloat(((self.TournamentArr.count+1)/2)*300+500)
        }
      
    }
    
    @IBAction func ChallengeAction(_ sender: Any) {
        PastChallengesCollectionView.isHidden = false
        PastTournamentCollectionView.isHidden = true
        Tournamentbtn.backgroundColor =  #colorLiteral(red: 0.1098039216, green: 0.2549019608, blue: 0.4196078431, alpha: 1)
        challengebtn.backgroundColor =   #colorLiteral(red: 0.2039215686, green: 0.5254901961, blue: 0.8, alpha: 1)
        TitleTextLabel.text = "PREVIOUS CHALLENGE RESULTS"
        GetPastResult()
        PastChallengesCollectionView.reloadData()
        if self.ChallengeArr.count%2 == 0{
            MainHeightOfView.constant = CGFloat(((self.ChallengeArr.count)/2)*300+500)
        }else{
            MainHeightOfView.constant = CGFloat(((self.ChallengeArr.count+1)/2)*300+500)
        }
      
   }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == PastTournamentCollectionView{
            let obj = self.TournamentArr[indexPath.row] as! NSDictionary
            let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
            let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"TeamDeatilsViewController") as! TeamDeatilsViewController
            SwreavelObj.team_id = Global.getStringValue(obj.value(forKey: "TeamID") as AnyObject)
            self.navigationController?.pushViewController(SwreavelObj, animated: true)
        }else if collectionView == PastChallengesCollectionView{
            let obj = self.ChallengeArr[indexPath.row] as! NSDictionary
            let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
            let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"TeamDeatilsViewController") as! TeamDeatilsViewController
            SwreavelObj.team_id = Global.getStringValue(obj.value(forKey: "TeamID") as AnyObject)
            self.navigationController?.pushViewController(SwreavelObj, animated: true)
        }
       
    }
    
    var  fromBanner = ""
    @IBAction func OpenCameraForCover(_ sender: Any) {
        ForGalleryCamera()
        fromBanner = "Banner"
    }
    
    @IBAction func OpenCameraForProfile(_ sender: Any) {
         ForGalleryCamera()
         fromBanner = ""
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
                        // UserDefaults.standard.value(forKey: "UserProfileImage")
                        UserDefaults.standard.set(Global.getStringValue(success.value(forKey: "UserProfileImage") as AnyObject), forKey: "UserProfileImage")
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
    
    
    
    
    
    
}

