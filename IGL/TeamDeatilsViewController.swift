//
//  TeamDeatilsViewController.swift
//  IGL


import UIKit
import Charts
import PieCharts

class TeamDeatilsViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    //    @IBOutlet weak var TrounamentView: UIView!
    //    @IBOutlet weak var ChallengesView: UIView!
    //    @IBOutlet weak var BattleRoyalView: UIView!
    
    @IBOutlet weak var TrounamentPieChartView: PieChart!
    @IBOutlet weak var ChallengesPieChartView: PieChart!
    @IBOutlet weak var BattleRoyalPieChartView: PieChart!
    
    
    @IBOutlet weak var ProfilePicture: UIImageView!
    @IBOutlet var CoverImage: UIImageView!
    
    @IBOutlet weak var TeamsProfileImage: UIImageView!
    
    @IBOutlet weak var circlelable1: UILabel!
    @IBOutlet weak var circlelabel2: UILabel!
    @IBOutlet weak var circleLabel: UILabel!
    @IBOutlet weak var circlelabel4: UILabel!
    @IBOutlet weak var circle5label: UILabel!
    
    @IBOutlet weak var Onwerlabel: UILabel!
    @IBOutlet weak var GameNameLabel: UILabel!
    @IBOutlet var GameIdLabel: UILabel!
    @IBOutlet weak var Platformlabel: UILabel!
    @IBOutlet weak var MembersLabel: UILabel!
    @IBOutlet var TeamNameLabel: UILabel!
    
    @IBOutlet var OverViewLabel: UILabel!
    @IBOutlet var UserCreditLabel: UILabel!
    @IBOutlet var UserLabel: UILabel!
    
    @IBOutlet var TournamentDataNotFound: UILabel!
    @IBOutlet var ChallengeDataNotFound: UILabel!
    @IBOutlet var BRDataNotFound: UILabel!
    
    
    var team_id = ""
    var TournamentLossCount = ""
    var TournamentWinCount = ""
    
    var BRLossCount = ""
    var BRWinCount = ""
    
    var ChallengeLossCount = ""
    var ChallengeWinCount = ""
    
    var ImagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        TournamentDataNotFound.isHidden = true
        ChallengeDataNotFound.isHidden = true
        BRDataNotFound.isHidden = true
        super.viewDidLoad()
        //       updateChartData()
        //        RoyalChartData()
        //        ChallengesChartData()
        
        ProfilePicture.layer.cornerRadius = ProfilePicture.frame.height/2
        ProfilePicture.clipsToBounds = true
        TeamsProfileImage.layer.cornerRadius = TeamsProfileImage.frame.height/2
        TeamsProfileImage.clipsToBounds =  true
        Global.labelRoundRadius(circlelable1)
        Global.labelRoundRadius(circlelabel2)
        Global.labelRoundRadius(circleLabel)
        Global.labelRoundRadius(circlelabel4)
        Global.labelRoundRadius(circle5label)
        
        ImagePicker.delegate = self
        setHeader()
        teamDetails()
        
        // Do any additional setup after loading the view.
    }
    
    func setPieChart()
    {
        
        var TournamentWon:Double = 0.0
        var TournamentLoss:Double = 0.0
        
        let Loss1 = Double(TournamentLossCount)
        if Loss1 != nil{
            print("Losss11111",Loss1)
            TournamentLoss = Loss1!
        }
        
        
        let Won1 = Double(TournamentWinCount)
        if Won1 != nil{
              print("Wins11111",Won1)
            TournamentWon = Won1!
        }
        
        if TournamentWon < 1 && TournamentLoss < 1{
            TournamentDataNotFound.isHidden = false
        }else{
            // if some value than Show Charts
            TrounamentPieChartView.models = [
                PieSliceModel(value: TournamentWon, color: #colorLiteral(red: 0.4235294118, green: 0.8823529412, blue: 0.4235294118, alpha: 1)),
                PieSliceModel(value: TournamentLoss, color: #colorLiteral(red: 0.1843137255, green: 0.5294117647, blue: 0.7803921569, alpha: 1))
            ]
            TrounamentPieChartView.layers = [PiePlainTextLayer()]
            
            // [PiePlainTextLayer(), PieLineTextLayer()]
            // Do any additional setup after loading the view.
            
            let textLayerSettings = PiePlainTextLayerSettings()
            textLayerSettings.viewRadius = 2
            textLayerSettings.hideOnOverflow = true
            textLayerSettings.label.font = UIFont.systemFont(ofSize: 8)
            
            let formatter = NumberFormatter()
            formatter.maximumFractionDigits = 1
            textLayerSettings.label.textGenerator = {slice in
                return formatter.string(from: slice.data.percentage * 100 as NSNumber).map{"\($0)%"} ?? ""
            }
        }
        
      
        
        
        
        var challengeWon:Double = 1.0
        var challengeLoss:Double = 0.0
        
        let Loss2 = Double(ChallengeLossCount)
        if Loss2 != nil{
            challengeLoss = Loss2!
        }
        
        
        let Won2 = Double(ChallengeWinCount)
        if Won2 != nil{
            challengeWon = Won2!
        }
        
        if challengeWon < 1 && challengeLoss < 1 {
            ChallengeDataNotFound.isHidden = false
        }else{
            ChallengesPieChartView.models = [
                PieSliceModel(value: challengeWon, color: #colorLiteral(red: 0.4235294118, green: 0.8823529412, blue: 0.4235294118, alpha: 1)),
                PieSliceModel(value: challengeLoss, color: #colorLiteral(red: 0.1843137255, green: 0.5294117647, blue: 0.7803921569, alpha: 1))
            ]
            
            ChallengesPieChartView.layers = [PiePlainTextLayer()]
            // Do any additional setup after loading the view.
            
            let textLayerSettings1 = PiePlainTextLayerSettings()
            textLayerSettings1.viewRadius = 20
            textLayerSettings1.hideOnOverflow = true
            textLayerSettings1.label.font = UIFont.systemFont(ofSize: 8)
            
            let formatter1 = NumberFormatter()
            formatter1.maximumFractionDigits = 1
            textLayerSettings1.label.textGenerator = {slice in
                return formatter1.string(from: slice.data.percentage * 100 as NSNumber).map{"\($0)%"} ?? ""
            }
        }
        
        
        
        
        var BRWon:Double = 1.0
        var BRLoss:Double = 0.0
        
        
        
         let Loss3 = Double(BRLossCount)
       
        if Loss3 != nil{
             BRLoss = Loss3!
        }
        
        
        let Won3 = Double(BRWinCount)
        if Won3 != nil{
            BRWon = Won3!
        }
        
        if BRWon < 1 && BRLoss < 1{
            BRDataNotFound.isHidden = false
        }else{
            BattleRoyalPieChartView.models = [
                PieSliceModel(value: BRWon, color: #colorLiteral(red: 0.4235294118, green: 0.8823529412, blue: 0.4235294118, alpha: 1)),
                PieSliceModel(value: BRLoss, color: #colorLiteral(red: 0.1843137255, green: 0.5294117647, blue: 0.7803921569, alpha: 1))
            ]
            
            BattleRoyalPieChartView.layers = [PiePlainTextLayer()]
            // Do any additional setup after loading the view.
            
            let textLayerSettings2 = PiePlainTextLayerSettings()
            textLayerSettings2.viewRadius = 20
            textLayerSettings2.hideOnOverflow = true
            textLayerSettings2.label.font = UIFont.systemFont(ofSize: 8)
            
            let formatter2 = NumberFormatter()
            formatter2.maximumFractionDigits = 1
            textLayerSettings2.label.textGenerator = {slice in
                return formatter2.string(from: slice.data.percentage * 100 as NSNumber).map{"\($0)%"} ?? ""
            }
        }
        
        
        
        
        
        
    }
    
    
    
   
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func Notification(_ sender: Any) {
        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
        let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(SwreavelObj, animated: true)
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
        self.ProfilePicture?.kf.setImage(with: ProfileUrl,
                                         placeholder:UIImage(named: "placeholder"),
                                         options: [.transition(.fade(1))],
                                         progressBlock: nil,
                                         completionHandler: nil)
        
        UserLabel.text = UserDefaults.standard.value(forKey: "username") as! String
        let credit = UserDefaults.standard.value(forKey: "UserCredit") as! String
        UserCreditLabel.text = "CURRENT BALANCE:₹\(10*Int(credit)!) (\(credit) IGL COINS)"
        
    }
    
    
    
    func teamDetails()
    {
        var dictPost:[String: AnyObject]!
        dictPost = ["team_id":self.team_id as AnyObject]
        print("Dictionary:",dictPost)
        
        WebHelper.requestPostUrl(strURL: GlobalConstant.teamdetails, Dictionary: dictPost, Success:{
            success in
            let status = success.object(forKey: "status") as! String
            print("status:",success)
            /// Result fail
            if status == "0"
            {
                self.TournamentDataNotFound.isHidden = false
                self.ChallengeDataNotFound.isHidden = false
                self.BRDataNotFound.isHidden = false
            }
                /// Result success
            else if status == "1"
            {
                
                if let dataArr = success.object(forKey: "Userlist") as? NSArray{
                    
                    if let dict =  dataArr.firstObject as? NSDictionary{
                        self.MembersLabel.text! = Global.getStringValue(dict.value(forKey: "MemberCount") as AnyObject)
                        self.Platformlabel.text! = Global.getStringValue(dict.value(forKey: "PlatformName") as AnyObject)
                        self.GameNameLabel.text! = Global.getStringValue(dict.value(forKey: "GameTitle") as AnyObject)
                        self.Onwerlabel.text! = Global.getStringValue(dict.value(forKey: "username") as AnyObject)
                        self.GameIdLabel.text! = Global.getStringValue(dict.value(forKey: "TeamUserGameID") as AnyObject)
                        self.TeamNameLabel.text! = Global.getStringValue(dict.value(forKey: "TeamName") as AnyObject)
                        self.OverViewLabel.text! = "TEAM MEMBERS:" + Global.getStringValue(dict.value(forKey: "MemberCount") as AnyObject) + " | PLATFORM:" + Global.getStringValue(dict.value(forKey: "PlatformName") as AnyObject) + " | GAME:" + Global.getStringValue(dict.value(forKey: "GameTitle") as AnyObject)
                        
                        self.ChallengeLossCount = Global.getStringValue(dict.value(forKey: "ChallengeLossCount") as AnyObject)
                        self.ChallengeWinCount = Global.getStringValue(dict.value(forKey: "ChallengeWinCount") as AnyObject)
                        
                        self.BRLossCount = Global.getStringValue(dict.value(forKey: "BRLossCount") as AnyObject)
                        self.BRWinCount = Global.getStringValue(dict.value(forKey: "BRWinCount") as AnyObject)
                        
                        self.TournamentLossCount = Global.getStringValue(dict.value(forKey: "TournamentLossCount") as AnyObject)
                        self.TournamentWinCount = Global.getStringValue(dict.value(forKey: "TournamentWinCount") as AnyObject)
                        
                        
                        
                        let urlStr = Global.getStringValue(dict.value(forKey: "TeamImage") as AnyObject)
                        let url1 = URL(string:urlStr)
                        self.TeamsProfileImage?.kf.setImage(with: url1,
                                                            placeholder:UIImage(named: "placeholder"),
                                                            options: [.transition(.fade(1))],
                                                            progressBlock: nil,
                                                            completionHandler: nil)
                        
                    }
                    
                    self.setPieChart()
                }
                
                
                
            }  /// Result nil
            else
            {
                
            }
        }, Failure: {
            failure in
            
            
        })
        
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
                self.ProfilePicture.image = image
                var DicInput = [String:AnyObject]()
                DicInput = ["user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject]
                print("input data from the app is to the server is ",DicInput)
                WebHelper.requestPostUrlWithImage(strURL: GlobalConstant.update_profilepic, Dictionary: DicInput, AndImage: self.ProfilePicture.image!, forImageParameterName: "UserProfileImage", Success: {success in
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
    
    
    @IBAction func pastresultACtion(_ sender: Any) {
        let storyobj = UIStoryboard(name: "Main", bundle: nil)
        let resultobj = storyobj.instantiateViewController(withIdentifier: "PastTeamResultViewController") as! PastTeamResultViewController
        resultobj.team_id = self.team_id
        self.navigationController?.pushViewController(resultobj, animated: true)
        print("this is going to launch the  next screen ")
    }

    
    
    
}

