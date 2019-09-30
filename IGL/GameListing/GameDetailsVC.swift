//
//  GameDetailsVC.swift
//  IGL
//
//  Created by Mac Min on 01/10/18.
//  Copyright © 2018 Mac Min. All rights reserved.
//

import UIKit

class TeamModel{
    var TeamID = ""
    var TeamImage = ""
    var TeamName = ""
    
//    var UserProfileImage = ""
//    var id = ""
//    var username = ""
    
}







class UpcomingTournamentCell: UICollectionViewCell
{
    @IBOutlet weak var CelICoverImage: UIImageView!
    @IBOutlet weak var CellTitle: UILabel!
    @IBOutlet weak var CellDate: UILabel!
    @IBOutlet weak var CellEntryFees: UILabel!
    @IBOutlet weak var CellPrize: UILabel!
    @IBOutlet weak var CellJoinNowView: UIView!
    // @IBOutlet weak var CellJoinNowButton: UIButton!
    @IBOutlet weak var CellJoinNowButton: UIButton!
    
}






class GameDetailsVC: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate
{
    
    @IBOutlet weak var BAckgroundView: UIView!
    @IBOutlet weak var LikesListTableVIew: UITableView!
    @IBOutlet weak var LikeSListView: UIView!
    @IBOutlet weak var CoverImage: UIImageView!
    @IBOutlet weak var LikeView: UIView!
    //LIKE VIEW
    @IBOutlet weak var LikeLabel: UILabel!
    @IBOutlet weak var AddtoprofileLabel: UILabel!
    @IBOutlet weak var AddToProfileView: UIView!
    // ABOUT THE GAME
    @IBOutlet weak var TitleLabe: UILabel!
    @IBOutlet weak var TitleImage: UIImageView!
    @IBOutlet weak var HeadingLabel: UILabel!
    @IBOutlet weak var descriptionsLabel: UILabel!
    // GAME STATS
    @IBOutlet weak var Likeslabel: UILabel!
    @IBOutlet weak var TounamentsLabel: UILabel!
    @IBOutlet weak var TeamsLbel: UILabel!
    @IBOutlet weak var Challenges: UILabel!
    @IBOutlet weak var DetailLikesLabel: UILabel!
    
    @IBOutlet weak var AboutTheGameImageView: UIImageView!
    // UPCOMING TOURNAMENTS
    @IBOutlet weak var UpComingTournamentsCollectionView: UICollectionView!
    
    // Bottom Button  CHALANGES and VIEW MORE GAMES
    @IBOutlet weak var ChalangesView: UIView!
    @IBOutlet weak var ViewMoreGame: UIView!
    
    @IBOutlet weak var popUpLikeLabel: UILabel!
    
    
    var user_id = ""
    var game_id = ""
    var Game_Title = ""
    var Game_Image_url = ""
    var tournamentArray = [Any]()
    var arrLikesMember:NSArray = []
    var arrTeamsList:NSArray = []
    var TeamType = false
    
     // MARK:- Infinite Scroll VARIABLES
    var isMoreDataLoading = false
    var loadingMoreView:InfiniteScrollActivityView?
    var pageNumber = 0
    var notificationArray  = [NotificationData]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.BAckgroundView.isHidden = true
        self.LikeSListView.isHidden = true
        user_id = UserDefaults.standard.value(forKey: "user_id") as! String
       LikesListTableVIew.separatorStyle = .none
        print("user_id::::::::::::::::::",self.user_id,"::game_id:::::::",self.game_id)
        self.When_viewDidLoads()
        // Do any additional setup after loading the view.
        
        
          // MARK:- Infinite Scroll viewDidLoad
         //  Set up Infinite Scroll loading indicator
        let frame = CGRect(x: 0, y: LikesListTableVIew.contentSize.height, width: LikesListTableVIew.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
        loadingMoreView = InfiniteScrollActivityView(frame: frame)
        loadingMoreView!.isHidden = true
        LikesListTableVIew.addSubview(loadingMoreView!)
        
        var insets = LikesListTableVIew.contentInset
        insets.bottom += InfiniteScrollActivityView.defaultHeight
        LikesListTableVIew.contentInset = insets
    }
    
    
    @IBAction func openLIkesView(_ sender: Any) {
            TeamType = false
        self.BAckgroundView.isHidden = false
        self.LikeSListView.isHidden = false
        self.ToGetLikesMemberList(game_id:self.game_id)
    }
    
    @IBAction func close(_ sender: Any) {
        self.BAckgroundView.isHidden = true
        self.LikeSListView.isHidden = true
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let touch: UITouch = touches.first!
        if touch.view != BAckgroundView
        {
            self.BAckgroundView.isHidden = true
            self.LikeSListView.isHidden = true
         }
    }
    override func viewWillAppear(_ animated: Bool) {
      
        if Game_Image_url != ""{
        let ProfileUrl = URL(string:Game_Image_url)
        self.CoverImage?.kf.setImage(with: ProfileUrl,
                                       placeholder:UIImage(named: "vikings-war-of-clans_min"),
                                       options: [.transition(.fade(1))],
                                       progressBlock: nil,
                                       completionHandler: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        print("self.tournamentArray.count:",self.tournamentArray.count)
        return self.tournamentArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let dict = self.tournamentArray[indexPath.row] as! NSDictionary
        let cell = UpComingTournamentsCollectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingTournamentCell", for: indexPath) as! UpcomingTournamentCell
        cell.CellJoinNowButton.tag = indexPath.row
        cell.CellJoinNowView.layer.cornerRadius = 15
        cell.CellDate.text = dict.value(forKey: "TournamentDate") as! String
        cell.CellEntryFees.text =  String(describing: dict.value(forKey: "TournamentEntryFees")!)
        cell.CellTitle.text = dict.value(forKey: "TournamentTitle") as! String
        cell.CellPrize.text =  String(describing: dict.value(forKey: "TournamentWinnerPrize")!)
         cell.CelICoverImage.clipsToBounds = true
        let url = URL(string: dict.value(forKey: "TournamentLogo") as! String)
        cell.CelICoverImage?.kf.setImage(with: url,
                                         placeholder: UIImage(named: "img"),
                                         options: [.transition(.fade(1))],
                                         progressBlock: nil,
                                         completionHandler: nil)
        return cell
    }
    @IBAction func goToTournamentDetails(_ sender: UIButton) {
        print("Task indexPath.row:",sender.tag)
        let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
        let vc : TournamentDetailsVC = mainStoryboard.instantiateViewController(withIdentifier: "TournamentDetailsVC") as! TournamentDetailsVC
        let obj = self.tournamentArray[sender.tag] as! NSDictionary
        vc.tournament_id = obj["TournamentID"] as! String
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.teamDataArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
//    "TeamID": "2299",
//    "TeamName": "XI Team",
//    "TeamImage": "http://iglnetwork.com/beta/assets/uploads/teams/156481686613.png"
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
            cell.selectionStyle = .none
            let obj = self.teamDataArray[indexPath.row] as! TeamModel
        if TeamType == true{
            cell.UserNameLabel.text = obj.TeamName
            let url1 = URL(string:obj.TeamImage)
            cell.ProfileImageView.kf.setImage(with: url1,
                                              placeholder:UIImage(named: "placeholder"),
                                              options: [.transition(.fade(1))],
                                              progressBlock: nil,
                                              completionHandler: nil)
            print("TeamName TeamName")
        }else{
            print("username username")
            cell.UserNameLabel.text = obj.TeamName
            let url1 = URL(string:obj.TeamImage)
            cell.ProfileImageView.kf.setImage(with: url1,
                                              placeholder:UIImage(named: "placeholder"),
                                              options: [.transition(.fade(1))],
                                              progressBlock: nil,
                                              completionHandler: nil)
        }
        cell.ProfileImageView.layer.cornerRadius = cell.ProfileImageView.frame.height/2
        cell.ProfileImageView.clipsToBounds = true
        return cell
      
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.LikesListTableVIew{
            if self.TeamType == false{
                let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
                print("Task indexPath.row:",indexPath.row)
                let vc : PersonalProfileViewController = mainStoryboard.instantiateViewController(withIdentifier: "PersonalProfileViewController")as! PersonalProfileViewController
                let obj = self.teamDataArray[indexPath.row] as! TeamModel
                let userid  = obj.TeamID
                vc.otherUserId = userid
                vc.COmingFromLandingScreen = false
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                let obj = self.teamDataArray[indexPath.row] as! TeamModel
                let userid  = obj.TeamID
                let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
                let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"TeamDeatilsViewController") as! TeamDeatilsViewController
                SwreavelObj.team_id = userid
                self.navigationController?.pushViewController(SwreavelObj, animated: true)
            }
           
        }
    }
    
      // MARK:- Infinite Scroll scrollViewDidScroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
           if TeamType == true{
            
            if (!isMoreDataLoading) {
                // Calculate the position of one screen length before the bottom of the results
                let scrollViewContentHeight = LikesListTableVIew.contentSize.height
                let scrollOffsetThreshold = scrollViewContentHeight - LikesListTableVIew.bounds.size.height
                
                // When the user has scrolled past the threshold, start requesting
                if(scrollView.contentOffset.y > scrollOffsetThreshold && LikesListTableVIew.isDragging) {
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
      
    }
    
    func loadMoreData()
    {
        // Call API
        print("Load More.......................................")
        ToGetGamesTeamListByPage()
        
    }
    
    var teamDataArray = [TeamModel]()
    
    func ToGetLikesMemberList(game_id:String) {
        var DicInput = [String:AnyObject]()
        DicInput = ["game_id":game_id as AnyObject]
        print("input dicnatioary is ",DicInput)
        WebHelper.requestPostUrl(strURL: GlobalConstant.get_gamelikememberlist, Dictionary: DicInput, Success: {success in
            let status = String(describing:success.value(forKey: "status")!)
            if status == "1"{
               let arr = success.value(forKey: "Userlist") as! NSArray
               self.teamDataArray.removeAll()
                for i in 0..<arr.count{
                   let teamObj = TeamModel()
                    let dict = arr[i] as! NSDictionary
                    teamObj.TeamID = Global.getStringValue(dict.value(forKey: "id") as AnyObject)
                    teamObj.TeamName = Global.getStringValue(dict.value(forKey: "username") as AnyObject)
                    teamObj.TeamImage = Global.getStringValue(dict.value(forKey: "UserProfileImage") as AnyObject)
                   self.teamDataArray.append(teamObj)
                }
                
                
                self.LikesListTableVIew.reloadData()
                //self.BAckgroundView.isHidden = false
                //self.LikeSListView.isHidden = false
            }else{
                self.teamDataArray.removeAll()
                self.LikesListTableVIew.reloadData()
            }
        }, Failure: {failler in
            
        })
    }
    
   func ToGetGamesTeamList() {
        var DicInput = [String:AnyObject]()
        DicInput = ["game_id":game_id as AnyObject,"PNO":"0" as AnyObject]
        print("input dicnatioary is ",DicInput)
        WebHelper.requestPostUrl(strURL: GlobalConstant.get_allgameteams, Dictionary: DicInput, Success: {success in
            let status = String(describing:success.value(forKey: "status")!)
            if status == "1"{
                let arr = success.value(forKey: "TeamList") as! NSArray
                
                self.teamDataArray.removeAll()
                for i in 0..<arr.count{
                    let teamObj = TeamModel()
                    let dict = arr[i] as! NSDictionary
                    teamObj.TeamID = Global.getStringValue(dict.value(forKey: "TeamID") as AnyObject)
                    teamObj.TeamName = Global.getStringValue(dict.value(forKey: "TeamName") as AnyObject)
                    teamObj.TeamImage = Global.getStringValue(dict.value(forKey: "TeamImage") as AnyObject)
                    self.teamDataArray.append(teamObj)
                }
                
                
                
                self.LikesListTableVIew.reloadData()
                //self.BAckgroundView.isHidden = false
                //self.LikeSListView.isHidden = false
            }else{
                 self.teamDataArray.removeAll()
                self.LikesListTableVIew.reloadData()
            }
        }, Failure: {failler in
            
        })
    }
    
    func ToGetGamesTeamListByPage() {
         self.pageNumber += 1
        var DicInput = [String:AnyObject]()
        DicInput = ["game_id":game_id as AnyObject,"PNO":self.pageNumber as AnyObject]
        print("input dicnatioary is Loading More Data ...............: ",DicInput)
        WebHelper.requestPostUrl(strURL: GlobalConstant.get_allgameteams, Dictionary: DicInput, Success: {success in
            let status = String(describing:success.value(forKey: "status")!)
            if status == "1"{
                let arr = success.value(forKey: "TeamList") as! NSArray
                for i in 0..<arr.count{
                    let teamObj = TeamModel()
                    let dict = arr[i] as! NSDictionary
                    teamObj.TeamID = Global.getStringValue(dict.value(forKey: "TeamID") as AnyObject)
                    teamObj.TeamName = Global.getStringValue(dict.value(forKey: "TeamName") as AnyObject)
                    teamObj.TeamImage = Global.getStringValue(dict.value(forKey: "TeamImage") as AnyObject)
                    self.teamDataArray.append(teamObj)
                }
                self.isMoreDataLoading = false
                
                self.LikesListTableVIew.reloadData()
                // Stop the loading indicator
                self.loadingMoreView!.stopAnimating()
                
                print("Array Count :::::::::",self.teamDataArray.count,":::::::::::::::::::::::::::")
                
                
            }else{
                 self.isMoreDataLoading = false
                 self.loadingMoreView!.stopAnimating()
                //self.arrLikesMember = []
              //  self.LikesListTableVIew.reloadData()
                
            }
        }, Failure: {failler in
            
        })
    }
    
    //   ===========
    
    @IBAction func Add_To_profile(_ sender: Any)
    {
        //Write here your code
        if self.AddtoprofileLabel.text != "Added To Profile"{
          self.addgametoprofile()
        }
       
    }
    
    @IBAction func Like(_ sender: Any)
    {
        // Write here your code
    
        self.gamelike()
    }
    
    @IBAction func Join_Now(_ sender: Any)
    {
        // Write here your code
    }
    
    @IBAction func chalanges(_ sender: Any)
    {
        //        let obj = UIStoryboard(name: "Main", bundle: nil)
        //        let vc = obj.instantiateViewController(withIdentifier:"ChallengeRMadeViewController") as! ChallengeRMadeViewController
        //        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func View_More_Games(_ sender: Any)
    {
        
        //        let obj = UIStoryboard(name: "Main", bundle: nil)
        //        let vc = obj.instantiateViewController(withIdentifier:"GameListingVC") as! GameListingVC
        //        self.present(vc, animated: true, completion: nil)
    }
    
    
   
    @IBAction func Next(_ sender: Any)
    {
       if self.tournamentArray.count != 0
       {
         self.scrollToPreviousOrNextCell(direction: "Next")
        }
       
    }
    
    @IBAction func Previous(_ sender: Any)
    {
        if self.tournamentArray.count != 0
        {
        self.scrollToPreviousOrNextCell(direction: "Previous")
        }
    }
    
    // Scroll Table Viewe to Botttom  of last data Entered
    func scrollToPreviousOrNextCell(direction: String) {
        
        DispatchQueue.global(qos: .background).async {
            
            DispatchQueue.main.async {
                
                let firstIndex = 0
                let lastIndex = self.tournamentArray.count - 1  //(self.datasource?.count)! - 1
                
                let visibleIndices = self.UpComingTournamentsCollectionView.indexPathsForVisibleItems
                
                let nextIndex = visibleIndices[0].row + 1
                let previousIndex = visibleIndices[0].row - 1
                
                let nextIndexPath: IndexPath = IndexPath.init(item: nextIndex, section: 0)
                let previousIndexPath: IndexPath = IndexPath.init(item: previousIndex, section: 0)
                
                if direction == "Previous" {
                    
                    if previousIndex < firstIndex {
                        
                        
                    } else {
                        
                        self.UpComingTournamentsCollectionView.scrollToItem(at: previousIndexPath, at: .centeredHorizontally, animated: true)
                    }
                    
                } else if direction == "Next" {
                    
                    if nextIndex > lastIndex {
                        
                        
                    } else {
                        
                        self.UpComingTournamentsCollectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    
    
    func When_viewDidLoads()
    {
        self.CoverImage.clipsToBounds = true
        self.gamedetails()
        self.get_gamesupcomingtournaments()
        LikeView.layer.cornerRadius = 15
        AddToProfileView.layer.cornerRadius = 15
        ChalangesView.layer.cornerRadius = 15
        ViewMoreGame.layer.cornerRadius = 15
    }
    
    @IBAction func BackAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func ViewMoreGames(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ChallengeAction(_ sender: Any) {
        let StoryBoardObj = UIStoryboard(name: "Main", bundle: nil)
        let obj = StoryBoardObj.instantiateViewController(withIdentifier: "ChooseTeamViewController") as! ChooseTeamViewController
        obj.Game_Id = self.game_id
        FindChallengerViewController.Game_id = self.game_id
        self.navigationController?.pushViewController(obj, animated: true)
    }
    
    // ============ API Calling ============
   
    func gamedetails()
    {
        var dictPost:[String: AnyObject]!
        dictPost = ["user_id":self.user_id as AnyObject,"game_id":self.game_id as AnyObject]
        print("Dictionary:",dictPost)
        
        WebHelper.requestPostUrl(strURL: GlobalConstant.gamedetails, Dictionary: dictPost, Success:{
            success in
            let status = success.object(forKey: "status") as! String
            print("success:",success)
            /// Result fail
            if status == "0"
            {
            Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage: success.object(forKey: "msg") as! String)
            }
                /// Result success
            else if status == "1"
            {
                let Dict = success.object(forKey: "GameDetails") as! NSDictionary
                self.descriptionsLabel.text = (Dict.value(forKey: "GameDescription") as! String)
                let GameID = (Dict.value(forKey: "GameID") as! String)
                self.game_id = (Dict.value(forKey: "GameID") as! String)
                self.ToGetLikesMemberList(game_id:GameID)
                self.Game_Title = (Dict.value(forKey: "GameTitle") as! String)
                self.LikeLabel.text = "Like (\(String(describing:  Dict.value(forKey: "Glikecount")!)))"
             self.Likeslabel.text =  String(describing:  Dict.value(forKey: "Glikecount")!)
               let likecount = String(describing:  Dict.value(forKey: "Glikecount")!)
                if likecount == "0"{
                    self.LikeLabel.text = "0 LIKES"
                    self.DetailLikesLabel.text = "LIKES"
                }else if likecount == "1"{
                     self.LikeLabel.text = "\(likecount) LIKE"
                     self.DetailLikesLabel.text = "LIKE"
                }else if likecount == ""{
                     self.LikeLabel.text = "0 LIKES"
                     self.DetailLikesLabel.text = "LIKES"
                }else{
                     self.LikeLabel.text = "\(likecount) LIKES"
                     self.DetailLikesLabel.text = "LIKES"
                }
                
                self.Challenges.text =  String(describing:  Dict.value(forKey: "ChallengeCount")!)
                self.TeamsLbel.text =  String(describing:  Dict.value(forKey: "TeamCount")!)
                self.TounamentsLabel.text =  String(describing:  Dict.value(forKey: "TournamentCount")!)
                self.AddtoprofileLabel.text = Dict.value(forKey: "isadded") as! String
                self.title = Dict.value(forKey: "GameTitle") as! String
                let imagepath = Dict.value(forKey: "GameBannerImage") as! String
                self.CoverImage.clipsToBounds = true
                let url1 = URL(string:imagepath)
                self.CoverImage?.kf.setImage(with: url1,
                                             placeholder:UIImage(named: "placeholder"),
                                             options: [.transition(.fade(1))],
                                             progressBlock: nil,
                                             completionHandler: nil)
                let imagecontentPath = Dict.value(forKey: "GameContentImage") as! String
                let url11 = URL(string:imagecontentPath)
                self.AboutTheGameImageView?.kf.setImage(with: url11,
                                             placeholder:UIImage(named: "placeholder"),
                                             options: [.transition(.fade(1))],
                                             progressBlock: nil,
                                             completionHandler: nil)
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
    @IBAction func GOToChallenges(_ sender: Any) {
         let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
        let vc : GamesDetailsChallenges = mainStoryboard.instantiateViewController(withIdentifier: "GamesDetailsChallenges")as! GamesDetailsChallenges
        vc.Game_ID = self.game_id
          vc.title = "\(self.Game_Title.uppercased()) CHALLENGES"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func GoToTournamentAction(_ sender: Any) {
         let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
        let vc : GameDetailsTournamnetList = mainStoryboard.instantiateViewController(withIdentifier: "GameDetailsTournamnetList") as! GameDetailsTournamnetList
        vc.game_id = self.game_id
        vc.title = "\(self.Game_Title.uppercased()) TOURNAMENTS"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    @IBAction func GotoTeamsActions(_ sender: Any) {
          self.popUpLikeLabel.text! = "TEAMS"
         TeamType = true
        self.ToGetGamesTeamList()
        self.BAckgroundView.isHidden = false
        self.LikeSListView.isHidden = false
//         let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
//        let vc : ProfileOpponentsVC = mainStoryboard.instantiateViewController(withIdentifier: "ProfileOpponentsVC")as! ProfileOpponentsVC
//
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func LikesListAction(_ sender: Any) {
        self.popUpLikeLabel.text! = "LIKES"
         TeamType = false
        self.BAckgroundView.isHidden = false
        self.LikeSListView.isHidden = false
        self.ToGetLikesMemberList(game_id:self.game_id)
    }
    
    
    func gamelike()
    {
        var dictPost:[String: AnyObject]!
        dictPost = ["user_id":self.user_id as AnyObject,"game_id":self.game_id as AnyObject]
        print("Dictionary:",dictPost)
        
        WebHelper.requestPostUrl(strURL: GlobalConstant.gamelike, Dictionary: dictPost, Success:{
            success in
            let status = success.object(forKey: "status") as! String
            print("success:",success)
            /// Result fail
            if status == "0"
            {
                Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage: success.object(forKey: "msg") as! String)
            }
                /// Result success
            else if status == "1"
            {
                 self.LikeLabel.text = "Like (\(String(describing:success.object(forKey: "Glike") as! String)))"
               // self.Likeslabel.text =  String(describing: success.object(forKey: "Glike") as! String)
                let likecount = String(describing:  success.value(forKey: "Glike")!)
                if likecount == "0"{
                    self.LikeLabel.text = "0 LIKES"
                }else if likecount == "1"{
                    self.LikeLabel.text = "\(likecount) LIKE"
                }else if likecount == ""{
                    self.LikeLabel.text = "0 LIKES"
                }else{
                    self.LikeLabel.text = "\(likecount) LIKES"
                }
              
                self.ToGetLikesMemberList(game_id:self.game_id)
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
    
    
 
    func addgametoprofile()
    {
        var dictPost:[String: AnyObject]!
        dictPost = ["user_id":self.user_id as AnyObject,"game_id":self.game_id as AnyObject,"usergame_id":self.game_id as AnyObject]
        print("Dictionary:",dictPost)
        
        WebHelper.requestPostUrl(strURL: GlobalConstant.addgametoprofile, Dictionary: dictPost, Success:{
            success in
            let status = success.object(forKey: "status") as! String
            print("success:",success)
            /// Result fail
            if status == "0"
            {
                Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage: success.object(forKey: "msg") as! String)
            }
                /// Result success
            else if status == "1"
            {
                self.AddtoprofileLabel.text = success.value(forKey: "isadded") as! String
//               Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage: success.object(forKey: "msg") as! String)
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
   
    func get_gamesupcomingtournaments()
    {
        var dictPost:[String: AnyObject]!
        dictPost = ["user_id":self.user_id as AnyObject,"game_id":self.game_id as AnyObject]
        print("Dictionary:",dictPost)
        
        WebHelper.requestPostUrl(strURL: GlobalConstant.get_gamesupcomingtournaments, Dictionary: dictPost, Success:{
            success in
            let status = success.object(forKey: "status") as! String
            print("success:",success)
            /// Result fail
            if status == "0"
            {
                //Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage: success.object(forKey: "msg") as! String)
            }
                /// Result success
            else if status == "1"
            {
                self.tournamentArray = (success.object(forKey: "TournamentList") ) as! [Any]
               
               
                self.UpComingTournamentsCollectionView.reloadData()
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
    
    @IBAction func NotiAction(_ sender:Any)
    {
        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
        let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(SwreavelObj, animated: true)
    }
    
    
}

extension UIImageView {
    var contentClippingRect: CGRect {
        guard let image = image else { return bounds }
        guard contentMode == .scaleAspectFit else { return bounds }
        guard image.size.width > 0 && image.size.height > 0 else { return bounds }
        
        let scale: CGFloat
        if image.size.width > image.size.height {
            scale = bounds.width / image.size.width
        } else {
            scale = bounds.height / image.size.height
        }
        
        let size = CGSize(width: image.size.width * scale, height: image.size.height * scale)
        let x = (bounds.width - size.width) / 2.0
        let y = (bounds.height - size.height) / 2.0
        
        return CGRect(x: x, y: y, width: size.width, height: size.height)
    }
}
