//
//  TournamentDetailsVC.swift
//  IGL
//
//  Created by Mac Min on 05/10/18.
//  Copyright © 2018 Mac Min. All rights reserved.
//

import UIKit


struct OverViewTournament {
    var TitleOfOverView = ""
    var NameOfOverview = ""
}
class TournamentBracketCell: UITableViewCell
{
    @IBOutlet weak var Titlelabel:UILabel!
    @IBOutlet weak var  NameLabel:UILabel!
}

class TournamentRulesCell: UITableViewCell
{
    
}


class EligibleTeamCell: UITableViewCell
{
    @IBOutlet weak var CellImageView: UIImageView!
    @IBOutlet weak var CellTeamNameLabel: UILabel!
    @IBOutlet weak var CellCardView: UIView!
    
}

class InEligibleTeamCell: UITableViewCell
{
    @IBOutlet weak var CellImageView: UIImageView!
    @IBOutlet weak var CellTeamNameLabel: UILabel!
    @IBOutlet weak var CellCardView: UIView!
}
class TournamentDetailsVC: UIViewController, UITableViewDelegate, UITableViewDataSource,UIWebViewDelegate
{
    
    @IBOutlet weak var BracketTableView:UITableView!
    @IBOutlet weak var RulesTableView:UITableView!
    @IBOutlet weak var CheckInTimeLabel:UILabel!  // ========= Working..
    @IBOutlet weak var CheckInCloseTimeLabel:UILabel!
    
    @IBOutlet weak var WINNERSPRIZELabel:UILabel!
    @IBOutlet weak var RUNNERUPPRIZELabel:UILabel!
    
    @IBOutlet weak var followLabel:UILabel!
    @IBOutlet weak var joinNowLabel:UILabel!
    @IBOutlet weak var DateLabelLabel:UILabel!
    @IBOutlet weak var CoverImage:UIImageView!
    @IBOutlet weak var EligibleTeamTableView: UITableView!
    @IBOutlet weak var InEligibleTeamTableView: UITableView!
    @IBOutlet weak var BGView: UIView!
    @IBOutlet weak var ChoseTeamView: UIView!
    @IBOutlet weak var CreateTeamButton: UIButton!
    @IBOutlet weak var RuleLabel:UILabel!
    @IBOutlet weak var heightOfRulesTableView: NSLayoutConstraint!
    @IBOutlet weak var HeightofMainView: NSLayoutConstraint!
    @IBOutlet weak var heightoftheWebView: NSLayoutConstraint!
    @IBOutlet weak var rulesWebview: UIWebView!
    @IBOutlet var showHideRulesButton: UIButton!
    
    @IBOutlet weak var eligibleHeightConst: NSLayoutConstraint!
    
    
    
    var tournament_id  = ""
    var team_id = "0"
    var TournamentGameID = ""
    var IneligibleTeam = [Any]()
    var EligibleTeam = [Any]()
    var StartDate = ""
    var EndDate = ""
    var Tournamentitle = ""
    var TournamentRule = ""
    var TournamentRuleArray:NSArray = []
    var OverViewArray = [OverViewTournament]()
    var entryFees = ""
    
    var prePopulateArr = [String]() // Create Team
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.rulesWebview.isHidden = true
        self.rulesWebview.delegate = self
        ChoseTeamView.layer.cornerRadius = 10
        ChoseTeamView.isHidden = true
        BGView.isHidden = true
        CoverImage.clipsToBounds = true
        CreateTeamButton.layer.cornerRadius = 17.5
        EligibleTeamTableView.separatorColor = UIColor.clear
        InEligibleTeamTableView.separatorColor = UIColor.clear
         self.HeightofMainView.constant =  1320
        CoverImage.clipsToBounds = true
        //    self.Get_tournamentdetails()
        //RuleLabel.attributedText =  self.TournamentRule.html2AttributedString  ////////
        // Do any additional setup after loading the view.
        
    }
    
    
    func webViewDidStartLoad(_ webView: UIWebView)
    {
        webView.allowsLinkPreview = true
        if webView.isLoading == false {
            let result =  webView.stringByEvaluatingJavaScript(from:"document.body.scrollHeight")
            //  webView.evaluateJavaScript("document.body.scrollHeight", completionHandler: { [weak self] (result, error) in
            if let height = result as? CGFloat {
                
                webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0,64, 0)
                webView.frame.size.height += height
                webView.frame.size = webView.scrollView.contentSize
                self.heightoftheWebView.constant = webView.frame.size.height + 20
                self.HeightofMainView.constant = (self.heightoftheWebView.constant) + 1550 + 150
            }
        }
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error)
    {
        // HeightofMainView.constant =  1100
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView)
    {
        webView.allowsLinkPreview = true
        if webView.isLoading == false {
            let result =  webView.stringByEvaluatingJavaScript(from:"document.body.scrollHeight")
            //  webView.evaluateJavaScript("document.body.scrollHeight", completionHandler: { [weak self] (result, error) in
            if let height = result as? CGFloat {
                
                webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0,64, 0)
                webView.frame.size.height += height
                webView.frame.size = webView.scrollView.contentSize
                self.heightoftheWebView.constant = webView.frame.size.height + 20
                self.HeightofMainView.constant = (self.heightoftheWebView.constant) + 1550 + 150
            }
        }
        // })
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        Get_tournamentdetails()
        // userteams()
    }
    // 6,9
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if tableView == BracketTableView
        {
            return 32
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == BracketTableView
        {
            print("BracketTableView:::",OverViewArray.count)
            return OverViewArray.count
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
        if tableView == BracketTableView
        {
            let cell = BracketTableView.dequeueReusableCell(withIdentifier: "TournamentBracketCell", for: indexPath) as! TournamentBracketCell
            let  obj = OverViewArray[indexPath.row]
            cell.NameLabel.text = obj.NameOfOverview
            cell.Titlelabel.text = obj.TitleOfOverView
            cell.selectionStyle = .none
            return cell
        }
            
        else if tableView == EligibleTeamTableView
        {
            let cell = EligibleTeamTableView.dequeueReusableCell(withIdentifier: "EligibleTeamCell", for: indexPath) as! EligibleTeamCell
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
                                            placeholder:UIImage(named: "placeholder"),
                                            options: [.transition(.fade(1))],
                                            progressBlock: nil,
                                            completionHandler: nil)
            cell.selectionStyle = .none
            return cell
        }
        else
        {
            let cell = InEligibleTeamTableView.dequeueReusableCell(withIdentifier: "InEligibleTeamCell", for: indexPath) as! InEligibleTeamCell
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
                                            placeholder:UIImage(named: "placeholder"),
                                            options: [.transition(.fade(1))],
                                            progressBlock: nil,
                                            completionHandler: nil)
            return cell
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if tableView ==  InEligibleTeamTableView
        {
            
        }
        else if tableView == EligibleTeamTableView
        {
            print("self.EligibleTeam[]",self.EligibleTeam[indexPath.row])
            let dict = self.EligibleTeam[indexPath.row] as! NSDictionary
            print("DidSelect............:", dict.value(forKey: "TeamName") as! String)
            self.team_id = String(describing: dict.value(forKey: "TeamID")!)
            self.join_tournament()
        }
        
    }
    
    
    
    @IBAction func BackActin(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func FollowAction(_ sender: Any)
    {
        self.follow_tournament()
    }
    
    @IBAction func JoinNowAction(_ sender: Any)
    {
        // self.join_tournament()
        if self.joinNowLabel.text == "CHECK-IN"
        {
            var alertMsg = ""
            if self.entryFees == "0" || self.entryFees == "00"
            {
                alertMsg = "It is Free, No IGL Coin will be deducted from your account."
            }
            else{
                 alertMsg = "\(self.entryFees) IGL Coin will be deducted from your account."
            }
            
            self.AlertWithAction(buttonTitle: "CHECK-IN", title: "", body: alertMsg, response: {_ in
                self.checkin_tournament()
            })
        }
        else if self.joinNowLabel.text == "JOIN NOW!" || self.joinNowLabel.text == "JOIN NOW" || self.joinNowLabel.text == "Join NOW !"
        {
            let otherAlert = UIAlertController(title: "", message: "Do you want to join the tournament?", preferredStyle: UIAlertControllerStyle.alert)
            let printSomething = UIAlertAction(title: "YES", style: UIAlertActionStyle.default) { _ in
                self.ChoseTeamView.isHidden = false
                self.BGView.isHidden = false
                
                // it is Used to Manage Height of both TableView as Same Height.
                let height = self.ChoseTeamView.frame.height
                print("chooseTeamView Height:::",height) // 226.0 + 15 + 10 + 24 = 275 /  Height::: 567.0
                self.eligibleHeightConst.constant = ((height - 285) / 2)
                print("TableView Height:::",self.eligibleHeightConst.constant)
            }
            let dismiss = UIAlertAction(title: "NO", style: UIAlertActionStyle.cancel, handler: nil)
            //relate actions to controllers
            otherAlert.addAction(printSomething)
            //otherAlert.addAction(callFunction)
            otherAlert.addAction(dismiss)
            present(otherAlert, animated: true, completion: nil)
        }
        else if self.joinNowLabel.text == "SUBMIT RESULT"
        {
            print("SUBMIT RESULT Called..............")
            let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboardobj.instantiateViewController(withIdentifier:"TournamentSubmitResultVC") as! TournamentSubmitResultVC
            vc.tournament_id = self.tournament_id
            self.navigationController?.pushViewController(vc, animated: true)
        }
       
        
       
        
    }
    
    @IBAction func CloseChooseTeamViewAction(_ sender: Any) {
        ChoseTeamView.isHidden = true
        BGView.isHidden = true
    }
    
    @IBAction func CreateTeamAction(_ sender: Any) {
        let StoryBoardObj = UIStoryboard(name: "Main", bundle: nil)
        let vc = StoryBoardObj.instantiateViewController(withIdentifier: "ProfileCreateTeamVC") as! ProfileCreateTeamVC
        vc.prePopulateArr = self.prePopulateArr
        vc.isComingFromTournamentDeatils = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func ShareAction(_ sender: Any)
    {
        let text = "http://iglnetwork.com/beta/tournaments/details/\(self.tournament_id)"
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop]
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func GoToBracket(_ sender: Any)
    {
        
        let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
        let vc : TournamentDetaisBracketVC = mainStoryboard.instantiateViewController(withIdentifier: "TournamentDetaisBracketVC") as! TournamentDetaisBracketVC
        vc.tournament_id = self.tournament_id
        
        vc.title = self.Tournamentitle
        vc.followStr = followLabel.text!
        vc.joinNowStr = joinNowLabel.text!
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    
    @IBAction func ViewTournamentAction(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
        let vc : TournamentDetailsFeedVC = mainStoryboard.instantiateViewController(withIdentifier: "TournamentDetailsFeedVC") as! TournamentDetailsFeedVC
        vc.tournament_id = self.tournament_id
        vc.title = self.Tournamentitle
        vc.followStr = followLabel.text!
        vc.joinNowStr = joinNowLabel.text!
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func NotiAction(_ sender:Any)
    {
        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
        let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"NotificationViewController") as! NotificationViewController
        
        self.navigationController?.pushViewController(SwreavelObj, animated: true)
    }
    
    
    @IBAction func VIewCheckInTeamsList(_ sender: Any) {
        let StoryObj = UIStoryboard(name: "Main", bundle: nil)
        let vcobj = StoryObj.instantiateViewController(withIdentifier: "CheckedInTeamViewController") as! CheckedInTeamViewController
        vcobj.Tournament_Id = self.tournament_id
        self.navigationController?.pushViewController(vcobj, animated:true)
    }
    
    var RulesStr = ""
    @IBAction func showHideRulesAction(_ sender: UIButton) {
        
        if sender.isSelected
        {
            self.rulesWebview.isHidden = true
            self.showHideRulesButton.setImage(#imageLiteral(resourceName: "add"), for: .normal)
            self.HeightofMainView.constant =  1320
            sender.isSelected = false
        }
        else
        {
            self.rulesWebview.isHidden = false
            self.showHideRulesButton.setImage(#imageLiteral(resourceName: "substract"), for: .normal)
            sender.isSelected = true
            if  self.TournamentRule == ""{
               self.HeightofMainView.constant =  1300
            }else{
                 self.HeightofMainView.constant =  1800
            }
            
         
        }
        
    }
    
    
    
    
}
extension TournamentDetailsVC{
    
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
                if success.object(forKey: "isfollow") as! String == "Followed"{
                    self.followLabel.text = "FOLLOWED"
                }else{
                    self.followLabel.text = "FOLLOW"
                }
                
                
            }  /// Result nil
            else
            {
                Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage: "Internal Server Error")
            }
        }, Failure: {
            failure in
            Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage: failure.localizedDescription)
            
        })
    } // userteams
    
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
    
    func userteams(TournamentTeamMembers:String)  // List of IneligibleTeam and EligibleTeam
    {
        var dictPost:[String: AnyObject]!
        dictPost = ["game_id":self.TournamentGameID as AnyObject,"user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject,"TournamentTeamMembers":TournamentTeamMembers as AnyObject]
        print("userteams Dictionary:",dictPost)
        
        WebHelper.requestPostUrl(strURL: GlobalConstant.userteams, Dictionary: dictPost, Success:{
            success in
            let status = success.object(forKey: "status") as! String
            print("EligibleTeam userteams success:",success)
            /// Result fail
            if status == "0"
            {
            }
                /// Result success
            else if status == "1"
            {//EligibleTeam
                
                if success.value(forKey: "IneligibleTeam") != nil{
                    self.IneligibleTeam = success.value(forKey: "IneligibleTeam") as! [Any]
                    self.InEligibleTeamTableView.reloadData()
                }
                if success.value(forKey: "EligibleTeam") != nil{
                    self.EligibleTeam = success.value(forKey: "EligibleTeam") as! [Any]
                    self.EligibleTeamTableView.reloadData()
                }
                
                
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
    
     // MARK:- Kumar Lav
    @objc func CheckSubmitResultTime()
    {
        print("CheckSubmitResultTime.........................")
        // Jan 14th, 2019 05:00 PM
        // Jan 14th, 2019 10:05 PM  //   2019-01-14
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd hh:mm a"   // 2019-01-14 10:05 PM
        let curnt_Date_str = formatter.string(from: Date())
        let curnDate = formatter.date(from: curnt_Date_str)
        let  obj2 = OverViewArray[7]
        let startDateTimeStr =  self.StartDate+" "+obj2.NameOfOverview
        let startDate = formatter.date(from: startDateTimeStr)
        print("Current Date::",curnDate!,"==",startDate!)
        
        if  curnDate! >= startDate!
        {
            self.joinNowLabel.text = "SUBMIT RESULT"
        }
    }
    
    
    
    func Get_tournamentdetails(){
        
        var dictPost = [String: AnyObject]()
        dictPost = ["tournament_id":self.tournament_id as AnyObject,"user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject]
        WebHelper.requestPostUrl(strURL: GlobalConstant.tournamentdetails, Dictionary: dictPost, Success: {success in
            print("dictPost:::\(dictPost)data from the server is this........>>>>>>>>>>>>>>",success)
            self.prePopulateArr.removeAll()
             self.OverViewArray.removeAll()
            let TournamentDetails = success.object(forKey: "TournamentDetails") as! [String:AnyObject]
            self.title = TournamentDetails["TournamentTitle"] as! String//TournamentTitle
            let CHECK_IN_TIME_CLOSE =  TournamentDetails["TournamentCheckOutTime"] as! String
            let CHECK_IN_TIME = TournamentDetails["TournamentCheckInTime"] as! String
            self.CheckInCloseTimeLabel.text = "CHECK-IN CLOSE TIME:" +  CHECK_IN_TIME_CLOSE
            self.CheckInTimeLabel.text = "CHECK-IN TIME:" + CHECK_IN_TIME
            //  self.WINNERSPRIZELabel.text = TournamentDetails["TournamentWinnerPrize"] as! String + " IGL COINS"
            //   self.RUNNERUPPRIZELabel.text =  TournamentDetails["TournamentRunnerupPrize"] as! String + " IGL COINS"
            self.TournamentRule = TournamentDetails["TournamentRulesText"] as! String
            //self.RuleLabel.attributedText =  self.TournamentRule.html2AttributedString
            // self.RuleLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.rulesWebview.backgroundColor = UIColor.clear
            if  TournamentDetails["TournamentRulesText"] as! String == "" ||  TournamentDetails["TournamentRulesText"] as! String == nil{
                self.HeightofMainView.constant =  1320
                self.rulesWebview.isHidden = true
            }else{
                self.rulesWebview.loadHTMLString("<body bgcolor=\"#122649\"<div style=\"color:#f2f2f2\">\( self.TournamentRule)</div></body>", baseURL: nil)
            }
            self.DateLabelLabel.text = TournamentDetails["TournamentDate"] as? String
            if TournamentDetails["isfollow"] as? String == "Followed"{
                self.followLabel.text =  "FOLLOWED"
            }
            self.TournamentGameID = TournamentDetails["TournamentGameID"] as! String
            self.StartDate = TournamentDetails["TournamentStartDate"] as! String
            print("Start Date::::",self.StartDate )
            let isexpire = String(describing: TournamentDetails["isexpire"]!)
            if isexpire == "1"{
                self.joinNowLabel.text = "EXPIRED"
            }else if isexpire == "0"{
                if TournamentDetails["isjoin"] as? String == "Joined"
                {
                    if TournamentDetails["ischeckin"] as? String == "Check-IN !"
                    {
                        self.joinNowLabel.text = "CHECK-IN"
                    }
                    else if TournamentDetails["ischeckin"] as? String == "Checked-In"
                    {
                        
                        // _ = Timer.scheduledTimer(timeInterval:1.0, target: self, selector: #selector(TournamentDetailsVC.CheckSubmitResultTime), userInfo: nil, repeats: true)
                        let ShowNutton = String(describing:  TournamentDetails["showsubmit"]!)
                        if   ShowNutton == "0"{
                            self.joinNowLabel.text = "CHECKED-IN"
                        }else if ShowNutton == "1"{
                            self.joinNowLabel.text = "SUBMIT RESULT"
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
                                self.joinNowLabel.text = "Join NOW !"
                            }else if isjoinValue == "1"{
                                self.joinNowLabel.text = "EXPIRED"
                            }else if isjoinValue == "2"{
                                let tournamentSize = TournamentDetails["TournamentTeams"] as! String
                                let checkincountTeams = TournamentDetails["CheckinCount"] as! String
                                self.joinNowLabel.text = "\(checkincountTeams)/\(tournamentSize)"
                            }else if isjoinValue == "3"{
                                self.joinNowLabel.text = "CHECK IN CLOSED"
                            }
                        }else{
                            
                        }
                    }, Failure: {failler in
                        print("somehitng went wrong??")
                    })
                } // End of TournamentDetails["isjoin"]
            }  // End of  isexpire == "0"
            
            self.CheckJoinTournament(tournament_id: self.tournament_id)
            let url = URL(string:TournamentDetails["TournamentCoverImage"] as! String)
            let obj1 = OverViewTournament(TitleOfOverView: "Tournament Name", NameOfOverview: TournamentDetails["TournamentTitle"] as! String)
            self.OverViewArray.append(obj1)
            let obj0 = OverViewTournament(TitleOfOverView: "Tournament size", NameOfOverview: TournamentDetails["TournamentTeams"] as! String)
            self.OverViewArray.append(obj0)
            //TournamentTeams
            self.entryFees = TournamentDetails["TournamentEntryFees"] as! String
            let obj15 =  OverViewTournament(TitleOfOverView: "Tournament Entry Fees", NameOfOverview: "\(TournamentDetails["TournamentEntryFees"] as! String) IGL Coin") // Static Data Set make it Dynamic
            self.OverViewArray.append(obj15)
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
            
            let obj16 = OverViewTournament(TitleOfOverView: "Tournament Check-In Time", NameOfOverview: TournamentDetails["TournamentCheckInTime"] as! String)
            self.OverViewArray.append(obj16)
            
            let obj17 = OverViewTournament(TitleOfOverView: "Tournament Check-Out Time", NameOfOverview: TournamentDetails["TournamentCheckOutTime"] as! String)
            self.OverViewArray.append(obj17)
            
            print("::::::::::::::::::Date\(TournamentDetails["TournamentDate"] as! String) and Time::\(TournamentDetails["TournamentStartTime"] as! String)")
            let obj7 = OverViewTournament(TitleOfOverView: "Tournament Expiration Date", NameOfOverview: TournamentDetails["TournamentExpirationDate"] as! String)
            self.OverViewArray.append(obj7)
            let obj8 = OverViewTournament(TitleOfOverView: "Tournament Expiration Time", NameOfOverview: TournamentDetails["TournamentExpirationTime"] as! String)
            self.OverViewArray.append(obj8)
            
//            let obj9 = OverViewTournament(TitleOfOverView: "Tournament Time-Zone", NameOfOverview: TournamentDetails["TournamentTimeZone"] as! String)
//            self.OverViewArray.append(obj9)
            
            let winner = TournamentDetails["TournamentWinnerPrize"] as! String + " IGL Coin"
            let obj10 =  OverViewTournament(TitleOfOverView: "Winner Prize", NameOfOverview: winner)
            self.OverViewArray.append(obj10)
            let obj11 =  OverViewTournament(TitleOfOverView: "Winner Points", NameOfOverview: TournamentDetails["TournamentWinnerPoints"] as! String)
            self.OverViewArray.append(obj11)
            let obj00 =  OverViewTournament(TitleOfOverView: "Runner Up Prize", NameOfOverview: TournamentDetails["TournamentRunnerupPrize"] as! String + " IGL Coin")
            self.OverViewArray.append(obj00)
            let obj13 =  OverViewTournament(TitleOfOverView: "1st Runner Up Points", NameOfOverview: TournamentDetails["TournamentRunnerup1Points"] as! String)
            self.OverViewArray.append(obj13)
            let obj14 =  OverViewTournament(TitleOfOverView: "2nd Runnerup Points", NameOfOverview: TournamentDetails["TournamentRunnerup2Points"] as! String)
            self.OverViewArray.append(obj14)
            
            self.BracketTableView.reloadData()
            self.CoverImage?.kf.setImage(with: url,
                                         placeholder:UIImage(named: "placeholder"),
                                         options: [.transition(.fade(1))],
                                         progressBlock: nil,
                                         completionHandler: nil)
            //             DateLabelLabel
            // self.RulesTableView.reloadData()
            self.userteams(TournamentTeamMembers: Global.getStringValue(TournamentDetails["TournamentTeamMembers"] as AnyObject))
            
             self.prePopulateArr.append(Global.getStringValue(TournamentDetails["TournamentGame"] as AnyObject))
             self.prePopulateArr.append(Global.getStringValue(TournamentDetails["TournamentGameID"] as AnyObject))
             self.prePopulateArr.append(Global.getStringValue(TournamentDetails["UserGameGameUID"] as AnyObject))
            
             self.prePopulateArr.append(Global.getStringValue(TournamentDetails["TournamentPlatform"] as AnyObject))
             self.prePopulateArr.append(Global.getStringValue(TournamentDetails["TournamentPlatformID"] as AnyObject))
            
             self.prePopulateArr.append(Global.getStringValue(TournamentDetails["GamePlayersType"] as AnyObject))
             self.prePopulateArr.append(Global.getStringValue(TournamentDetails["TournamentTeamMembers"] as AnyObject))
            
            
        }, Failure:  {
            failure in
            Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage: failure.localizedDescription)
            
        })
        
    }
    
    func CheckJoinTournament(tournament_id:String){
        //        var dictPost = [String: AnyObject]()
        //        dictPost = ["tournament_id":tournament_id as AnyObject,"user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject]
        //        WebHelper.requestPostUrl(strURL: GlobalConstant.checkjoin, Dictionary: dictPost, Success: {success in
        //            print("success data from the server is that",success)
        //        }, Failure: {failler in
        //            print("somehitng went wrong??")
        //        })
    }
    
    
    
    
    
}



extension String {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: Data(utf8),
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}

