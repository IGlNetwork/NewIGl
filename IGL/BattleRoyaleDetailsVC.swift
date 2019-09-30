//
//  BattleRoyaleDetailsVC.swift
//  IGL
//
//  Created by apple on 03/09/19.
//  Copyright © 2019 Mac Min. All rights reserved.
//

import UIKit

class BattleRoyaleCell: UITableViewCell
{
    @IBOutlet weak var cellTitleLabel: UILabel!
    @IBOutlet weak var cellValueLabel: UILabel!
    
}


class EligibleTeamsCell: UITableViewCell
{
    @IBOutlet weak var CellImageView: UIImageView!
    @IBOutlet weak var CellTeamNameLabel: UILabel!
    @IBOutlet weak var CellCardView: UIView!
    
}

class InEligiblesTeamCell: UITableViewCell
{
    @IBOutlet weak var CellImageView: UIImageView!
    @IBOutlet weak var CellTeamNameLabel: UILabel!
    @IBOutlet weak var CellCardView: UIView!

}



class BattleRoyaleDetailsVC: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    @IBOutlet weak var overViewTableView: UITableView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var chooseTeamView: UIView!
    @IBOutlet weak var CoverImage:UIImageView!
    
    @IBOutlet weak var EligibleTeamTableView: UITableView!
    @IBOutlet weak var InEligibleTeamTableView: UITableView!
    
    @IBOutlet weak var eligibleHeightConst: NSLayoutConstraint!
    
    @IBOutlet weak var createNewTeamBUtton: UIButton!
    
    let battletitle:[String] = ["Battle Royale Name","Battle Royale Level","Battle Royale Platform","Battle Royale Game","Battle Royale Date","Battle Royale Start Time","Battle Royale Expiration Date","Battle Royale Expiration Time","Battle Royale Time-Zone","Prize Pool"]

    let battleValue = ["PUBG New","Professional","PC","PUBG","29th Dec, 2018","10:00 AM","Apr 25th, 2019","11:00 PM","Asia/Kolkata","50-40-30-20-10"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chooseTeamView.isHidden = true
        bgView.isHidden = true
        CoverImage.clipsToBounds = true
        EligibleTeamTableView.separatorColor = .clear
        InEligibleTeamTableView.separatorColor = .clear
        // Do any additional setup after loading the view.
        
        createNewTeamBUtton.layer.cornerRadius = createNewTeamBUtton.frame.height / 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == overViewTableView{
             return battletitle.count
        }
        else if tableView == EligibleTeamTableView
        {
            return 10
        }
        else{
           return 10
        }
        
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        if tableView == overViewTableView{
            let cell = overViewTableView.dequeueReusableCell(withIdentifier: "BattleRoyaleCell", for: indexPath) as! BattleRoyaleCell
            
            cell.cellTitleLabel.text! = battletitle[indexPath.row]
            cell.cellValueLabel.text! = battleValue[indexPath.row]
            return cell
        }
       else if tableView == EligibleTeamTableView
        {
            let cell = EligibleTeamTableView.dequeueReusableCell(withIdentifier: "EligibleTeamsCell", for: indexPath) as! EligibleTeamsCell
            cell.CellCardView.layer.cornerRadius = 19
            cell.CellCardView.layer.borderWidth = 2
            cell.CellCardView.layer.borderColor = #colorLiteral(red: 0.2039215686, green: 0.5254901961, blue: 0.8, alpha: 1)
            cell.CellImageView.layer.cornerRadius = cell.CellImageView.frame.size.height / 2
            cell.CellImageView.clipsToBounds = true
            cell.CellImageView.layer.masksToBounds = true
            
            //let dict = self.EligibleTeam[indexPath.row] as! NSDictionary
            
            cell.CellTeamNameLabel.text! = "Team Name"
                //dict.value(forKey: "TeamName") as! String
//            let url = URL(string:dict.value(forKey: "TeamImage") as! String)
//            cell.CellImageView?.kf.setImage(with: url,
//                                            placeholder:UIImage(named: "placeholder"),
//                                            options: [.transition(.fade(1))],
//                                            progressBlock: nil,
//                                            completionHandler: nil)
            cell.selectionStyle = .none
            return cell
        }
        else{
            let cell = InEligibleTeamTableView.dequeueReusableCell(withIdentifier: "InEligiblesTeamCell", for: indexPath) as! InEligiblesTeamCell
            cell.CellCardView.layer.cornerRadius = 19
            cell.CellCardView.layer.borderWidth = 2
            cell.CellCardView.layer.borderColor = #colorLiteral(red: 0.2039215686, green: 0.5254901961, blue: 0.8, alpha: 1)
            cell.CellImageView.layer.cornerRadius = cell.CellImageView.frame.size.height / 2
            cell.CellImageView.clipsToBounds = true
            cell.CellImageView.layer.masksToBounds = true
            cell.selectionStyle = .none
           // let dict = self.IneligibleTeam[indexPath.row] as! NSDictionary
            cell.CellTeamNameLabel.text! = "Team Name"
                //dict.value(forKey: "TeamName") as! String
//            let url = URL(string:dict.value(forKey: "TeamImage") as! String)
//            cell.CellImageView?.kf.setImage(with: url,
//                                            placeholder:UIImage(named: "placeholder"),
//                                            options: [.transition(.fade(1))],
//                                            progressBlock: nil,
//                                            completionHandler: nil)
            return cell
        }
        
        
    }
   

    @IBAction func BackActin(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func FollowAction(_ sender: Any)
    {
        //self.follow_tournament()
    }
    
    @IBAction func JoinNowAction(_ sender: Any)
    {
        // self.join_tournament()
       
//        if self.joinNowLabel.text == "CHECK-IN"
//        {
//            self.AlertWithAction(buttonTitle: "CHECK-IN", title: "", body: "\(self.entryFees) IGL Coin will be deducted from your account.", response: {_ in
//                self.checkin_tournament()
//            })
//        }
//        else if self.joinNowLabel.text == "JOIN NOW!" || self.joinNowLabel.text == "JOIN NOW" || self.joinNowLabel.text == "Join NOW !"
//        {
//            let otherAlert = UIAlertController(title: "", message: "Do you want to join the tournament?", preferredStyle: UIAlertControllerStyle.alert)
//            let printSomething = UIAlertAction(title: "YES", style: UIAlertActionStyle.default) { _ in
//                self.ChoseTeamView.isHidden = false
//                self.BGView.isHidden = false
//            }
//            let dismiss = UIAlertAction(title: "NO", style: UIAlertActionStyle.cancel, handler: nil)
//            //relate actions to controllers
//            otherAlert.addAction(printSomething)
//            //otherAlert.addAction(callFunction)
//            otherAlert.addAction(dismiss)
//            present(otherAlert, animated: true, completion: nil)
//        }
//        else if self.joinNowLabel.text == "SUBMIT RESULT"
//        {
//            print("SUBMIT RESULT Called..............")
//            let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
//            let vc = storyboardobj.instantiateViewController(withIdentifier:"TournamentSubmitResultVC") as! TournamentSubmitResultVC
//            vc.tournament_id = self.tournament_id
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
        
        chooseTeamView.isHidden = false
        bgView.isHidden = false
        
        let height = chooseTeamView.frame.height
        print("chooseTeamView Height:::",height) // 226.0 + 15 + 10 + 24 = 275 /  Height::: 567.0
        
        eligibleHeightConst.constant = ((height - 285) / 2)
        print("chooseTeamView Height:::",eligibleHeightConst.constant)
    }
    
    @IBAction func CloseChooseTeamViewAction(_ sender: Any) {
        chooseTeamView.isHidden = true
        bgView.isHidden = true
    }
    
    
    @IBAction func CreateTeamAction(_ sender: Any) {
        let StoryBoardObj = UIStoryboard(name: "Main", bundle: nil)
        let vc = StoryBoardObj.instantiateViewController(withIdentifier: "ProfileCreateTeamVC") as! ProfileCreateTeamVC
        //vc.prePopulateArr = self.prePopulateArr
       // vc.isComingFromTournamentDeatils = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func ShareAction(_ sender: Any)
    {
        let text = "zds"
        //"http://iglnetwork.com/beta/tournaments/details/\(self.tournament_id)"
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop]
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
    @IBAction func viewGroups(_ sender: Any)
    {
        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
        let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"BattleRoyaleGroupsVC") as! BattleRoyaleGroupsVC
        self.navigationController?.pushViewController(SwreavelObj, animated: true)
    }
    
    
    @IBAction func battleRoyaleFeedAction(_ sender: Any) {
//        let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
//        let vc : TournamentDetailsFeedVC = mainStoryboard.instantiateViewController(withIdentifier: "TournamentDetailsFeedVC") as! TournamentDetailsFeedVC
//        vc.tournament_id = self.tournament_id
//        vc.title = self.Tournamentitle
//        vc.followStr = followLabel.text!
//        vc.joinNowStr = joinNowLabel.text!
//
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func NotiAction(_ sender:Any)
    {
        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
        let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"NotificationViewController") as! NotificationViewController
        
        self.navigationController?.pushViewController(SwreavelObj, animated: true)
    }
    
    
    @IBAction func VIewCheckInTeamsList(_ sender: Any) {
        let StoryObj = UIStoryboard(name: "Main", bundle: nil)
        let vcobj = StoryObj.instantiateViewController(withIdentifier: "CheckInTeamsVC") as! CheckInTeamsVC
      //  vcobj.Tournament_Id = self.tournament_id
        self.navigationController?.pushViewController(vcobj, animated:true)
    }
    
    
}
