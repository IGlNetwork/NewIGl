//
//  NotificationViewController.swift
//  IGL
//
//  Created by baps on 07/10/18.
//  Copyright © 2018 Mac Min. All rights reserved.
//

import UIKit

class NotificationData
{
    var NotificationCreatedAt = ""
    var NotificationDescription = ""
    var NotificationID = ""
    var NotificationNotificationID = ""
    var NotificationStatus = ""
    var NotificationType = ""
    var UserProfileImage = ""
    var userid = ""
    var username = ""
    var isChecked = false
    
}




class NotificationCell: UITableViewCell {
    @IBOutlet weak var NotiImageview:UIImageView!
    @IBOutlet weak var NotiTitle:UILabel!
    @IBOutlet weak var NotiDesLabel:UILabel!
    @IBOutlet weak var DateLabel:UILabel!
    @IBOutlet weak var SelectButton:UIButton!
     @IBOutlet weak var checkButton:UIButton!
}


class NotificationViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIScrollViewDelegate {

    @IBOutlet weak var notificationTableview:UITableView!
    @IBOutlet weak var ChooseDateView:UIView!
    @IBOutlet weak var TAkeActionView:UIView!
    @IBOutlet weak var BGView: UIView!
    @IBOutlet weak var datePickerView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var chooseDateTextField: UITextField!
    
    @IBOutlet weak var NotificationView: UIView!
    @IBOutlet weak var actionTextField: UITextField!
  
    @IBOutlet weak var checkAllButton: UIButton!
    
    var isMoreDataLoading = false
    var loadingMoreView:InfiniteScrollActivityView?
    
    var pageNumber = 0
    var notificationArray  = [NotificationData]()
    
    
    
    var action = ""
    let dateFormatter = DateFormatter()
    var filterDate = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getNotifications()
        self.notificationTableview.separatorStyle = .none
        NotificationView.isHidden = true
        self.BGView.isHidden = true
        self.datePickerView.isHidden = true
        self.chooseDateTextField.delegate = self
        ChooseDateView.layer.cornerRadius = 12
        TAkeActionView.layer.cornerRadius = 12
        ChooseDateView.layer.borderWidth = 0.3
        ChooseDateView.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        TAkeActionView.layer.borderWidth = 0.3
        TAkeActionView.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        // Do any additional setup after loading the view.
        
        // Set up Infinite Scroll loading indicator
        let frame = CGRect(x: 0, y: notificationTableview.contentSize.height, width: notificationTableview.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
        loadingMoreView = InfiniteScrollActivityView(frame: frame)
        loadingMoreView!.isHidden = true
        notificationTableview.addSubview(loadingMoreView!)
        
        var insets = notificationTableview.contentInset
        insets.bottom += InfiniteScrollActivityView.defaultHeight
        notificationTableview.contentInset = insets
        
    }
    
    @IBAction func openDatePickerAction(_ sender: Any) {
        self.BGView.isHidden = false
        self.datePickerView.isHidden = false
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
            self.BGView.isHidden = false
            self.datePickerView.isHidden = false
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.notificationArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dict = self.notificationArray[indexPath.row]
        
        let cell = notificationTableview.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
        let url = URL(string:dict.UserProfileImage)
        cell.NotiImageview?.kf.setImage(with: url,
                                        placeholder:UIImage(named: "placeholderimg"),
                                        options: [.transition(.fade(1))],
                                        progressBlock: nil,
                                        completionHandler: nil)
        
        cell.NotiTitle.text! = dict.username
        cell.NotiDesLabel.text! = dict.NotificationDescription
        print("checking crashing point",dict.username,dict.NotificationDescription,dict.NotificationCreatedAt,dict.NotificationStatus)
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: dict.NotificationCreatedAt)
        cell.DateLabel.text! = self.getPastTime(for: date!)
        
        if dict.isChecked
        {
             cell.SelectButton.setImage(#imageLiteral(resourceName: "check-mark-black-outline"), for: .normal )
        }
        else
        {
            cell.SelectButton.setImage(UIImage(named: ""), for: .normal )
        }
        
        if dict.NotificationStatus == "1"
        {
            cell.contentView.backgroundColor = #colorLiteral(red: 0.07186446339, green: 0.1382079422, blue: 0.2462541461, alpha: 1)
          
        }
        else
        {
              cell.contentView.backgroundColor = UIColor.clear
            // cell.contentView.backgroundColor = #colorLiteral(red: 0.07186446339, green: 0.1382079422, blue: 0.2462541461, alpha: 1)
            // cell.contentView.alpha = 0.1666
        }
        
        
        Global.roundRadius(cell.NotiImageview)
        cell.selectionStyle = .none
        cell.SelectButton.tag = indexPath.row
        cell.checkButton.tag = indexPath.row
        return cell
    }
   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
           let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
          let dict = self.notificationArray[indexPath.row]
          let NotificationType = dict.NotificationType
        if NotificationType == "1"{//redirecting to Game details
            let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
            let vc : GameDetailsVC = mainStoryboard.instantiateViewController(withIdentifier: "GameDetailsVC")as! GameDetailsVC
            vc.game_id =  dict.NotificationNotificationID
            self.navigationController?.pushViewController(vc, animated: true)
        }else if NotificationType == "2"{//Tournament details
            let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
            let vc : TournamentDetailsVC = mainStoryboard.instantiateViewController(withIdentifier: "TournamentDetailsVC") as! TournamentDetailsVC
           vc.tournament_id =  dict.NotificationNotificationID
           self.navigationController?.pushViewController(vc, animated: true)
        }else if NotificationType == "3"{//Profile PersonalProfileViewController
            let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
            let vc : PersonalProfileViewController = mainStoryboard.instantiateViewController(withIdentifier: "PersonalProfileViewController") as! PersonalProfileViewController
            vc.otherUserId =  dict.NotificationNotificationID
            self.navigationController?.pushViewController(vc, animated: true)
        }else if NotificationType == "4"{//Profile
            let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
            let vc : PersonalProfileViewController = mainStoryboard.instantiateViewController(withIdentifier: "PersonalProfileViewController") as! PersonalProfileViewController
            vc.otherUserId =  dict.NotificationNotificationID
            self.navigationController?.pushViewController(vc, animated: true)
        }else if NotificationType == "5"{//Event Details
            let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
            let vc : EventDetailsVC = mainStoryboard.instantiateViewController(withIdentifier: "EventDetailsVC") as! EventDetailsVC
            vc.event_id = dict.NotificationNotificationID
            self.navigationController?.pushViewController(vc, animated: true)
        }else if NotificationType == "6"{//Profile
            let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
            let vc : PersonalProfileViewController = mainStoryboard.instantiateViewController(withIdentifier: "PersonalProfileViewController") as! PersonalProfileViewController
            vc.otherUserId =  dict.NotificationNotificationID
            self.navigationController?.pushViewController(vc, animated: true)
        }else if NotificationType == "7"{//Tournament Checkin teams
            let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
            let vc : CheckedInTeamViewController = mainStoryboard.instantiateViewController(withIdentifier: "CheckedInTeamViewController") as! CheckedInTeamViewController
            vc.Tournament_Id =  dict.NotificationNotificationID
            self.navigationController?.pushViewController(vc, animated: true)
        }else if NotificationType == "8"{//Tournament brackets
            let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
            let vc : TournamentDetaisBracketVC = mainStoryboard.instantiateViewController(withIdentifier: "TournamentDetaisBracketVC") as! TournamentDetaisBracketVC
            vc.tournament_id =  dict.NotificationNotificationID
            self.navigationController?.pushViewController(vc, animated: true)
        }else if NotificationType == "9"{//Tournament Checkin teams
            let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
            let vc : CheckedInTeamViewController = mainStoryboard.instantiateViewController(withIdentifier: "CheckedInTeamViewController") as! CheckedInTeamViewController
            vc.Tournament_Id =  dict.NotificationNotificationID
            self.navigationController?.pushViewController(vc, animated: true)
        }else if NotificationType == "10"{//Tournament details
            let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
            let vc : TournamentDetailsVC = mainStoryboard.instantiateViewController(withIdentifier: "TournamentDetailsVC") as! TournamentDetailsVC
            vc.tournament_id =  dict.NotificationNotificationID
            self.navigationController?.pushViewController(vc, animated: true)
        }else if NotificationType == "11"{//Tournament details
            let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
            let vc : TournamentDetailsVC = mainStoryboard.instantiateViewController(withIdentifier: "TournamentDetailsVC") as! TournamentDetailsVC
            vc.tournament_id =  dict.NotificationNotificationID
            self.navigationController?.pushViewController(vc, animated: true)
        }else if NotificationType == "12"{//Tournament details
            let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
            let vc : TournamentDetailsVC = mainStoryboard.instantiateViewController(withIdentifier: "TournamentDetailsVC") as! TournamentDetailsVC
            vc.tournament_id =  dict.NotificationNotificationID
            self.navigationController?.pushViewController(vc, animated: true)
        }else if NotificationType == "13"{//user challenges
        let vc : ChallengeRMadeViewController = mainStoryboard.instantiateViewController(withIdentifier: "ChallengeRMadeViewController")as! ChallengeRMadeViewController
        self.navigationController?.pushViewController(vc, animated: true)
        }else if NotificationType == "14"{//challenges
            let vc : ChallengeRMadeViewController = mainStoryboard.instantiateViewController(withIdentifier: "ChallengeRMadeViewController")as! ChallengeRMadeViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }else if NotificationType == "15"{//user challenge details
            let vc : ChallengeRMadeViewController = mainStoryboard.instantiateViewController(withIdentifier: "ChallengeRMadeViewController")as! ChallengeRMadeViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }else if NotificationType == "16"{//user challenges
            let vc : ChallengeRMadeViewController = mainStoryboard.instantiateViewController(withIdentifier: "ChallengeRMadeViewController")as! ChallengeRMadeViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }else if NotificationType == "17"{//user challenges
            let vc : ChallengeRMadeViewController = mainStoryboard.instantiateViewController(withIdentifier: "ChallengeRMadeViewController")as! ChallengeRMadeViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }else if NotificationType == "18"{//user challenges
            let vc : ChallengeRMadeViewController = mainStoryboard.instantiateViewController(withIdentifier: "ChallengeRMadeViewController")as! ChallengeRMadeViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }else if NotificationType == "19"{//user challenges
            let vc : ChallengeRMadeViewController = mainStoryboard.instantiateViewController(withIdentifier: "ChallengeRMadeViewController")as! ChallengeRMadeViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }else if NotificationType == "20"{//user challenges
            let vc : ChallengeRMadeViewController = mainStoryboard.instantiateViewController(withIdentifier: "ChallengeRMadeViewController")as! ChallengeRMadeViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }else if NotificationType == "21"{//battle royale list
            let vc : BattleRoyaleVC = mainStoryboard.instantiateViewController(withIdentifier: "BattleRoyaleVC")as! BattleRoyaleVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else if NotificationType == "22"{//battle royale list
            let vc : BattleRoyaleVC = mainStoryboard.instantiateViewController(withIdentifier: "BattleRoyaleVC")as! BattleRoyaleVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else if NotificationType == "23"{////battle royale list
            let vc : BattleRoyaleVC = mainStoryboard.instantiateViewController(withIdentifier: "BattleRoyaleVC")as! BattleRoyaleVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else if NotificationType == "24"{//user challenges
            let vc : ChallengeRMadeViewController = mainStoryboard.instantiateViewController(withIdentifier: "ChallengeRMadeViewController")as! ChallengeRMadeViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }else if NotificationType == "25"{//tournament details
            let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
            let vc : TournamentDetailsVC = mainStoryboard.instantiateViewController(withIdentifier: "TournamentDetailsVC") as! TournamentDetailsVC
            vc.tournament_id =  dict.NotificationNotificationID
            self.navigationController?.pushViewController(vc, animated: true)
        }else if NotificationType == "26"{//user challenges
            let vc : ChallengeRMadeViewController = mainStoryboard.instantiateViewController(withIdentifier: "ChallengeRMadeViewController")as! ChallengeRMadeViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }else if NotificationType == "28"{//trophies
            let vc : ProfileResultVC = mainStoryboard.instantiateViewController(withIdentifier: "ProfileResultVC")as! ProfileResultVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = notificationTableview.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - notificationTableview.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && notificationTableview.isDragging) {
                isMoreDataLoading = true
                
                // Update position of loadingMoreView, and start loading indicator
                // let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
                // loadingMoreView?.frame = frame
                loadingMoreView!.startAnimating()
                
                
                // ... Code to load more results ...
                self.loadMoreData()
            }
        }
    }
    
    
    func loadMoreData()
    {
       // Call API
        getMoreNotifications()
        
    }
    
    
    
    /*
     NotificationType=1 -Game details
     NotificationType=2 -Tournament details
     NotificationType=3 -Profile
     NotificationType=4 -Profile
     NotificationType=5 -Event Details
     NotificationType=6 -Profile
     NotificationType=7 -Tournament Checkin teams
     NotificationType=8 -Tournament brackets
     NotificationType=9 -Tournament Checkin teams
     NotificationType=10 -Tournament details
     NotificationType=11 -Tournament details
     NotificationType=12 -Tournament details
     NotificationType=13 -user challenges
     NotificationType=14 -challenges
     NotificationType=15 -user challenge details
     NotificationType=16 -user challenges
     NotificationType=17 -user challenge
     NotificationType=18 -user challenge
     NotificationType=19 -user challenge
     NotificationType=20 -user challenge
     NotificationType=21 -battle royale list
     NotificationType=22 -battle royale list
     NotificationType=23 -battle royale list
     NotificationType=24 -user challenges
     NotificationType=25 -tournament details
     NotificationType=26 -user challenges
     NotificationType=28 -trophies
     */
    
    var isCheckAll = false
    @IBAction func checkAllAction(_ sender: Any) {
        if isCheckAll
        {
            for i in 0..<self.notificationArray.count
            {
                let dict =  self.notificationArray[i]
                dict.isChecked = false
            }
            checkAllButton.setImage(UIImage(named: ""), for: .normal )
            self.notificationTableview.reloadData()
             self.isCheckAll = false
        }
        else
        {
            for i in 0..<self.notificationArray.count
            {
                let dict =  self.notificationArray[i]
                dict.isChecked = true
            }
            checkAllButton.setImage(#imageLiteral(resourceName: "check-mark-black-outline"), for: .normal )
            self.notificationTableview.reloadData()
            self.isCheckAll = true
        }
        
    }
    
    
    @IBAction func cellCheckAction(_ sender: AnyObject) {
         let dict = self.notificationArray[sender.tag]
        if dict.isChecked
        {
             dict.isChecked = false
        }
        else
        {
             dict.isChecked = true
        }
       
        self.notificationArray[sender.tag] = dict
        self.notificationTableview.reloadData()
    }
    
    
    @IBAction func cancelAction(_ sender: Any) {
        self.BGView.isHidden = true
        self.datePickerView.isHidden = true
        self.chooseDateTextField.resignFirstResponder()
    }
    
    @IBAction func datePickerOkAction(_ sender: Any) {
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.filterDate = dateFormatter.string(from: datePicker.date)
         dateFormatter.dateFormat = "E, dd-MM-yyyy"
        self.chooseDateTextField.text! = dateFormatter.string(from: datePicker.date)
        
        self.BGView.isHidden = true
        self.datePickerView.isHidden = true
        self.chooseDateTextField.resignFirstResponder()
        self.getNotifications()
    }
    
    
    var isOpen = false
    
    @IBAction func actionChooseAction(_ sender: UIButton) {
        print("Sender::::::",sender.isSelected)
        if isOpen
        {
            isOpen = false
            NotificationView.isHidden = true
        }
        else
        {
            isOpen = true
            NotificationView.isHidden = false
        }
        
    }
    
    
    @IBAction func readAction(_ sender: Any) {
        NotificationView.isHidden = true
        self.action = "2"
         isOpen = false
        
        readUnreadNotification()
        //self.actionTextField.resignFirstResponder()
    }
    
    @IBAction func unReadAction(_ sender: Any) {
        NotificationView.isHidden = true
          self.action = "1"
         isOpen = false
        readUnreadNotification()
      //  self.actionTextField.resignFirstResponder()
    }
    
    
    @IBAction func BackAction(_ sender: Any) {
//        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
//        let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"SW-Reaveal") as! SWRevealViewController
//        self.present(SwreavelObj, animated: true, completion: nil)
        // Please write here code for Login
        self.navigationController?.popViewController(animated: true)
    }
    
    func getNotifications() {
        var DicInput = [String:AnyObject]()
        DicInput = ["user_id": UserDefaults.standard.value(forKey: "user_id") as AnyObject,"date":self.filterDate as AnyObject,"PNO":"0" as AnyObject]
        WebHelper.requestPostUrl(strURL: GlobalConstant.get_notifications, Dictionary: DicInput, Success: {success in
            print("getNotifications:::::::::",success)
            let status = Global.getStringValue(success.object(forKey: "status") as AnyObject)
            if status == "1"{
                 self.notificationArray.removeAll()
                
                 let arr = success.value(forKey: "NotificationList") as! NSArray
                
                for i in 0..<arr.count
                {
                    let dict = arr[i] as! NSDictionary
                    
                    let obj = NotificationData()
                    obj.NotificationCreatedAt = Global.getStringValue(dict.value(forKey: "NotificationCreatedAt") as AnyObject)
                    
                     obj.NotificationDescription = Global.getStringValue(dict.value(forKey: "NotificationDescription") as AnyObject)
                     obj.NotificationID = Global.getStringValue(dict.value(forKey: "NotificationID") as AnyObject)
                     obj.NotificationNotificationID = Global.getStringValue(dict.value(forKey: "NotificationNotificationID") as AnyObject)
                     obj.NotificationStatus = Global.getStringValue(dict.value(forKey: "NotificationStatus") as AnyObject)
                     obj.NotificationType = Global.getStringValue(dict.value(forKey: "NotificationType") as AnyObject)
                     obj.UserProfileImage = Global.getStringValue(dict.value(forKey: "UserProfileImage") as AnyObject)
                     obj.userid = Global.getStringValue(dict.value(forKey: "userid") as AnyObject)
                     obj.username = Global.getStringValue(dict.value(forKey: "username") as AnyObject)
                    print("checking crashing point",obj.username,obj.NotificationDescription,obj.NotificationCreatedAt,obj.NotificationStatus)
                     obj.isChecked = false
                     self.notificationArray.append(obj)
                     print("count of the array is",self.notificationArray.count)
                }
               print("count of the array is",self.notificationArray.count)
                 self.notificationTableview.reloadData()
            }
            else if status == "0"{
                self.notificationArray.removeAll()
                self.notificationTableview.reloadData()
            }
        }, Failure: {failler in
           // Global.showAlertMessageWithOkButtonAndTitle("", andMessage:failler.localizedDescription)
        })
    }
    
    
    func getMoreNotifications() {
        
    self.pageNumber += 1
        
        var DicInput = [String:AnyObject]()
        DicInput = ["user_id": UserDefaults.standard.value(forKey: "user_id") as AnyObject,"date":self.filterDate as AnyObject,"PNO":self.pageNumber as AnyObject]
        WebHelper.requestPostUrl(strURL: GlobalConstant.get_notifications, Dictionary: DicInput, Success: {success in
            print("getMoreNotifications::::::\(DicInput):::",success,"End More Notification")
            let status = Global.getStringValue(success.object(forKey: "status") as AnyObject)
            if status == "1"{
                //self.notificationArray.removeAll()
                
                let arr = success.value(forKey: "NotificationList") as! NSArray
                
                for i in 0..<arr.count
                {
                    let dict = arr[i] as! NSDictionary
                    
                    let obj = NotificationData()
                    obj.NotificationCreatedAt = Global.getStringValue(dict.value(forKey: "NotificationCreatedAt") as AnyObject)
                    
                    obj.NotificationDescription = Global.getStringValue(dict.value(forKey: "NotificationDescription") as AnyObject)
                    obj.NotificationID = Global.getStringValue(dict.value(forKey: "NotificationID") as AnyObject)
                    obj.NotificationNotificationID = Global.getStringValue(dict.value(forKey: "NotificationNotificationID") as AnyObject)
                    obj.NotificationStatus = Global.getStringValue(dict.value(forKey: "NotificationStatus") as AnyObject)
                    obj.NotificationType = Global.getStringValue(dict.value(forKey: "NotificationType") as AnyObject)
                    obj.UserProfileImage = Global.getStringValue(dict.value(forKey: "UserProfileImage") as AnyObject)
                    obj.userid = Global.getStringValue(dict.value(forKey: "userid") as AnyObject)
                    obj.username = Global.getStringValue(dict.value(forKey: "username") as AnyObject)
                    print("checking crashing point",obj.username,obj.NotificationDescription,obj.NotificationCreatedAt,obj.NotificationStatus)
                    obj.isChecked = false
                    self.notificationArray.append(obj)
                    print("count of the array is",self.notificationArray.count)
                }
                print("count of the array is",self.notificationArray.count)
               // self.notificationTableview.reloadData()
                
                self.isMoreDataLoading = false
                
                self.notificationTableview.reloadData()
                // Stop the loading indicator
                self.loadingMoreView!.stopAnimating()
            }
            else if status == "0"{
               // self.notificationArray.removeAll()
                self.notificationTableview.reloadData()
            }
        }, Failure: {failler in
            // Global.showAlertMessageWithOkButtonAndTitle("", andMessage:failler.localizedDescription)
        })
    }
    
    
    
    
  //https://iglnetwork.com/beta/api-V1/readunread
    func readUnreadNotification() {
        var idArr = [[String:String]]()
        for i in 0..<self.notificationArray.count
        {
            let dict =  self.notificationArray[i]
            if dict.isChecked
            {
                idArr.append(["ID":dict.NotificationID])
            }
        }
        
        let JsonArr = idArr as! NSArray
        var DicInput = [String:AnyObject]()
        DicInput = ["user_id": UserDefaults.standard.value(forKey: "user_id") as AnyObject,"action":self.action as AnyObject,"notificationlist":JsonArr.toJSOnString() as AnyObject]
        print("input dictionary from the server is coming ????",DicInput)
        WebHelper.requestPostUrl(strURL: GlobalConstant.readunread, Dictionary: DicInput, Success: {success in
            print("readUnreadNotification::\(DicInput):::::::",success)
            let status = Global.getStringValue(success.object(forKey: "status") as AnyObject)
            if status == "1"{
                self.getNotifications()
                self.action = ""
            }
            else if status == "0"{
              
            }
        }, Failure: {failler in
            // Global.showAlertMessageWithOkButtonAndTitle("", andMessage:failler.localizedDescription)
        })
    }
    
    
    func getPastTime(for date : Date) -> String {
        
        var secondsAgo = Int(Date().timeIntervalSince(date))
        if secondsAgo < 0 {
            secondsAgo = secondsAgo * (-1)
        }
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        
        if secondsAgo < minute  {
            if secondsAgo < 2{
                return "just now"
            }else{
                return "\(secondsAgo) secs ago"
            }
        } else if secondsAgo < hour {
            let min = secondsAgo/minute
            if min == 1{
                return "\(min) min ago"
            }else{
                return "\(min) mins ago"
            }
        } else if secondsAgo < day {
            let hr = secondsAgo/hour
            if hr == 1{
                return "\(hr) hr ago"
            } else {
                return "\(hr) hrs ago"
            }
        } else if secondsAgo < week {
            let day = secondsAgo/day
            if day == 1{
                return "\(day) day ago"
            }else{
                return "\(day) days ago"
            }
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM dd, yyyy hh:mm a"
            formatter.locale = Locale(identifier: "en_US")
            let strDate: String = formatter.string(from: date)
            return strDate
        }
    }
    
    
    
}



extension UINavigationBar {
    func transparentNavigationBar() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
    }
}






