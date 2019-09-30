//
//  BattleRoyaleGroupsVC.swift
//  IGL
//
//  Created by apple on 06/09/19.
//  Copyright © 2019 Mac Min. All rights reserved.
//

import UIKit

class tab2Cell: UICollectionViewCell
{
    @IBOutlet weak var cellCardView: UIView!
    @IBOutlet weak var cellNumberLabel: UILabel!
}

class GroupCell: UITableViewCell
{
    
    @IBOutlet weak var groupIDLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var killsLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var bubgGameIdLabel: UILabel!
    @IBOutlet weak var lobbyIdLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    
    @IBOutlet weak var cellNumberLabel: UILabel!
    @IBOutlet weak var winnerImagesImgView: UIImageView!
    
}



class BattleRoyaleGroupsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{

    @IBOutlet weak var tabCollectionView: UICollectionView!
    @IBOutlet weak var groupsTableView: UITableView!
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var chooseTeamView: UIView!
    @IBOutlet weak var CoverImage:UIImageView!
    @IBOutlet weak var battleRoyaleTitle: UILabel!
    
    @IBOutlet weak var winnerButton: UIButton!
    @IBOutlet weak var firstRoundButton: UIButton!
    @IBOutlet weak var secondRoundButton: UIButton!
    
    @IBOutlet weak var EligibleTeamTableView: UITableView!
    @IBOutlet weak var InEligibleTeamTableView: UITableView!
    
    @IBOutlet weak var eligibleHeightConst: NSLayoutConstraint!
    @IBOutlet weak var createNewTeamBUtton: UIButton!
    
    
    
    var selectedRound = 1
    var selectedTab = 0
    var winnerImgArr = [#imageLiteral(resourceName: "winner_icon"),#imageLiteral(resourceName: "2nd_icon"),#imageLiteral(resourceName: "3rd_icon"),#imageLiteral(resourceName: "4th_icon"),#imageLiteral(resourceName: "5th_icon")]
    var tabSize = 4
    override func viewDidLoad() {
        
        super.viewDidLoad()
        CoverImage.clipsToBounds = true
        groupsTableView.separatorColor = .clear
        // Do any additional setup after loading the view.
        bgView.isHidden = true
        chooseTeamView.isHidden = true
        createNewTeamBUtton.layer.cornerRadius = createNewTeamBUtton.frame.height / 2
        // Do any additional setup after loading the view.
    }
    
    @IBAction func BackActin(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         if selectedRound <= 2{
             return 100
        }
         else{
             return winnerImgArr.count
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = groupsTableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupCell
       
        if selectedRound <= 2{ // it means firstRound and Second Round
            if indexPath.row < 9
            {
                cell.cellNumberLabel.text! = "0\(indexPath.row + 1)"
            }
            else{
                cell.cellNumberLabel.text! = "\(indexPath.row + 1)"
            }
             cell.winnerImagesImgView.isHidden = true
             cell.cellNumberLabel.isHidden = false
            
            cell.groupIDLabel.text! = "Group Id: 01"
            cell.rankLabel.text! = "Rank: 4"
            cell.killsLabel.text! = "Kills: 25"
            cell.scoreLabel.text! = "Score: 257"
            
            cell.teamNameLabel.text! = "Team Name: Dynamo"
            cell.bubgGameIdLabel.text! = "Pubg Game Id: 44576"
            cell.lobbyIdLabel.text! = "Lobby Code: L123"
            cell.cityLabel.text! = "City: Mumbai"
        }
        else{
             cell.winnerImagesImgView.image = winnerImgArr[indexPath.row]
             cell.winnerImagesImgView.isHidden = false
             cell.cellNumberLabel.isHidden = true
            
            cell.groupIDLabel.text! =  "Team Name: Dynamo"
            cell.rankLabel.text! = "1st Round Score: 1046"
            cell.killsLabel.text! = "2nd Round Score: 1055"
            cell.scoreLabel.text! =  "Rank: 4"
            //"Group Id: 01"
            
            cell.teamNameLabel.text! = "Kills: 65"
            cell.bubgGameIdLabel.text! = "Pubg Game Id: 44576"
            cell.lobbyIdLabel.text! = "Lobby Code: L123"
            cell.cityLabel.text! = "City: Mumbai"
            
        }
       
        
       
        cell.selectionStyle = .none
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabSize
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = tabCollectionView.dequeueReusableCell(withReuseIdentifier: "tab2Cell", for: indexPath) as! tab2Cell
        cell.cellNumberLabel.text! = "\(indexPath.row + 1)"
        if indexPath.row == selectedTab{
            cell.cellCardView.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.5254901961, blue: 0.8, alpha: 1)
        }
        else{
             cell.cellCardView.backgroundColor = #colorLiteral(red: 0.1450980392, green: 0.2745098039, blue: 0.4352941176, alpha: 1)
        }
        
        
        return cell
    }
   
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
       
        selectedTab = indexPath.row
        tabCollectionView.reloadData()
        return true
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("sizeForItemAt............",tabCollectionView.frame.width)
        var a:CGFloat = 46.0
        if tabSize < 8{
            let b = tabCollectionView.frame.width
            let c = CGFloat(tabSize)
            a = CGFloat(b / c )
        }
        return CGSize(width: a, height: 30.0)
    }
    
    
    @IBAction func winnerButtonAction(_ sender: Any) {
        battleRoyaleTitle.text! = "BATTLE ROYALE WINNERS"
        self.selectedRound = 3
        winnerButton.setImage(#imageLiteral(resourceName: "brackets128"), for: .normal)
        secondRoundButton.setImage(#imageLiteral(resourceName: "dark_icon"), for: .normal)
        firstRoundButton.setImage(#imageLiteral(resourceName: "dark_icon"), for: .normal)
        tabCollectionView.isHidden = true
        groupsTableView.reloadData()
    }
    
    @IBAction func secondRoundAction(_ sender: Any) {
        battleRoyaleTitle.text! = "BATTLE ROYALE GROUPS"
        self.selectedRound = 2
        winnerButton.setImage(#imageLiteral(resourceName: "dark_icon"), for: .normal)
        secondRoundButton.setImage(#imageLiteral(resourceName: "brackets128"), for: .normal)
        firstRoundButton.setImage(#imageLiteral(resourceName: "dark_icon"), for: .normal)
        tabCollectionView.isHidden = false
        tabSize = 2
        groupsTableView.reloadData()
        tabCollectionView.reloadData()
    }
    
    @IBAction func firstRoundAction(_ sender: Any) {
         battleRoyaleTitle.text! = "BATTLE ROYALE GROUPS"
         self.selectedRound = 1
         winnerButton.setImage(#imageLiteral(resourceName: "dark_icon"), for: .normal)
         secondRoundButton.setImage(#imageLiteral(resourceName: "dark_icon"), for: .normal)
         firstRoundButton.setImage(#imageLiteral(resourceName: "brackets128"), for: .normal)
         tabCollectionView.isHidden = false
         tabSize = 4
         groupsTableView.reloadData()
         tabCollectionView.reloadData()
    }
    
    @IBAction func viewGroups(_ sender: Any)
    {
//        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
//        let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"BattleRoyaleGroupsVC") as! BattleRoyaleGroupsVC
//        self.navigationController?.pushViewController(SwreavelObj, animated: true)
    }
    
    @IBAction func battleRoyaleFeedAction(_ sender: Any) {
        
    }
    
    @IBAction func NotiAction(_ sender:Any)
    {
        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
        let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"NotificationViewController") as! NotificationViewController
        
        self.navigationController?.pushViewController(SwreavelObj, animated: true)
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
    
    
    @IBAction func VIewCheckInTeamsList(_ sender: Any) {
        let StoryObj = UIStoryboard(name: "Main", bundle: nil)
        let vcobj = StoryObj.instantiateViewController(withIdentifier: "CheckInTeamsVC") as! CheckInTeamsVC
        //  vcobj.Tournament_Id = self.tournament_id
        self.navigationController?.pushViewController(vcobj, animated:true)
    }
    
    
    
    
}
