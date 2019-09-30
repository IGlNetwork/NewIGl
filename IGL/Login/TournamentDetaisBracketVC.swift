//
//  TournamentDetaisBracketVC.swift
//  IGL
//
//  Created by Mac Min on 03/10/18.
//  Copyright © 2018 Mac Min. All rights reserved.
//

import UIKit
import SafariServices

class TDBracketCell: UITableViewCell
{
    @IBOutlet weak var CellView1: UIView!
    @IBOutlet weak var CellView2: UIView!
    @IBOutlet weak var CellImaageView1: UIImageView!
    @IBOutlet weak var CellImaageView2: UIImageView!
    @IBOutlet weak var teamdetailbtn2: UIButton!
    @IBOutlet weak var teamdetailbtn1: UIButton!
    @IBOutlet weak var CellNameLabel1: UILabel!
    @IBOutlet weak var CellNameLabel2: UILabel!
    @IBOutlet weak var BgView: UIView!
    @IBOutlet weak var WinnerImageView: UIImageView!
    @IBOutlet weak var WinnerLabel: UILabel!
    @IBOutlet weak var WinnerView: UIView!
    @IBOutlet weak var winnerbtn: UIButton!
    
    
}


class EligibleTeamCell2: UITableViewCell
{
    @IBOutlet weak var CellImageView: UIImageView!
    @IBOutlet weak var CellTeamNameLabel: UILabel!
    @IBOutlet weak var CellCardView: UIView!
    
}

class InEligibleTeamCell2: UITableViewCell
{
    @IBOutlet weak var CellImageView: UIImageView!
    @IBOutlet weak var CellTeamNameLabel: UILabel!
    @IBOutlet weak var CellCardView: UIView!
}

class TournamentDetaisBracketVC: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    
    @IBOutlet weak var TDBracketTabeView: UITableView!
    @IBOutlet weak var NameOFRoundWihtime: UILabel!
    @IBOutlet weak var RoundsNameLabel: UILabel!
    @IBOutlet weak var Rounds: UIView!
    @IBOutlet weak var FollowLabel: UILabel!
    @IBOutlet weak var JoinNowLabel: UILabel!
    
    @IBOutlet weak var EligibleTeamTableView: UITableView!
    @IBOutlet weak var InEligibleTeamTableView: UITableView!
    @IBOutlet weak var BGView: UIView!
    @IBOutlet weak var ChoseTeamView: UIView!
    @IBOutlet weak var CreateTeamButton: UIButton!
    @IBOutlet weak var coverimageview: UIImageView!
    
    
    
    var tournament_id = ""
    var SecondRound  = [BracketModel]()
    var RoundTime = ""
   
    var followStr = ""
    var joinNowStr = ""
    
    
    var data:NSArray = []
    var WinnerArrayData:NSArray = []
    var winnerArrayStart = false
    var ArrayOfData = [FinalBracket]()
    
    var OverViewArray = [OverViewTournament]()
    var TournamentGameID = ""
    var IneligibleTeam = [Any]()
    var EligibleTeam = [Any]()
    var StartDate = ""
    var team_id = "0"
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        coverimageview.clipsToBounds = true
        Rounds.layer.cornerRadius = 15
        ChoseTeamView.layer.cornerRadius = 10
        ChoseTeamView.isHidden = true
        BGView.isHidden = true
        CreateTeamButton.layer.cornerRadius = 22
        EligibleTeamTableView.separatorColor = UIColor.clear
        InEligibleTeamTableView.separatorColor = UIColor.clear
        self.tournament_brackets()
        // self.get_tournamentwinners()
        self.Get_tournamentdetails()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear Called.Start....")
        FollowLabel.text! = self.followStr
        JoinNowLabel.text! = self.joinNowStr
         print("viewWillAppear Called End.....")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        //return 116
        if tableView == TDBracketTabeView
            {
                return 190
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // print("self.SecondRound.count... number of rows......",self.SecondRound.count)
      //  return
        if tableView == TDBracketTabeView
        {
            if self.SecondRound.count == 0{
                self.TDBracketTabeView.setEmptyMessage("Brackets not generated yet!")
            }else {
                self.TDBracketTabeView.restore()
            }
            return self.SecondRound.count
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
    
    var countForBoederColor = 0
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
       
        
        if tableView == TDBracketTabeView
        {
            let cell = TDBracketTabeView.dequeueReusableCell(withIdentifier: "TDBracketCell", for: indexPath) as! TDBracketCell
            let obj = SecondRound[indexPath.row]
            cell.teamdetailbtn1.tag = indexPath.row
            cell.teamdetailbtn2.tag = indexPath.row
            cell.winnerbtn.tag = indexPath.row
            if obj.Winner_TeamName == "" || obj.Winnner_TeamImage == "" || obj.Winner_TeamID == ""{
                cell.WinnerView.isHidden = true
                cell.BgView.isHidden = false
                cell.CellNameLabel1.text = obj.TeamName1
                cell.CellNameLabel2.text = obj.TeamName2
                let url1 = URL(string:obj.TeamImage1)
                cell.CellImaageView1?.kf.setImage(with: url1,placeholder:UIImage(named: "placeholder"),
                                                  options: [.transition(.fade(1))],
                                                  progressBlock: nil,
                                                  completionHandler: nil)
                let url2 = URL(string:obj.TeamImage2)
                cell.CellImaageView2?.kf.setImage(with: url2,placeholder:UIImage(named: "placeholder"),
                                                  options: [.transition(.fade(1))],
                                                  progressBlock: nil,
                                                  completionHandler: nil)
                
            }
            else{
                cell.BgView.isHidden = true
                cell.WinnerView.isHidden = false
                cell.WinnerLabel.text = obj.Winner_TeamName
                print("obj.Winner_TeamName\(obj.Winner_TeamName)")
//                if countForBoederColor == 0{
//                      cell.WinnerView.layer.borderColor = #colorLiteral(red: 0.8117647059, green: 0.7098039216, blue: 0.231372549, alpha: 1)
//                    
//                     print("index number of the cell is ",indexPath.row)
//                }else if  countForBoederColor == 1{
//                     cell.WinnerView.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
//                     print("index number of the cell is ",indexPath.row)
//                }else if  countForBoederColor == 2{
//                   cell.WinnerView.layer.borderColor = #colorLiteral(red: 0.6901960784, green: 0.5529411765, blue: 0.3411764706, alpha: 1)
//                     print("index number of the cell is ",indexPath.row)
//                }
                countForBoederColor = countForBoederColor + 1
                let url1 = URL(string:obj.Winnner_TeamImage)
                cell.WinnerImageView?.kf.setImage(with: url1,placeholder:UIImage(named: "placeholder"),
                                                  options: [.transition(.fade(1))],
                                                  progressBlock: nil,
                                                  completionHandler: nil)
                
            }
            
            cell.CellImaageView1.layer.cornerRadius = cell.CellImaageView1.frame.width/2.0
            cell.CellImaageView1.layer.masksToBounds = true
            cell.CellImaageView2.layer.cornerRadius = cell.CellImaageView1.frame.width/2.0
            cell.CellImaageView2.layer.masksToBounds = true
            cell.WinnerImageView.layer.cornerRadius = cell.CellImaageView1.frame.width/2.0
            cell.WinnerImageView.layer.masksToBounds = true
            
            cell.CellView1.layer.cornerRadius = 23
            cell.CellView1.layer.borderWidth = 1
            cell.WinnerView.layer.cornerRadius = 23
            cell.WinnerView.layer.borderWidth = 1
           cell.WinnerView.layer.borderColor = #colorLiteral(red: 0.09019607843, green: 0.7215686275, blue: 0.9803921569, alpha: 1)
            cell.CellView1.layer.borderColor = #colorLiteral(red: 0.09019607843, green: 0.7215686275, blue: 0.9803921569, alpha: 1)
            cell.CellImaageView1.layer.cornerRadius = cell.CellImaageView1.bounds.width/2
            
            
            cell.CellView2.layer.cornerRadius = 23
            cell.CellView2.layer.borderWidth = 1
            cell.CellView2.layer.borderColor = #colorLiteral(red: 0.09019607843, green: 0.7215686275, blue: 0.9803921569, alpha: 1)
            cell.CellImaageView2.layer.cornerRadius = cell.CellImaageView2.bounds.width/2
            return cell
        }
        else if tableView == EligibleTeamTableView
        {
            let cell = EligibleTeamTableView.dequeueReusableCell(withIdentifier: "EligibleTeamCell2", for: indexPath) as! EligibleTeamCell2
            cell.CellCardView.layer.cornerRadius = 19
            cell.CellCardView.layer.borderWidth = 2
            cell.CellCardView.layer.borderColor = #colorLiteral(red: 0.2039215686, green: 0.5254901961, blue: 0.8, alpha: 1)
            cell.CellImageView.layer.cornerRadius = cell.CellImageView.frame.size.height / 2
            cell.CellImageView.clipsToBounds = true
            cell.CellImageView.layer.masksToBounds = true
            cell.selectionStyle = .none
            let dict = self.EligibleTeam[indexPath.row] as! NSDictionary
            cell.CellTeamNameLabel.text! = dict.value(forKey: "TeamName") as! String
            let url = URL(string:dict.value(forKey: "TeamImage") as! String)
            cell.CellImageView?.kf.setImage(with: url,
                                            placeholder:UIImage(named: "placeholder"),
                                            options: [.transition(.fade(1))],
                                            progressBlock: nil,
                                            completionHandler: nil)
            return cell
        }
        else
        {
            let cell = InEligibleTeamTableView.dequeueReusableCell(withIdentifier: "InEligibleTeamCell2", for: indexPath) as! InEligibleTeamCell2
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
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == TDBracketTabeView
        {
            let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
            let vc : TournamentDetailsFeedVC = mainStoryboard.instantiateViewController(withIdentifier: "TournamentDetailsFeedVC")as! TournamentDetailsFeedVC
            self.present(vc, animated: true, completion: nil)
          
        }
        else if tableView == EligibleTeamTableView
        {
          
        
        }
        else
        {
            let dict = self.IneligibleTeam[indexPath.row] as! NSDictionary
            print("DidSelect............:", dict.value(forKey: "TeamName") as! String)
            self.team_id = String(describing: dict.value(forKey: "TeamID")!)
            self.join_tournament()
        }
          print("index number is",indexPath.row)
        
    }
    @IBAction func BackAction(_sender:Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func NotiAction(_ sender:Any)
    {
        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
        let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(SwreavelObj, animated: true)
    }
    
    @IBAction func winnerteamdetails(_ sender: UIButton) {
        let obj = SecondRound[sender.tag]
        
        let storyobj = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyobj.instantiateViewController(withIdentifier: "TeamDeatilsViewController") as! TeamDeatilsViewController
        vc.team_id = obj.TeamID2
        self.navigationController?.pushViewController(vc, animated: true)
        
        
//        let user_id = UserDefaults.standard.value(forKey: "user_id") as! String
//        let url = "https://iglnetwork.com/beta/profile/teamdetails/\(obj.Winner_TeamID)/\(user_id)"
//        print("url is coming",url)
//        let svc = SFSafariViewController(url: URL(string: url)!, entersReaderIfAvailable: true)
//        svc.preferredBarTintColor =   #colorLiteral(red: 0.06274509804, green: 0.1411764706, blue: 0.2705882353, alpha: 1)
//        svc.preferredControlTintColor = #colorLiteral(red: 0.06274509804, green: 0.1411764706, blue: 0.2705882353, alpha: 1)
//        present(svc, animated: true, completion: nil)
//        if #available(iOS 11.0, *) {
//            svc.dismissButtonStyle = .close
//        } else {
//            // Fallback on earlier versions
//        }
        
        
    }
    
    
    @IBAction func teamdetailbtn1action(_ sender: UIButton){
          let obj = SecondRound[sender.tag]
        
        let storyobj = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyobj.instantiateViewController(withIdentifier: "TeamDeatilsViewController") as! TeamDeatilsViewController
        vc.team_id = obj.TeamID2
        self.navigationController?.pushViewController(vc, animated: true)
        
        
//         let user_id = UserDefaults.standard.value(forKey: "user_id") as! String
//        let url = "https://iglnetwork.com/beta/profile/teamdetails/\(obj.TeamID1)/\(user_id)"
//        print("url is coming",url)
//        let svc = SFSafariViewController(url: URL(string: url)!, entersReaderIfAvailable: true)
//        svc.preferredBarTintColor =   #colorLiteral(red: 0.06274509804, green: 0.1411764706, blue: 0.2705882353, alpha: 1)
//        svc.preferredControlTintColor = #colorLiteral(red: 0.06274509804, green: 0.1411764706, blue: 0.2705882353, alpha: 1)
//        present(svc, animated: true, completion: nil)
//        if #available(iOS 11.0, *) {
//            svc.dismissButtonStyle = .close
//        } else {
//            // Fallback on earlier versions
//        }
  
    
    }
    
    
    @IBAction func teamdetailbtn2action(_ sender: UIButton){
        print("tag of the buttonis ",sender.tag)
        let obj = SecondRound[sender.tag]
      //  let user_id = UserDefaults.standard.value(forKey: "user_id") as! String
        
        let storyobj = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyobj.instantiateViewController(withIdentifier: "TeamDeatilsViewController") as! TeamDeatilsViewController
         vc.team_id = obj.TeamID2
        self.navigationController?.pushViewController(vc, animated: true)
        
        
        
        
//        let url = "https://iglnetwork.com/beta/profile/teamdetails/\(obj.TeamID2)/\(user_id)"
//        print("url is coming",url)
//        let svc = SFSafariViewController(url: URL(string: url)!, entersReaderIfAvailable: true)
//        svc.preferredBarTintColor =   #colorLiteral(red: 0.06274509804, green: 0.1411764706, blue: 0.2705882353, alpha: 1)
//        svc.preferredControlTintColor = #colorLiteral(red: 0.06274509804, green: 0.1411764706, blue: 0.2705882353, alpha: 1)
//        present(svc, animated: true, completion: nil)
//        if #available(iOS 11.0, *) {
//        svc.dismissButtonStyle = .close
//        } else {
//        // Fallback on earlier versions
//        }
    
    
    }

    @IBAction func JoinNowAction(_ sender: Any) {
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
    
    
    @IBAction func ShareAction(_ sender: Any) {
        let text = "http://iglnetwork.com/beta/tournaments/details/\(self.tournament_id)"
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop]
        self.present(activityViewController, animated: true, completion: nil)
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
    
    @IBAction func FollowAction(_ sender: Any) {
        follow_tournament()
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
                self.FollowLabel.text = success.object(forKey: "isfollow") as! String
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
    
    // Previous Round Action   0  1  2  3  4  5
    
    @IBAction func Round1Action(_ sender: Any) {
        print("total counter is",self.ArrayOfData.count)
        if count>=1{
            count = count - 1
            let obj = self.ArrayOfData[count]
            print("count is------",count)
            if obj.TournamentWinnerPosition == ""
            {
                self.RoundsNameLabel.text = "Round \(obj.Round) | \(obj.Time)"
                self.SecondRound = obj.Group
                self.TDBracketTabeView.reloadData()
            }
            else {
                if obj.TournamentWinnerPosition == "1"{
                    self.RoundsNameLabel.text = "First Winner"
                }
                else if obj.TournamentWinnerPosition == "2"{
                    self.RoundsNameLabel.text = "Second Winner"
                }
                else if obj.TournamentWinnerPosition == "3"{
                    self.RoundsNameLabel.text = "Third Winner"
                }
                self.SecondRound = obj.Group
                self.TDBracketTabeView.reloadData()
            }
        }
    }
    
    var count = 0
    @IBAction func ctionNextound(_ sender: Any) {
        print("total counter is",self.ArrayOfData.count)
        if self.ArrayOfData.count != 0{
            if count < self.ArrayOfData.count-1{
                count = count + 1
                let obj = self.ArrayOfData[count]
                print("count is ------",count)
                if obj.TournamentWinnerPosition == ""
                {
                    self.RoundsNameLabel.text = "Round \(obj.Round) | \(obj.Time)"
                    self.SecondRound = obj.Group
                    self.TDBracketTabeView.reloadData()
                }
                else {
                    if obj.TournamentWinnerPosition == "1"{
                        self.RoundsNameLabel.text = "First Winner"
                    }
                    else if obj.TournamentWinnerPosition == "2"{
                        self.RoundsNameLabel.text = "Second Winner"
                    }
                    else if obj.TournamentWinnerPosition == "3"{
                        self.RoundsNameLabel.text = "Third Winner"
                    }
                    self.SecondRound = obj.Group
                    self.TDBracketTabeView.reloadData()
                }
            }
        }
    }
    
    func tournament_brackets()
    {
        var dictPost:[String: AnyObject]!
        dictPost = ["tournament_id":self.tournament_id as AnyObject] //self.tournament_id
        print("Dictionary:",dictPost)
        
        WebHelper.requestPostUrl(strURL: GlobalConstant.tournament_brackets, Dictionary: dictPost, Success:{
            success in
            let status = success.object(forKey: "status") as! String
            print("success:",success)
            /// Result fail
            if status == "0"
            {
            }
            else if status == "1"
            {
                let data =  success.object(forKey: "TournamentBrackets") as! NSArray
                for obj in data{
                    let Didcobj = obj as! NSDictionary
                    var modelobj = FinalBracket()
                    modelobj.Round = String(describing: Didcobj.value(forKey:"Round")!)// as! String
                    modelobj.Time =  Didcobj.value(forKey:"Time") as! String
                    let groupdata = Didcobj.object(forKey: "Groups") as! NSArray
                    for vcobj in groupdata{
                        let obj1 = vcobj as! NSDictionary
                        var obj = BracketModel()
                        obj.TournamentGroupID = obj1.value(forKey: "TournamentGroupID") as! String
                        obj.TournamentGroupName = obj1.value(forKey: "TournamentGroupName") as! String
                        obj.TournamentWinnerGroup = obj1.value(forKey: "TournamentWinnerGroup") as! String
                        obj.TournamentGroupTournamentID = obj1.value(forKey: "TournamentGroupTournamentID") as! String
                        obj.TournamentGroupRoundID  =   obj1.value(forKey:"TournamentGroupRoundID") as! String
                        obj.TournamentGroupType = obj1.value(forKey: "TournamentGroupType") as! String
                        obj.TournamentGroupCreatedAt = obj1.value(forKey: "TournamentGroupCreatedAt") as! String
                        if let team = obj1.value(forKey: "teams") as? NSArray{
                        let teamdata = obj1.value(forKey: "teams") as! NSArray
                        if teamdata.count >= 2{
                        let dataobj1 = teamdata[0] as! NSDictionary
                        obj.TeamID1 = dataobj1.value(forKey: "TeamID") as! String
                        obj.TeamName1 = dataobj1.value(forKey: "TeamName") as! String
                        obj.TeamImage1 = dataobj1.value(forKey: "TeamImage") as! String
                        let dataobj2 = teamdata[1] as! NSDictionary
                        obj.TeamID2 = dataobj2.value(forKey: "TeamID") as! String
                        obj.TeamName2 = dataobj2.value(forKey: "TeamName") as! String
                        obj.TeamImage2 = dataobj2.value(forKey: "TeamImage") as! String

                        }
                        else{
                            let dataobj1 = teamdata[0] as! NSDictionary
                            obj.TeamID1 = dataobj1.value(forKey: "TeamID") as! String
                            obj.TeamName1 = dataobj1.value(forKey: "TeamName") as! String
                            obj.TeamImage1 = dataobj1.value(forKey: "TeamImage") as! String
                        }
                         modelobj.Group.append(obj)
                         print("ssssssssssStart........")
                        }
                    }
                     print("Startttttt........")
                    self.ArrayOfData.append(modelobj)
                }
                let obj = self.ArrayOfData[0]
                self.SecondRound = obj.Group
                self.RoundsNameLabel.text = "Round \(obj.Round) | \(obj.Time)"
                self.TDBracketTabeView.reloadData()
                print("Start........")
              self.get_tournamentwinners()
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
    
    
    
    func get_tournamentwinners()
    {
            print("Dictionary:5555555555555555555555")
        var dictPost:[String: AnyObject]!
        dictPost = ["tournament_id":self.tournament_id as AnyObject]
        print("Dictionary:",dictPost)
        
        WebHelper.requestPostUrl(strURL: GlobalConstant.get_tournamentwinners, Dictionary: dictPost, Success:{
            success in
            let status = success.object(forKey: "status") as! String
            print("success:??????",success)
            /// Result fail
            if status == "0"
            {
                 print("winner lis is.000000000000.")
            }
                /// Result success
            else if status == "1"
            {
                 print("winner lis is......111111111....")
                self.WinnerArrayData = []
                let dataobj = success.object(forKey:"Winnerlist") as! NSArray
                for obj in  dataobj{
                    let obj1  = obj as! NSDictionary
                    var vcobj = FinalBracket()
                    vcobj.TournamentWinnerPosition = obj1.value(forKey: "TournamentWinnerPosition") as! String
                    var baracketobj = BracketModel()
                    baracketobj.Winner_TeamID = obj1.value(forKey: "TeamID") as! String
                    baracketobj.Winner_TeamName = obj1.value(forKey: "TeamName") as! String
                    baracketobj.Winnner_TeamImage = obj1.value(forKey: "TeamImage") as! String
                    vcobj.Group.append(baracketobj)
                    self.ArrayOfData.append(vcobj)
                    
                }
                
                self.SecondRound =  self.ArrayOfData[0].Group
                self.RoundsNameLabel.text = "Round \(self.ArrayOfData[0].Round) | \(self.ArrayOfData[0].Time)"
                self.TDBracketTabeView.reloadData()
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
            
            self.FollowLabel.text =  TournamentDetails["isfollow"] as? String
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
        print("list of the team members is coming from the serve ris????/",dictPost)
        WebHelper.requestPostUrl(strURL: GlobalConstant.userteams, Dictionary: dictPost, Success:{
            success in
            let status = String(describing: success.object(forKey: "status")!)//success.object(forKey: "status") as! String
            print("userteams success:",success)
            /// Result fail
            if status == "0"
            {
               Global.showAlertMessageWithOkButtonAndTitle("IGL", andMessage: success.value(forKey: "msg") as! String)
            }
                /// Result success
            else if status == "1"
            {
              //  let dict = success.object(forKey: "TeamList") as! NSDictionary
                if let ineligibleTeam = success.value(forKey: "IneligibleTeam") as? [Any]{
                    print("inside the inelifible block of the code ")
                    self.IneligibleTeam = ineligibleTeam
                    self.InEligibleTeamTableView.reloadData()
                }
                if let eligibleTeam = success.value(forKey: "EligibleTeam") as? [Any]{
                       print("inside the eligible block of the code ")
                 self.EligibleTeam = eligibleTeam
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
    
    
    
}



