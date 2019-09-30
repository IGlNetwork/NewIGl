//
//  ChallengeRMadeViewController.swift
//  IGL
//
//  Created by baps on 07/10/18.
//  Copyright © 2018 Mac Min. All rights reserved.
//

import UIKit
import LTHRadioButton


class ChallengesReceivedCel: UICollectionViewCell {
    @IBOutlet weak var GametitleLabel:UILabel!
    @IBOutlet weak var Imageview:UIImageView!
    @IBOutlet weak var DateLabel:UILabel!
    @IBOutlet weak var IGLcoinLabel:UILabel!
    @IBOutlet weak var challengerLabel:UILabel!
  
  
    @IBOutlet weak var StatusLabel: UILabel!
    
    // Schedule Later View
    @IBOutlet weak var laterView: UIView!
    @IBOutlet weak var LatterDateLabel: UILabel!
    @IBOutlet weak var TimeLabel: UILabel!
    
    // Accept Reject View
    @IBOutlet weak var acceptRejectView: UIView!
    @IBOutlet weak var AcceptButton:UIButton!
    @IBOutlet weak var RejectButton:UIButton!
    
    // Play now button and View
    @IBOutlet weak var ChallengestatusView: UIView!
    @IBOutlet weak var hallengestatusButton:UIButton!
    
    
    @IBOutlet weak var lossDisputeView: UIView!
    @IBOutlet weak var acceptLossButton: UIButton!
    @IBOutlet weak var raiseDisputeButton: UIButton!
    
    
}


class ChallengeMadeCell: UICollectionViewCell {
    @IBOutlet weak var GameTitlelabel:UILabel!
    @IBOutlet weak var Imageview:UIImageView!
    @IBOutlet weak var DateLabel:UILabel!
    @IBOutlet weak var IGLcoinLabel:UILabel!
    @IBOutlet weak var ChallengedLabel: UILabel!
    @IBOutlet weak var PendingLabel:UILabel!
    @IBOutlet weak var SendMessage:UIButton!
    @IBOutlet weak var WinOrLOSSView: UIView!
    @IBOutlet weak var winorLossLAbel: UILabel!
    @IBOutlet weak var ScheduleLaterUIView: UIView!
    @IBOutlet weak var ScheduleLaterLabelDAte: UILabel!
    @IBOutlet weak var ScheduleLaterTimeLabel: UILabel!
    @IBOutlet weak var AcceptAndRejectView: UIView!
    @IBOutlet weak var RejectButton: UIButton!
    @IBOutlet weak var AcceptButton: UIButton!
    @IBOutlet weak var scheduleAcceptButton: UIButton!
    @IBOutlet weak var ScheduleRejectButton: UIButton!
}

class ChallengeRMadeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    

    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var CoverImage: UIImageView!
    @IBOutlet weak var UserLabel:UILabel!
    @IBOutlet weak var UserCreditLabel:UILabel!
    @IBOutlet weak var LikeView:UIView!
    @IBOutlet weak var ChallengesCollectionView:UICollectionView! // Challenge Receive....
    @IBOutlet weak var ChallengesMadeCollectionView:UICollectionView! // Challenge Made.......
    
    @IBOutlet weak var MainHeightofView: NSLayoutConstraint!
    @IBOutlet weak var AcceptandPlay: LTHRadioButton!
    
    @IBOutlet weak var Scheduleleter: LTHRadioButton!
    
    @IBOutlet weak var AcceptView: UIView!
    @IBOutlet weak var DateTimeSchedulerView: UIView!
    @IBOutlet weak var BackgroundView: UIView!
    @IBOutlet weak var BackgroundView2: UIView!
    @IBOutlet weak var AcceptButton: UIButton!
    @IBOutlet weak var AcceptButtonSchedular2: UIButton!
    @IBOutlet weak var DateView: UIView!
    @IBOutlet weak var TimeView: UIView!
    @IBOutlet weak var SelectedDateLabel:UILabel!
    @IBOutlet weak var SelectedTimeLabel:UILabel!
    
    @IBOutlet weak var DatePickerView: UIView!
    @IBOutlet weak var TimePickerView: UIView!
    @IBOutlet weak var DatePicker: UIDatePicker!
    @IBOutlet weak var TimePicker: UIDatePicker!
    @IBOutlet weak var CancelDateButton: UIButton!
    @IBOutlet weak var CancelTimeButton: UIButton!
    @IBOutlet weak var DoneDateButton: UIButton!
    @IBOutlet weak var DoneTimeButton: UIButton!
   
    //for the tab for challenges type
    @IBOutlet weak var ChallengeMadebtn: UIButton!
    @IBOutlet weak var challengeReceivedbtn: UIButton!
    @IBOutlet weak var challengesTypeLabel: UILabel!
    
    var ImagePicker = UIImagePickerController()
    
    var ChallengeMadeArray:NSArray = []
    var ChallengeReceivedArray:NSArray = []
    
    let dateformatter = DateFormatter()
    var challenge_id = ""
    var challenge_status = ""
    var laterdate = ""
    var laterTime = ""
    var iscoming_fromResult = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CoverImage.clipsToBounds = true
        ProfileImage.clipsToBounds = true
        ///for the tab
        ChallengesCollectionView.isHidden = false
        ChallengesMadeCollectionView.isHidden = true
        var components = DateComponents()
        components.year = -100
        let minDate = Calendar.current.date(byAdding: components, to: Date())
        DatePicker.minimumDate = minDate
        DateView.layer.cornerRadius = 18
        DateView.layer.borderWidth = 2
        DateView.layer.borderColor = #colorLiteral(red: 0.1725490196, green: 0.4823529412, blue: 0.7803921569, alpha: 1)
        TimeView.layer.borderWidth = 2
        TimeView.layer.borderColor = #colorLiteral(red: 0.1725490196, green: 0.4823529412, blue: 0.7803921569, alpha: 1)
        TimeView.layer.cornerRadius = 18
        DateTimeSchedulerView.layer.cornerRadius = 5
        DateTimeSchedulerView.isHidden = true
        AcceptButtonSchedular2.layer.cornerRadius = 18
        BackgroundView2.isHidden = true
        AcceptButton.layer.cornerRadius = 16
        AcceptView.layer.cornerRadius = 5
        BackgroundView.isHidden = true
        AcceptView.isHidden = true
       // LikeView.isHidden = true
        DatePickerView.isHidden = true
        DatePickerView.layer.cornerRadius = 5
        TimePickerView.isHidden = true
        TimePickerView.layer.cornerRadius = 5
        CancelDateButton.layer.cornerRadius = 15
        CancelTimeButton.layer.cornerRadius = 14
        DoneDateButton.layer.cornerRadius = 15
        DoneTimeButton.layer.cornerRadius = 14
        ImagePicker.delegate = self
       // LikeView.layer.cornerRadius = 16
        Global.roundRadius(ProfileImage)
        ProfileImage.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        ProfileImage.layer.borderWidth = 0.8
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        layout.itemSize = CGSize(width: width/2-16, height: 280)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 10
        ChallengesCollectionView!.collectionViewLayout = layout
        let layout1: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout1.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout1.itemSize = CGSize(width: width/2-16, height: 310)
        ChallengesMadeCollectionView!.collectionViewLayout = layout1
        setHeader()
       // ChallengeMade()  // working fine
        ChallengeRecivedByUser()
        AcceptandPlay.translatesAutoresizingMaskIntoConstraints = false
        Scheduleleter.translatesAutoresizingMaskIntoConstraints = false
        AcceptandPlay.selectedColor = #colorLiteral(red: 0.1725490196, green: 0.4823529412, blue: 0.7803921569, alpha: 1)
        Scheduleleter.selectedColor = #colorLiteral(red: 0.1725490196, green: 0.4823529412, blue: 0.7803921569, alpha: 1)
        AcceptandPlay.select(animated: true)
        Scheduleleter.deselect(animated: true)
        AcceptandPlay.onSelect {
            self.Scheduleleter.deselect(animated: true)
        }
        Scheduleleter.onDeselect {
            self.AcceptandPlay.select(animated: true)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
     //   ChallengeMade()  // working fine
        ChallengeRecivedByUser()
    }
    @IBOutlet weak var AcceptandplayAction: UIView!
    
    @IBAction func AcceptandPlayAction(_ sender: Any) {
        AcceptandPlay.select(animated: true)
        Scheduleleter.deselect(animated: true)
    }
    
    @IBAction func ScheduleleterAction(_ sender: Any) {
        Scheduleleter.select(animated: true)
        AcceptandPlay.deselect(animated: true)
        BackgroundView2.isHidden = false
        DateTimeSchedulerView.isHidden = false
    }
    
    
    func setHeader(){
        let urlstring =  UserDefaults.standard.value(forKey: "UserCoverImage") as! String
        let url1 = URL(string:urlstring)
        self.CoverImage?.kf.setImage(with: url1,
                                     placeholder:UIImage(named: "img"),
                                     options: [.transition(.fade(1))],
                                     progressBlock: nil,
                                     completionHandler: nil)
        
        let ProfileUrl = URL(string:UserDefaults.standard.value(forKey: "UserProfileImage") as! String)
        self.ProfileImage?.kf.setImage(with: ProfileUrl,
                                       placeholder:UIImage(named: "img"),
                                       options: [.transition(.fade(1))],
                                       progressBlock: nil,
                                       completionHandler: nil)
        
        UserLabel.text = UserDefaults.standard.value(forKey: "username") as! String
        let credit = UserDefaults.standard.value(forKey: "UserCredit") as! String
        UserCreditLabel.text = "CURRENT BALANCE:₹\(10*Int(credit)!) (\(credit) IGL COINS)"
    }
    
    
    @IBAction func OpenCameraForProfile(_ sender: Any) {
        ForGalleryCamera()
        
    }
    
    var  fromBanner = ""
    @IBAction func OpenCameraForCover(_ sender: Any) {
        ForGalleryCamera()
        fromBanner = "Banner"
        
    }
    
    @IBAction func OpenDatePickerAction(_ sender: Any) {
        DatePicker.minimumDate = Date()
        DatePickerView.isHidden = false
    }
    
    @IBAction func OpenTimePickerAction(_ sender: Any) {
        TimePickerView.isHidden = false
    }
    
    @IBAction func CancelDatePickerAction(_ sender: Any) {
        
        DatePickerView.isHidden = true
    }
    
    @IBAction func DoneDatePickerAction(_ sender: Any) {
        
        dateformatter.dateFormat = "yyyy-MM-dd"
        self.laterdate = dateformatter.string(from: DatePicker.date)
        dateformatter.dateFormat = "yyyy-MM-dd"
        SelectedDateLabel.text! = dateformatter.string(from: DatePicker.date)
        DatePickerView.isHidden = true
    }
    
    @IBAction func CancelTimePickerAction(_ sender: Any) {
        TimePickerView.isHidden = true
    }
    
    
    @IBAction func DoneTimePickerAction(_ sender: Any) {
        dateformatter.dateFormat = "hh:mm:ss a"
        self.laterTime = dateformatter.string(from: TimePicker.date)
        dateformatter.dateFormat = "hh:mm a"
        SelectedTimeLabel.text! = dateformatter.string(from: TimePicker.date)
        TimePickerView.isHidden = true
    }
    
    
    
    @IBAction func HideScheduleViewAction(_ sender: Any) {
        DateTimeSchedulerView.isHidden = true
        BackgroundView2.isHidden = true
        AcceptandPlay.select(animated: true)
        Scheduleleter.deselect(animated: true)
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
                WebHelper.requestPostUrlWithImage(strURL: GlobalConstant.update_coverpic, Dictionary: DicInput, AndImage: self.CoverImage.image!, forImageParameterName: "UserCoverImage", Success: {success in
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
    
    @IBOutlet weak var ChallengeMadeActions: UIView!
    
    
    @IBAction func ChallengeMadeAction(_ sender: UIButton){
        ChallengesCollectionView.isHidden = true
        ChallengesMadeCollectionView.isHidden = false
        challengeReceivedbtn.backgroundColor = #colorLiteral(red: 0.1098039216, green: 0.2549019608, blue: 0.4196078431, alpha: 1)
        ChallengeMadebtn.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.5254901961, blue: 0.8, alpha: 1)
        ChallengesCollectionView.reloadData()
        challengesTypeLabel.text = "CHALLENGES MADE"
         ChallengeMade()
    //    self.MainHeightofView.constant = //CGFloat((self.ChallengeMadeArray.count*155)+400)
    }
    
    @IBAction func ChallengeReceivedAction(_ sender: Any) {
        ChallengesCollectionView.isHidden = false
        ChallengesMadeCollectionView.isHidden = true
        challengeReceivedbtn.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.5254901961, blue: 0.8, alpha: 1)
        ChallengeMadebtn.backgroundColor =   #colorLiteral(red: 0.1098039216, green: 0.2549019608, blue: 0.4196078431, alpha: 1)
        challengesTypeLabel.text = "CHALLENGES RECEIVED"
        ChallengesMadeCollectionView.reloadData()
         ChallengeRecivedByUser()
       // self.MainHeightofView.constant = CGFloat((self.ChallengeReceivedArray.count*135)+400)
        
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == ChallengesCollectionView
        {
            if self.ChallengeReceivedArray.count % 2 == 0
            {
                self.MainHeightofView.constant = CGFloat((self.ChallengeReceivedArray.count / 2 * 280) + 490)
            }
            else{
                self.MainHeightofView.constant = CGFloat(((self.ChallengeReceivedArray.count + 1 ) / 2 * 280 ) + 490)
            }
            return ChallengeReceivedArray.count
        }
        else if collectionView == ChallengesMadeCollectionView
        {
            if self.ChallengeMadeArray.count % 2 == 0
            {
                self.MainHeightofView.constant = CGFloat((self.ChallengeMadeArray.count / 2 * 330) + 490)
            }
            else{
                 self.MainHeightofView.constant = CGFloat(((self.ChallengeMadeArray.count + 1 ) / 2 * 330 ) + 490)
            }
           
            return ChallengeMadeArray.count
        }
        else
        {
            return 1
        }
    }
    
    
      //================== Start of Received..... ==============
    @IBAction func receivedCellAcceptButton(_ sender: AnyObject) {
        BackgroundView.isHidden = false
        AcceptView.isHidden = false
        AcceptandPlay.select(animated: true)
        Scheduleleter.deselect(animated: true)
        let obj =  ChallengeReceivedArray[sender.tag] as! NSDictionary
        self.challenge_id = Global.getStringValue(obj.value(forKey: "ChallengeID") as AnyObject)
        print("self.challenge_id::::::::::::::::::",self.challenge_id)
    }
    
    @IBAction func RejectAction(_ sender: AnyObject)
    {
        self.challenge_status = "0"
        let obj = ChallengeReceivedArray[sender.tag!] as! NSDictionary
        self.challenge_id = obj.value(forKey: "ChallengeID") as! String
        Updatechallenge()
    }
    
    @IBAction func GotoParticipentFromReceved(_ sender: AnyObject) {
         let obj = ChallengeReceivedArray[sender.tag!] as!NSDictionary
        let ChallengeStatus = Global.getStringValue(obj.value(forKey: "ChallengeStatus") as AnyObject)
     //   let ChallengeStatusText = Global.getStringValue(obj.value(forKey: "ChallengeStatusText") as AnyObject)

        if ChallengeStatus == "2"{
            let storyobj = UIStoryboard(name: "Main", bundle: nil)
            let vcobj =  storyobj.instantiateViewController(withIdentifier: "ChallengeDualVC") as! ChallengeDualVC
            vcobj.challenge_id = Global.getStringValue(obj.value(forKey: "ChallengeID") as AnyObject)
            self.navigationController?.pushViewController(vcobj, animated: true)
        }
        else  if ChallengeStatus == "3"{
            // if Later date is matched with present date and time then  it will be Play Now
        }
      
    }
    
    @IBAction func acceptLossAction(_ sender: UIButton) {
        let obj = ChallengeReceivedArray[sender.tag] as! NSDictionary
        self.challenge_id = obj.value(forKey: "ChallengeID") as! String
        AcceptLossCall()
    }
    
    
    @IBAction func raiseDisputeAction(_ sender: UIButton){
        let storyObj = UIStoryboard(name: "Main", bundle: nil)
        let obj = storyObj.instantiateViewController(withIdentifier: "ProfileOrLossViewController") as! ProfileOrLossViewController
        obj.Iscoming_From_Recive = true
        let obj1 = ChallengeReceivedArray[sender.tag] as! NSDictionary
        self.challenge_id = obj1.value(forKey: "ChallengeID") as! String
        obj.challenge_id = self.challenge_id
        obj.type = "0"
        self.navigationController?.pushViewController(obj, animated: true)
        
    }
    //================== End of Received..... ==============
    
    @IBAction func PlaynowAcceptActin(_ sender: AnyObject) {
        self.challenge_status = "2"
        let obj = ChallengeReceivedArray[sender.tag!] as! NSDictionary
        // self.challenge_id = obj.value(forKey: "ChallengeID") as! String
        print("Challenge id is--------------------------",self.challenge_id)
        Updatechallenge()
    }
    
    
    @IBAction func AccepAndScheduleLater(_ sender: AnyObject) {
        if SelectedTimeLabel.text! == "Choose Time" || SelectedDateLabel.text! == "Choose Date"
        {
            Global.showAlertMessageWithOkButtonAndTitle("", andMessage: "Please select a date and time")
            return
        }
        self.challenge_status = "3"
        let obj = ChallengeReceivedArray[sender.tag!] as! NSDictionary
        Updatechallenge()
    }
    
    

@IBAction func ChallengeMadeAcceptAction(_ sender: AnyObject) {
       // self.challenge_status = "2"
        let obj = ChallengeMadeArray[sender.tag!] as! NSDictionary
        self.challenge_id = obj.value(forKey: "ChallengeID") as! String
          AcceptLossCall()
       // Updatechallenge()
    }
    
    @IBAction func ChallengeMadeRejectAction(_ sender: AnyObject) {
        let storyObj = UIStoryboard(name: "Main", bundle: nil)
        let obj = storyObj.instantiateViewController(withIdentifier: "ProfileOrLossViewController") as! ProfileOrLossViewController
        obj.Iscoming_From_Recive = true
        let obj1 = ChallengeMadeArray[sender.tag] as! NSDictionary
        self.challenge_id = obj1.value(forKey: "ChallengeID") as! String
        obj.challenge_id = self.challenge_id
        obj.type = "0"
        self.navigationController?.pushViewController(obj, animated: true)
    
}
    
override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        super.touchesBegan(touches, with: event)
        let touch: UITouch = touches.first!
        if touch.view != AcceptView && touch.view != DateTimeSchedulerView
        {
            
            BackgroundView.isHidden = true
            BackgroundView2.isHidden = true
            AcceptView.isHidden = true
            self.DateTimeSchedulerView.isHidden = true
            DatePickerView.isHidden = true
            TimePickerView.isHidden = true
            
        }
    }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == ChallengesCollectionView
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChallengesReceivedCel", for: indexPath) as! ChallengesReceivedCel
            cell.AcceptButton.layer.cornerRadius = 13
            cell.RejectButton.layer.cornerRadius = 13
            cell.acceptLossButton.layer.cornerRadius = 13
            cell.raiseDisputeButton.layer.cornerRadius = 13
            cell.hallengestatusButton.layer.cornerRadius = 13
            cell.AcceptButton.tag = indexPath.row
            cell.RejectButton.tag =  indexPath.row
            cell.acceptLossButton.tag = indexPath.row
            cell.raiseDisputeButton.tag =  indexPath.row
            cell.hallengestatusButton.tag = indexPath.row
           // acceptLossButton: UIButton!
         //   @IBOutlet weak var raiseDisputeButton
            cell.laterView.isHidden = true // schedule Later View
            cell.acceptRejectView.isHidden = true
            cell.ChallengestatusView.isHidden = true
            cell.lossDisputeView.isHidden = true
            if self.ChallengeReceivedArray.count%2 == 0{
            self.MainHeightofView.constant = CGFloat(((self.ChallengeReceivedArray.count)/2*290)+440)
            }else{
                 self.MainHeightofView.constant = CGFloat(((self.ChallengeReceivedArray.count+1)/2*290)+440)
            }
            
            let obj = ChallengeReceivedArray[indexPath.row] as! NSDictionary
            cell.GametitleLabel.text = Global.getStringValue(obj.value(forKey: "ChallengeTitle") as AnyObject)
            cell.challengerLabel.text = Global.getStringValue(obj.value(forKey: "Challenger") as AnyObject) //obj.value(forKey: "Challenger") as! String
            cell.DateLabel.text = Global.getStringValue(obj.value(forKey: "ChallengeDate") as AnyObject) //obj.value(forKey: "ChallengeDate") as! String
            cell.IGLcoinLabel.text = Global.getStringValue(obj.value(forKey: "ChallengeAmount") as AnyObject) // obj.value(forKey: "ChallengeAmount") as! String
            let ProfileUrl = URL(string:Global.getStringValue(obj.value(forKey: "ChallengeImagePath") as AnyObject))
             cell.Imageview.clipsToBounds = true
            cell.Imageview?.kf.setImage(with: ProfileUrl,
                                        placeholder:UIImage(named: "placeholder"),
                                        options: [.transition(.fade(1))],
                                        progressBlock: nil,
                                        completionHandler: nil)
            let ChallengeStatusText = Global.getStringValue(obj.value(forKey: "ChallengeStatusText") as AnyObject)
            let ShowButton = String(describing: obj.value(forKey: "ShowButton")!)
            let ChallengeStatus = String(describing: obj.value(forKey: "ChallengeStatus")!)
               print("challenges status of the challenges is ",ChallengeStatus)
            let ChallengeWinLose = obj.value(forKey: "ChallengeWinLose") as! String
            print("win or loss",ChallengeStatus,ChallengeWinLose,ChallengeStatusText)
            if ChallengeWinLose != ""{
                if ChallengeWinLose == "Lost"{
                    cell.StatusLabel.text = "Status :"+ChallengeWinLose
                   
                }else if ChallengeWinLose == "Won"{
                    cell.StatusLabel.text = "Status :"+ChallengeWinLose
                   
                }else{
                    cell.StatusLabel.text = "Status :"+ChallengeWinLose
                   
                }
               
                }else{
           if ChallengeStatus == "0"
             {
                print("ChallengeStatus == 0")
                cell.hallengestatusButton.isHidden = true
                cell.StatusLabel.text = "Status: " + ChallengeStatusText
                // cell.hallengestatusButton.setTitle(ChallengeStatusText, for: .normal)
             }
            else if ChallengeStatus == "1"
            {
                if ShowButton == "1"
                {
                     cell.acceptRejectView.isHidden = false
            }
               
            }
            else if ChallengeStatus == "2"
            {
                 cell.ChallengestatusView.isHidden = false
                 cell.hallengestatusButton.setTitle(ChallengeStatusText, for: .normal)
                 cell.StatusLabel.text = "Status: "+ChallengeStatusText
                 print("statu s2 is here guys")
            }
            else if ChallengeStatus == "3"
            {
                cell.StatusLabel.text =  "Status: "+ChallengeStatusText
                cell.laterView.isHidden = false
                let date =  Global.getStringValue(obj.value(forKey: "LaterDate") as AnyObject)
                print("priont of the date date date",date)
                cell.LatterDateLabel.text = "Later Date : \(date)"
                let time = Global.getStringValue(obj.value(forKey: "ChallengeLaterTime") as AnyObject)
                cell.TimeLabel.text = "Time : \(time)"
            }
            else if ChallengeStatus == "4"
            {
                print("ChallengeStatus, ChallengeWinLoseStatus ",ChallengeStatus)
                let ChallengeWinLoseStatus = String(describing: obj.value(forKey: "ChallengeWinLoseStatus")!)
                   print("ChallengeStatus, ChallengeWinLoseStatus ",ChallengeStatus,ChallengeWinLoseStatus)
                if ChallengeWinLoseStatus == "2"
                {
                    cell.ChallengestatusView.isHidden = false
                    cell.hallengestatusButton.setTitle("Pending", for: .normal)
                }
                else if ChallengeWinLoseStatus == "1"
                {
                    if (UserDefaults.standard.value(forKey: "user_id") as! String) == (Global.getStringValue(obj.value(forKey: "ChallengeResSubBy") as AnyObject)){
                         cell.lossDisputeView.isHidden = true
                    }else{
                         cell.lossDisputeView.isHidden = false
                    }
                   cell.StatusLabel.text = "Status: "+ChallengeStatusText
                    }else if ChallengeWinLoseStatus == "3"{//ChallengeWinLoseStatus
                  cell.lossDisputeView.isHidden = true
                  cell.ChallengestatusView.isHidden = true
                  //cell.hallengestatusButton.setTitle(ChallengeStatusText, for: .normal)
                  cell.StatusLabel.text = "Status: "+ChallengeStatusText
                    
                }
               
            }
            else if ChallengeStatus == "5"
            {
                cell.ChallengestatusView.isHidden = true
                cell.StatusLabel.text! = "Status: " + ChallengeStatusText
           }
            }
            return cell
        }
        else if collectionView == ChallengesMadeCollectionView  // Challenge Made....
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChallengeMadeCell", for: indexPath) as! ChallengeMadeCell
            cell.SendMessage.layer.cornerRadius = 12
            cell.RejectButton.layer.cornerRadius = 10
            cell.AcceptButton.layer.cornerRadius = 10
            cell.scheduleAcceptButton.layer.cornerRadius = 10
            cell.ScheduleRejectButton.layer.cornerRadius = 10
            cell.RejectButton.tag =  indexPath.row
            cell.AcceptButton.tag =  indexPath.row
            cell.SendMessage.tag = indexPath.row
            let obj = ChallengeMadeArray[indexPath.row] as!NSDictionary
            
            if self.ChallengeReceivedArray.count%2 == 0{
                self.MainHeightofView.constant = CGFloat(((self.ChallengeMadeArray.count)/2*330)+440)
            }else{
                self.MainHeightofView.constant = CGFloat(((self.ChallengeMadeArray.count+1)/2*330)+440)
            }
            
            cell.GameTitlelabel.text = obj.value(forKey: "ChallengeTitle") as! String
            cell.DateLabel.text = obj.value(forKey: "ChallengeDate") as! String
            cell.IGLcoinLabel.text = obj.value(forKey: "ChallengeAmount") as! String
            cell.ChallengedLabel.text = obj.value(forKey: "Challenger") as! String
            let ProfileUrl = URL(string:obj.value(forKey: "ChallengeImagePath") as! String)
            cell.Imageview.clipsToBounds = true
            cell.Imageview?.kf.setImage(with: ProfileUrl,
                                        placeholder:UIImage(named: "placeholder"),
                                        options: [.transition(.fade(1))],
                                        progressBlock: nil,
                                        completionHandler: nil)
            let showbutton = String(describing: obj.value(forKey: "ShowButton")!)
            cell.scheduleAcceptButton.tag = indexPath.row
            cell.ScheduleRejectButton.tag = indexPath.row
            let ChallengeStatusText = obj.value(forKey: "ChallengeStatusText") as? String
             cell.PendingLabel.text = ChallengeStatusText
            let chalnegesStatus = String(describing: obj.value(forKey: "ChallengeStatus")!)
            let ChallengeWinLose = obj.value(forKey: "ChallengeWinLose") as? String
            if ChallengeWinLose != ""{
                if ChallengeWinLose == "Lost"{
                  cell.winorLossLAbel.text = ChallengeWinLose
                    cell.winorLossLAbel.textColor = UIColor.red
                }else if ChallengeWinLose == "Won"{//ChallengeWinLose = Dispute;
                      cell.winorLossLAbel.text = ChallengeWinLose
                      cell.winorLossLAbel.textColor = UIColor.green
                }else {
                    let ChallengeWinLoseStatus = String(describing: obj.value(forKey: "ChallengeWinLoseStatus")!)
                    cell.PendingLabel.text = ChallengeWinLose
                    }
                 cell.WinOrLOSSView.isHidden = false
                 cell.AcceptAndRejectView.isHidden = true
                 cell.SendMessage.isHidden = true
                 cell.ScheduleLaterUIView.isHidden = true
            }else{
                   cell.WinOrLOSSView.isHidden = true
             let ChallengeWinLoseStatus = String(describing: obj.value(forKey: "ChallengeWinLoseStatus")!)
            if chalnegesStatus == "1"{
                cell.SendMessage.isHidden = false
                cell.SendMessage.setTitle("Cancel", for: UIControlState.normal)
                cell.AcceptAndRejectView.isHidden = true
                cell.ScheduleLaterUIView.isHidden = true
            }else if chalnegesStatus == "2"{
                 cell.SendMessage.isHidden = false
                 cell.ScheduleLaterUIView.isHidden = true
                 cell.SendMessage.setTitle(ChallengeStatusText, for: UIControlState.normal)
                 cell.AcceptAndRejectView.isHidden = true
            }else if chalnegesStatus == "3"{//need to check adte n time n show plya now if condition true
                  cell.SendMessage.isHidden = true
                  cell.PendingLabel.text = "Schedule Later"
                 cell.AcceptAndRejectView.isHidden = true
                 cell.ScheduleLaterUIView.isHidden = false
                //   ChallengeLaterTime = "05:30 AM";
                // LaterDate = "Apr 2nd, 2019";
               cell.ScheduleLaterLabelDAte.text! = Global.getStringValue(obj.value(forKey: "LaterDate") as AnyObject)
                cell.ScheduleLaterTimeLabel.text = Global.getStringValue(obj.value(forKey: "ChallengeLaterTime") as AnyObject)
            }else if chalnegesStatus == "4" && ChallengeWinLoseStatus == "1"{
                if (UserDefaults.standard.value(forKey: "user_id") as! String) == (Global.getStringValue(obj.value(forKey: "ChallengeResSubBy") as AnyObject)){
                    cell.SendMessage.isHidden = true
                    cell.ScheduleLaterUIView.isHidden = true
                    cell.PendingLabel.text = ChallengeStatusText
                    cell.AcceptAndRejectView.isHidden = true
                    print("user_id is equal")
                }else{
                    cell.SendMessage.isHidden = true
                    cell.ScheduleLaterUIView.isHidden = true
                    cell.PendingLabel.text = ChallengeStatusText
                    cell.AcceptAndRejectView.isHidden = false
                     print("user_id is not equal")
                }
                print("this is for checking to know the this for dispute aur accept ",ChallengeStatusText,chalnegesStatus,ChallengeWinLoseStatus )
            }else if chalnegesStatus == "4" && ChallengeWinLoseStatus == "2"{
                 cell.PendingLabel.text = ChallengeStatusText
                 cell.SendMessage.isHidden = true
                 cell.ScheduleLaterUIView.isHidden = true
                 cell.AcceptAndRejectView.isHidden = false
            }else if chalnegesStatus == "4" && ChallengeWinLoseStatus == "3"{//ChallengeWinLoseStatus
                cell.SendMessage.isHidden = true
                cell.ScheduleLaterUIView.isHidden = true
                cell.PendingLabel.text = ChallengeStatusText
                cell.AcceptAndRejectView.isHidden = true
                print("status of the challenge is that which coming ",chalnegesStatus,ChallengeWinLoseStatus)
                } else if chalnegesStatus == "5"{
                cell.ScheduleLaterUIView.isHidden = true
                cell.PendingLabel.text = "Cancelled"
                cell.SendMessage.isHidden = true
                cell.AcceptAndRejectView.isHidden = true
            }else if chalnegesStatus == "0"{
                cell.ScheduleLaterUIView.isHidden = true
                cell.SendMessage.isHidden = true
                cell.AcceptAndRejectView.isHidden = true
                cell.PendingLabel.text = "Rejected"
            }
            }
            return cell
        }
        else{
            return UICollectionViewCell()
        }
    }
 
    
    @IBAction func ScheduleAcceptAction(_ sender: UIButton) {
        let obj = ChallengeMadeArray[sender.tag] as! NSDictionary
        self.challenge_id = obj.value(forKey: "ChallengeID") as! String
        self.laterdate = obj.value(forKey: "LaterDate") as! String
        self.laterTime = obj.value(forKey: "ChallengeLaterTime") as! String
        self.challenge_status = "2"//this is for schedule leter challenges to accept that time to play
         Updatechallenge()
    }
    
    
    @IBAction func ScheduleLeterRejectAction(_ sender: UIButton) {
        let obj = ChallengeMadeArray[sender.tag] as! NSDictionary
        self.challenge_id = obj.value(forKey: "ChallengeID") as! String
        self.laterdate = obj.value(forKey: "LaterDate") as! String
        self.laterTime = obj.value(forKey: "ChallengeLaterTime") as! String
        self.challenge_status = "0"//this is for schedule leter challenges to reject that time to play
        Updatechallenge()
    }
    
    
    
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    var isComingFromWinnerViewController = false
    
    
    @IBAction func BackAction(_sender:Any)
    {
       if self.isComingFromWinnerViewController{
        let StoryObj = UIStoryboard(name: "Main", bundle: nil)
        let vcobj = StoryObj.instantiateViewController(withIdentifier: "LandingProfileViewController") as! LandingProfileViewController
        self.isComingFromWinnerViewController = false
        self.navigationController?.pushViewController(vcobj, animated: true)
        }
        else
        {
            if iscoming_fromResult == true{
                let StoryObj = UIStoryboard(name: "Main", bundle: nil)
                let vcobj = StoryObj.instantiateViewController(withIdentifier: "LandingProfileViewController") as! LandingProfileViewController
                self.navigationController?.pushViewController(vcobj, animated: true)
            }else{
               self.navigationController?.popViewController(animated: true)
            }
       }
   }
    

    @IBAction func GotoParticipentScreen(_ sender: AnyObject) {
        if (sender as! UIButton).titleLabel?.text! == "Cancel"{
            let obj = ChallengeMadeArray[sender.tag!] as! NSDictionary
            self.challenge_id = obj.value(forKey: "ChallengeID") as! String
            self.challenge_status = "5"
              Updatechallenge()
        }else if (sender as! UIButton).titleLabel?.text! == "Play Now"{
           self.challenge_status = "2"
          // Updatechallenge()
            let storyobj = UIStoryboard(name: "Main", bundle: nil)
            let vcobj =  storyobj.instantiateViewController(withIdentifier: "ChallengeDualVC") as! ChallengeDualVC
            let obj = ChallengeMadeArray[sender.tag!] as!NSDictionary
            vcobj.challenge_id = obj.value(forKey: "ChallengeID") as! String
            self.navigationController?.pushViewController(vcobj, animated: true)
        }
        
    }
    
    
    @IBAction func GoToNotification(_ sender: UIBarButtonItem) {
        
        let storyObj = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyObj.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func ChallengeMade() {
        var DicInput = [String:AnyObject]()
        DicInput = ["user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject]
        WebHelper.requestPostUrl(strURL: GlobalConstant.challenge_made, Dictionary: DicInput, Success: {success in
            let status = success.object(forKey: "status") as! String
            if status == "1"{
                self.ChallengeMadeArray = []
                self.ChallengeMadeArray = success.object(forKey: "ChallengeList") as! NSArray
               
                print("Challenge Made ChallengeMade",success,":End Success:::::::::::")
                self.ChallengesMadeCollectionView.reloadData()
            }
            else if status == "0"{
                
            }
        }, Failure: {failler in
            Global.showAlertMessageWithOkButtonAndTitle("", andMessage:failler.localizedDescription)
        })
    }
    
    
    func ChallengeRecivedByUser()  {
        var DicInput = [String:AnyObject]()
        DicInput = ["user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject]
        WebHelper.requestPostUrl(strURL: GlobalConstant.challenge_recieved, Dictionary: DicInput, Success: {
            success in
            let status = success.object(forKey: "status") as! String
            if status == "1"{
                print("ChallengeRecivedByUser",success,":End Success:::::::::: ")
                self.ChallengeReceivedArray = []
                self.ChallengeReceivedArray = success.object(forKey: "TeamList") as! NSArray
                //self.MainHeightofView.constant = CGFloat((self.ChallengeReceivedArray.count*145)+400)
                self.ChallengesCollectionView.reloadData()
            }
            else if status == "0"{
                Global.showAlertMessageWithOkButtonAndTitle("", andMessage: success.value(forKey: "msg") as! String)
            }
        }, Failure: {failer in
            // Global.showAlertMessageWithOkButtonAndTitle("", andMessage: failler.)
        })
    }
    
}

extension ChallengeRMadeViewController{
    func Updatechallenge() {
        var Dicinput = [String:AnyObject]()
        Dicinput = ["challenge_id":self.challenge_id as AnyObject , "status": self.challenge_status as AnyObject , "laterdate": self.laterdate as AnyObject ,"latertime": self.laterTime as AnyObject]
        print("Dicinput",Dicinput)
        WebHelper.requestPostUrl(strURL: GlobalConstant.update_challenge, Dictionary: Dicinput, Success: {success in
            let status = success.value(forKey: "status") as! String
            if status == "1"{
                self.AcceptView.isHidden = true
                self.DateTimeSchedulerView.isHidden = true
                self.BackgroundView.isHidden = true
                self.BackgroundView2.isHidden = true
                // Global.showAlertMessageWithOkButtonAndTitle("", andMessage: success.value(forKey: "msg") as! String)
                self.ChallengeRecivedByUser()
                self.ChallengeMade()
                
            }
            else if status == "0"{
                Global.showAlertMessageWithOkButtonAndTitle("", andMessage: success.value(forKey: "msg") as! String)
            }
        }, Failure: {failler in
            Global.showAlertMessageWithOkButtonAndTitle("", andMessage: failler.localizedDescription)
        })
        
    }
    
    func AcceptLossCall() {
        var Dicinput = [String:AnyObject]()
        Dicinput = ["challenge_id":self.challenge_id as AnyObject , "user_id": UserDefaults.standard.value(forKey: "user_id") as AnyObject]
        WebHelper.requestPostUrl(strURL: GlobalConstant.acceptloss, Dictionary: Dicinput, Success: {success in
            let status  = String(describing: success.value(forKey: "status")!)
            if status == "1"{
               self.ChallengeMade()
            }else if status == "0"{
              print("Something went wrong??????")
            }
        }, Failure: {Failler in
            print("Something went wrong??????",Failler.localizedDescription)
        })
       //acceptloss
        //challenge_id: id of challenge to be updated
        //user_id : logged in user id
    }
}
