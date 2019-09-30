//
//  TournamentDetailsFeedVC.swift
//  IGL
//
//  Created by Mac Min on 02/10/18.
//  Copyright © 2018 Mac Min. All rights reserved.
//

import UIKit

class TDFeedCell: UITableViewCell
{
     @IBOutlet weak var CellImage: UIImageView!
     @IBOutlet weak var CellTitle: UILabel!
     @IBOutlet weak var CellDescriptions: UILabel!
}

class EligibleTeamCell3: UITableViewCell
{
    
    @IBOutlet weak var CellImageView: UIImageView!
    @IBOutlet weak var CellTeamNameLabel: UILabel!
    @IBOutlet weak var CellCardView: UIView!
    
}

class InEligibleTeamCell3: UITableViewCell
{
    @IBOutlet weak var CellImageView: UIImageView!
    @IBOutlet weak var CellTeamNameLabel: UILabel!
    @IBOutlet weak var CellCardView: UIView!
}





class TournamentDetailsFeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource
{

    @IBOutlet weak var TDTableView: UITableView!
    @IBOutlet weak var CoverImage: UIImageView!
    @IBOutlet weak var followLabel:UILabel!
    @IBOutlet weak var JoinNowLabel:UILabel!
    @IBOutlet weak var coverimageview: UIImageView!
    
    @IBOutlet weak var EligibleTeamTableView: UITableView!
    @IBOutlet weak var InEligibleTeamTableView: UITableView!
    @IBOutlet weak var BGView: UIView!
    @IBOutlet weak var ChoseTeamView: UIView!
    @IBOutlet weak var CreateTeamButton: UIButton!
    
    
    
    var tournament_id = ""
    var followStr = ""
    var joinNowStr = ""
    var Feedlist = [Any]()
    
    var OverViewArray = [OverViewTournament]()
    var TournamentGameID = ""
    var IneligibleTeam = [Any]()
    var EligibleTeam = [Any]()
    var StartDate = ""
    var team_id = "0"
    
    
    
//    let TitleArray = ["WINNER DECLEARED","WE HAVE THE FINALISTS","ROUND#3 RESULTS","ROUND#2 RESULTS","ROUND#1 RESULTS","BRACKETS DECLARED","TEAMS CHECKED-IN","DOTA 2 TOURNAMENT SCHEDULED"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        coverimageview.clipsToBounds = true
        self.tournamentfeeds()
        // Do any additional setup after loading the view.
       // ChoseTeamView.layer.cornerRadius = 10
       ChoseTeamView.isHidden = true
       BGView.isHidden = true
        CreateTeamButton.layer.cornerRadius = 22
        EligibleTeamTableView.separatorColor = UIColor.clear
        InEligibleTeamTableView.separatorColor = UIColor.clear
        self.Get_tournamentdetails()
      
    }

    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear Called.Start....")
        followLabel.text! = self.followStr
        JoinNowLabel.text! = self.joinNowStr
        print("viewWillAppear Called End.....")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
      
        if tableView == TDTableView
        {
              return Feedlist.count
        }
        else if tableView == EligibleTeamTableView
        {
            return EligibleTeam.count
        }
        else
        {
            return self.IneligibleTeam.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
       
        
        if tableView == TDTableView
        {
            let cell = TDTableView.dequeueReusableCell(withIdentifier: "TDFeedCell", for: indexPath) as! TDFeedCell
            cell.CellImage.layer.cornerRadius = cell.CellImage.bounds.width/2
            let dict = Feedlist[indexPath.row] as! NSDictionary
            cell.CellTitle.text = dict.value(forKey: "Title") as! String
            cell.CellDescriptions.text = dict.value(forKey: "TournamentFeedCreatedAt") as! String
            return cell
        }
        else if tableView == EligibleTeamTableView
        {
            let cell = EligibleTeamTableView.dequeueReusableCell(withIdentifier: "EligibleTeamCell3", for: indexPath) as! EligibleTeamCell3
            cell.CellCardView.layer.cornerRadius = 19
            cell.CellCardView.layer.borderWidth = 2
            cell.CellCardView.layer.borderColor = #colorLiteral(red: 0.2039215686, green: 0.5254901961, blue: 0.8, alpha: 1)
            cell.CellImageView.layer.cornerRadius = cell.CellImageView.frame.size.height / 2
            cell.CellImageView.clipsToBounds = true
            cell.CellImageView.layer.masksToBounds = true
            let dict = self.EligibleTeam[indexPath.row] as! NSDictionary
            cell.CellTeamNameLabel.text! = dict.value(forKey: "TeamName") as! String
            let url = URL(string:dict.value(forKey: "TeamImage") as! String)
            cell.CellImageView?.kf.setImage(with: url,
                                            placeholder:UIImage(named: "img"),
                                            options: [.transition(.fade(1))],
                                            progressBlock: nil,
                                            completionHandler: nil)
            cell.selectionStyle = .none
            return cell
        }
        else
        {
            let cell = InEligibleTeamTableView.dequeueReusableCell(withIdentifier: "InEligibleTeamCell3", for: indexPath) as! InEligibleTeamCell3
            cell.CellCardView.layer.cornerRadius = 19
            cell.CellCardView.layer.borderWidth = 2
            cell.CellCardView.layer.borderColor = #colorLiteral(red: 0.2039215686, green: 0.5254901961, blue: 0.8, alpha: 1)
            cell.CellImageView.layer.cornerRadius = cell.CellImageView.frame.size.height / 2
            cell.CellImageView.clipsToBounds = true
            cell.CellImageView.layer.masksToBounds = true
            cell.selectionStyle = .none
            let dict = self.IneligibleTeam[indexPath.row] as! NSDictionary
            cell.CellTeamNameLabel.text! = dict.value(forKey: "TeamName") as! String
            let url = URL(string:dict.value(forKey: "TeamImage") as! String)
            cell.CellImageView?.kf.setImage(with: url,
                                            placeholder:UIImage(named: "img"),
                                            options: [.transition(.fade(1))],
                                            progressBlock: nil,
                                            completionHandler: nil)
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if tableView == TDTableView
        {
            return 70
        }
        else if tableView == EligibleTeamTableView
        {
            return 62
        }
        else
        {
            return 62
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    @IBAction func BackAction(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func FollowAction(_ sender:Any)
    {
       follow_tournament()
    }
    
    @IBAction func JoinAction(_ sender:Any)
    {
        // self.join_tournament()
        if self.JoinNowLabel.text == "CHECK-IN"
        {
            checkin_tournament()
        }
        else if self.JoinNowLabel.text == "JOIN NOW!" || self.JoinNowLabel.text == "JOIN NOW" || self.JoinNowLabel.text == "Join NOW !"
        {
            ChoseTeamView.isHidden = false
            BGView.isHidden = false
        }
        else if self.JoinNowLabel.text == "SUBMIT RESULT"
        {
            print("SUBMIT RESULT Called..............")
            let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboardobj.instantiateViewController(withIdentifier:"TournamentSubmitResultVC") as! TournamentSubmitResultVC
            vc.tournament_id = self.tournament_id
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    @IBAction func BackRoundButtonAction(_ sender: Any) {
    }
    
    @IBAction func CloseChooseTeamViewAction(_ sender: Any) {
        ChoseTeamView.isHidden = true
        BGView.isHidden = true
    }
    
    @IBAction func CreateTeamAction(_ sender: Any) {
        let StoryBoardObj = UIStoryboard(name: "Main", bundle: nil)
        let vc = StoryBoardObj.instantiateViewController(withIdentifier: "ProfileCreateTeamVC") as! ProfileCreateTeamVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func ShareAction(_ sender: Any) {
        let text = "http://iglnetwork.com/beta/tournaments/details/\(self.tournament_id)"
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop]
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func NotiAction(_ sender:Any)
    {
        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
        let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"ChooseTeamViewController") as! ChooseTeamViewController
        self.navigationController?.pushViewController(SwreavelObj, animated: true)
    }
    
    func tournamentfeeds()
    {
        var dictPost:[String: AnyObject]!
        dictPost = ["tournament_id":self.tournament_id as AnyObject]
        print("Dictionary:",dictPost)
        
        WebHelper.requestPostUrl(strURL: GlobalConstant.tournamentfeeds, Dictionary: dictPost, Success:{
            success in
            let status = success.object(forKey: "status") as! String
            print("success:",success)
            /// Result fail
            if status == "0"
            {
            }
                /// Result success
            else if status == "1"
            {
                self.Feedlist = success.object(forKey: "Feedlist") as! [Any]
                self.TDTableView.reloadData()
            }  /// Result nil
            else
            {
                Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage: "Internal Server Error")
            }
        }, Failure: {
            failure in
            Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage: failure.localizedDescription)
            
        })
    }
    
    func follow_tournament()
    {
        var dictPost:[String: AnyObject]!
        dictPost = ["tournament_id":self.tournament_id as AnyObject,"user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject]
        print("Dictionary:",dictPost)
        
        WebHelper.requestPostUrl(strURL: GlobalConstant.follow_tournament, Dictionary: dictPost, Success:{
            success in
            let status = success.object(forKey: "status") as! String
            print("success:",success)
            /// Result fail
            if status == "0"
            {
            }
                /// Result success
            else if status == "1"
            {
                self.followLabel.text = success.object(forKey: "isfollow") as! String
            }  /// Result nil
            else
            {
                Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage: "Internal Server Error")
            }
        }, Failure: {
            failure in
            Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage: failure.localizedDescription)
            
        })
    }
    
    func checkin_tournament()
    {
        var dictPost:[String: AnyObject]!
        dictPost = ["tournament_id":self.tournament_id as AnyObject,"user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject]
        print("Dictionary:",dictPost)
        
        WebHelper.requestPostUrl(strURL: GlobalConstant.checkin_tournament, Dictionary: dictPost, Success:{
            success in
            let status = success.object(forKey: "status") as! String
            print("success:",success)
            /// Result fail
            if status == "0"
            {
            }
                /// Result success
            else if status == "1"
            {
                self.Get_tournamentdetails()
            }  /// Result nil
            else
            {
                Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage: "Internal Server Error")
            }
        }, Failure: {
            failure in
            Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage: failure.localizedDescription)
            
        })
    }
    
    @objc func CheckSubmitResultTime()
    {
        print("CheckSubmitResultTime.........................")
        // Jan 14th, 2019 05:00 PM
        // Jan 14th, 2019 10:05 PM  //   2019-01-14
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd hh:mm a"   // 2019-01-14 10:05 PM
        let curnt_Date_str = formatter.string(from: Date())
        let curnDate = formatter.date(from: curnt_Date_str)
        
        let  obj2 = OverViewArray[5]
        // print("obj2.NameOfOverview:::::::::::::::::::...........",obj2.NameOfOverview)
        let startDateTimeStr =  self.StartDate+" "+obj2.NameOfOverview
        let startDate = formatter.date(from: startDateTimeStr)
        // print("Current Date::",curnDate!,"==",startDate!)
        if startDate != nil
        {
            if  curnDate! >= startDate!
            {
                self.JoinNowLabel.text = "SUBMIT RESULT"
            }
        }
        
    }
   
    
    func Get_tournamentdetails(){
        var dictPost = [String: AnyObject]()
        
        dictPost = ["tournament_id":self.tournament_id as AnyObject,"user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject]
        print("Get_tournamentdetails ::Dict",dictPost)
        WebHelper.requestPostUrl(strURL: GlobalConstant.tournamentdetails, Dictionary: dictPost, Success: {success in
            print("data from the server is this........>>>>>>>>>>>>>>",success)
            let TournamentDetails = success.object(forKey: "TournamentDetails") as! [String:AnyObject]
            
            self.followLabel.text =  TournamentDetails["isfollow"] as? String
            self.TournamentGameID = TournamentDetails["TournamentGameID"] as! String
            self.StartDate = TournamentDetails["TournamentStartDate"] as! String
            
            let isexpire = String(describing: TournamentDetails["isexpire"]!)
            if isexpire == "1"
            {
                self.JoinNowLabel.text = "EXPIRED"
            }
            else if isexpire == "0"
            {
                if TournamentDetails["isjoin"] as? String == "Joined"
                {
                    if TournamentDetails["ischeckin"] as? String == "Check-IN !"
                    {
                        self.JoinNowLabel.text = "CHECK-IN"
                    }
                    else if TournamentDetails["ischeckin"] as? String == "Checked-In"
                    {
                        
                        // _ = Timer.scheduledTimer(timeInterval:1.0, target: self, selector: #selector(TournamentDetailsVC.CheckSubmitResultTime), userInfo: nil, repeats: true)
                        let ShowNutton = String(describing:  TournamentDetails["showsubmit"]!)
                        if   ShowNutton == "0"{
                            self.JoinNowLabel.text = "CHECKED-IN"
                        }else if ShowNutton == "1"{
                            self.JoinNowLabel.text = "SUBMIT RESULT"
                        }else{
                            print("something went wrong!!")
                        }
                    }
                    
                }else if TournamentDetails["isjoin"] as? String == "Join NOW !"{
                    var isjoinValue = ""
                    // APi Calling to check isjoin
                    var dictPost = [String: AnyObject]()
                    dictPost = ["tournament_id":self.tournament_id as AnyObject,"user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject]
                    WebHelper.requestPostUrl(strURL: GlobalConstant.checkjoin, Dictionary: dictPost, Success: {success in
                        print("success data from the server is that",success)
                        let status = String(describing: success.value(forKey: "status")!)
                        if status == "1"{
                            let dic = success.value(forKey: "Tournamentdetails") as! NSDictionary
                            let   isjoinValue = String(describing: dic.value(forKey: "isjoin")!)
                            if isjoinValue == "0"{
                                self.JoinNowLabel.text = "Join NOW !"
                            }else if isjoinValue == "1"{
                                self.JoinNowLabel.text = "EXPIRED"
                            }else if isjoinValue == "2"{
                                let tournamentSize = TournamentDetails["TournamentTeams"] as! String
                                let checkincountTeams = TournamentDetails["CheckinCount"] as! String
                                self.JoinNowLabel.text = "\(checkincountTeams)/\(tournamentSize)"
                            }else if isjoinValue == "3"{
                                self.JoinNowLabel.text = "CHECK IN CLOSED"
                            }
                        }else{
                            
                        }
                    }, Failure: {failler in
                        print("somehitng went wrong??")
                    })
                } // End of TournamentDetails["isjoin"]
            }
            
            
            
            
//            if TournamentDetails["isjoin"] as? String == "Joined"
//            {
//                if TournamentDetails["ischeckin"] as? String == "Check-IN !"
//                {
//                    self.JoinNowLabel.text = "CHECK-IN"
//                }
//                else if TournamentDetails["ischeckin"] as? String == "Checked-In"
//                {
//
//                    // _ = Timer.scheduledTimer(timeInterval:1.0, target: self, selector: #selector(TournamentDetailsVC.CheckSubmitResultTime), userInfo: nil, repeats: true)
//                    let ShowNutton = String(describing:  TournamentDetails["showsubmit"]!)
//                    if   ShowNutton == "0"{
//                        self.JoinNowLabel.text = "CHECKED-IN"
//                    }else if ShowNutton == "1"{
//                        self.JoinNowLabel.text = "SUBMIT RESULT"
//                    }else{
//                        print("something went wrong!!")
//                    }
//                }
//
//            }else if TournamentDetails["isjoin"] as? String == "Join NOW !"{
//                var isjoinValue = ""
//                // APi Calling to check isjoin
//                var dictPost = [String: AnyObject]()
//                dictPost = ["tournament_id":self.tournament_id as AnyObject,"user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject]
//                WebHelper.requestPostUrl(strURL: GlobalConstant.checkjoin, Dictionary: dictPost, Success: {success in
//                    print("success data from the server is that",success)
//                    let status = String(describing: success.value(forKey: "status")!)
//                    if status == "1"{
//                        let dic = success.value(forKey: "Tournamentdetails") as! NSDictionary
//                        let   isjoinValue = String(describing: dic.value(forKey: "isjoin")!)
//                        if isjoinValue == "0"{
//                            self.JoinNowLabel.text = "Join NOW !"
//                        }else if isjoinValue == "1"{
//                            self.JoinNowLabel.text = "EXPIRED"
//                        }else if isjoinValue == "2"{
//                            self.JoinNowLabel.text = "FULL"
//                        }else if isjoinValue == "3"{
//                            self.JoinNowLabel.text = "CHECK IN CLOSED"
//                        }
//                    }else{
//
//                    }
//                }, Failure: {failler in
//                    print("somehitng went wrong??")
//                })
//            }
            
            
            let url = URL(string:TournamentDetails["TournamentCoverImage"] as! String)
            self.coverimageview?.kf.setImage(with: url,
                                             placeholder:UIImage(named: "placeholder"),
                                             options: [.transition(.fade(1))],
                                             progressBlock: nil,
                                             completionHandler: nil)
            let obj1 = OverViewTournament(TitleOfOverView: "Tournament Name", NameOfOverview: TournamentDetails["TournamentTitle"] as! String)
            self.OverViewArray.append(obj1)
            let obj2 = OverViewTournament(TitleOfOverView: "Tournament Level", NameOfOverview: TournamentDetails["TournamentLevel"] as! String)
            self.OverViewArray.append(obj2)
            let obj3 = OverViewTournament(TitleOfOverView: "Tournament Plateform", NameOfOverview: TournamentDetails["TournamentPlatform"] as! String)
            self.OverViewArray.append(obj3)
            let obj4 = OverViewTournament(TitleOfOverView: "Tournament Game", NameOfOverview: TournamentDetails["TournamentGame"] as! String)
            self.OverViewArray.append(obj4)
            let obj5 = OverViewTournament(TitleOfOverView: "Tournament Date", NameOfOverview: TournamentDetails["TournamentDate"] as! String)
            self.OverViewArray.append(obj5)
            let obj6 = OverViewTournament(TitleOfOverView: "Tournament Start Time", NameOfOverview: TournamentDetails["TournamentStartTime"] as! String)
            self.OverViewArray.append(obj6)
            print("::::::::::::::::::Date\(TournamentDetails["TournamentDate"] as! String) and Time::\(TournamentDetails["TournamentStartTime"] as! String)")
            let obj7 = OverViewTournament(TitleOfOverView: "Tournament Expiration Date", NameOfOverview: TournamentDetails["TournamentExpirationDate"] as! String)
            self.OverViewArray.append(obj7)
            let obj8 = OverViewTournament(TitleOfOverView: "Tournament Expiration Time", NameOfOverview: TournamentDetails["TournamentExpirationTime"] as! String)
            self.OverViewArray.append(obj8)
            let obj9 = OverViewTournament(TitleOfOverView: "Tournament Time-Zone", NameOfOverview: TournamentDetails["TournamentTimeZone"] as! String)
            self.OverViewArray.append(obj9)
            self.userteams(TournamentTeamMembers: Global.getStringValue(TournamentDetails["TournamentTeamMembers"] as AnyObject))
        }, Failure:  {
            failure in
            Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage: failure.localizedDescription)
            
        })
        
    }
    
    func userteams(TournamentTeamMembers:String)  // List of IneligibleTeam and EligibleTeam
    {
        var dictPost:[String: AnyObject]!
        dictPost = ["game_id":self.TournamentGameID as AnyObject,"user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject,"TournamentTeamMembers":TournamentTeamMembers as AnyObject]
        print("userteams?????????????????????? Dictionary:",dictPost)
        
        WebHelper.requestPostUrl(strURL: GlobalConstant.userteams, Dictionary: dictPost, Success:{
            success in
            let status = success.object(forKey: "status") as! String
            print("userteams success:",success)
            /// Result fail
            if status == "0"
            {
                
            }
                /// Result success
            else if status == "1"
            {
               // let dict = success.object(forKey: "TeamList") as! NSDictionary
                self.IneligibleTeam = success.value(forKey: "IneligibleTeam") as! [Any]
                 self.InEligibleTeamTableView.reloadData()
                self.EligibleTeam = success.value(forKey: "EligibleTeam") as! [Any]
                self.EligibleTeamTableView.reloadData()
            }  /// Result nil
            else
            {
                Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage: "Internal Server Error")
            }
        }, Failure: {
            failure in
            Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage: failure.localizedDescription)
            
        })
    }
    
    func join_tournament()
    {
        var dictPost:[String: AnyObject]!
        dictPost = ["team_id":self.team_id as AnyObject,"tournament_id":self.tournament_id as AnyObject,"user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject]
        print("join_tournament Dictionary:",dictPost)
        
        WebHelper.requestPostUrl(strURL: GlobalConstant.join_tournament, Dictionary: dictPost, Success:{
            success in
            let status = success.object(forKey: "status") as! String
            print("join_tournament  success:",success)
            /// Result fail
            if status == "0"
            {
            }
                /// Result success
            else if status == "1"
            {
                self.Get_tournamentdetails()
                self.ChoseTeamView.isHidden = true
                self.BGView.isHidden = true
            }  /// Result nil
            else
            {
                Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage: "Internal Server Error")
            }
        }, Failure: {
            failure in
            Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage: failure.localizedDescription)
            
        })
    }
    
    
    
}
