//
//  UpComingTournamentVC.swift
//  IGL
//
//  Created by Mac Min on 28/09/18.
//  Copyright © 2018 Mac Min. All rights reserved.
//

import UIKit


class TournamentModel
{
    
//    var TournamentDate = ""
//    var TournamentEntryFees = ""
//    var TournamentID = ""
//    var TournamentLogo = ""
//    var TournamentTitle = ""
//    var TournamentWinnerPrize = ""
    
    var Tournament2RunnerUpPrize = ""
    var TournamentDate = ""
   
    var TournamentID = ""
    var TournamentLogo = ""
    var TournamentRunnerup1Points = ""
    var TournamentRunnerup2Points = ""
    var TournamentRunnerupPrize = ""
    var TournamentTitle = ""
    var TournamentWinnerPoints = ""
    var TournamentWinnerPrize = ""
    
    var GameID = ""
    var GameName = ""
    var PlatformName = ""
    var PlatformID = ""
    var Teamjoined = ""
    var TournamentEntryFees = ""
}




class UPComingTMCell: UICollectionViewCell {
    @IBOutlet weak var TMBannerImageView:UIImageView!
    @IBOutlet weak var GameTitleLabel:UILabel!
    @IBOutlet weak var TMDateLabel:UILabel!
    @IBOutlet weak var TMPrizeCoins:UILabel!
    @IBOutlet weak var JoinNowView:UIView!
    @IBOutlet weak var JoinNowButton:UIButton!
    
    
    @IBOutlet weak var teamJoinedLabel: UILabel!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var platformName: UILabel!
}


class UpComingTournamentVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,SWRevealViewControllerDelegate, UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegateFlowLayout {
    
   // @IBOutlet weak var NavViewBar: UINavigationBar!
   
    @IBOutlet weak var MenuButton: UIBarButtonItem!
   
   // @IBOutlet weak var ButtomLayoutOfView: NSLayoutConstraint!
   // @IBOutlet weak var ButtomLayoutOfcollectionview: NSLayoutConstraint!
    @IBOutlet weak var pullScroll: UIScrollView!
    
    // Select Plateform View
    @IBOutlet weak var SelectPlateformView: UIView!
    @IBOutlet weak var SelectGameView: UIView!
    @IBOutlet weak var SelectPlateformTV: UITableView!
    @IBOutlet weak var SelectGameTV: UITableView!
    @IBOutlet weak var selectPlateformTextField: UITextField!
    @IBOutlet weak var selectGameTextField: UITextField!
    @IBOutlet weak var SelectPlateformContainerView: UIView!
    @IBOutlet weak var SelectGameContainerView: UIView!
   
   // @IBOutlet weak var PastTournamentView: UIView!
   
    @IBOutlet weak var MessageLabel: UILabel!
    
    @IBOutlet weak var UpComingTMCollectionView:UICollectionView!
    @IBOutlet var Heightof: [NSLayoutConstraint]!
    
    @IBOutlet weak var HeightOfthemainView: NSLayoutConstraint!
   
    @IBOutlet weak var upcomingTournament: UIButton!
    @IBOutlet weak var pastTournament: UIButton!
    
    @IBOutlet weak var TabView: UIView!
    @IBOutlet weak var bgView: UIView!
    
    // Pull to refresh
    // MARK:- it is for Refresh TableView ====================
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(UpComingTournamentVC.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.red
        let attributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: attributes)
       // refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
    
        return refreshControl
    }()
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        if ispastTournamentAction{
            get_pasttournamentlist()
        }else{
            get_tournamentlist()
        }
        refreshControl.endRefreshing()
    }
    
    
    
    
    
    
    var PlatformlistArray = [Any]()
    var GameListArray = [Any]()
   // var TournamentList:NSArray = []
    
    var tournamentListArr = [TournamentModel]()
    
    var platform_id = ""
    var game_id = ""
    var user_id = ""
    var PNO = 0 // Page number
  
    
     //var XPhoneHeight:CGFloat = 64;
    override func viewDidLoad() {
        super.viewDidLoad()
        bgView.isUserInteractionEnabled = true
         bgView.isHidden = true
        self.pullScroll.addSubview(self.refreshControl)
       // self.UpComingTMCollectionView.addSubview(self.refreshControl)
        ///upcomingTournament.roundedButtonLeft()
        //pastTournament.roundedButtonRight()
        TabView.layer.cornerRadius = 15
        TabView.backgroundColor = UIColor.clear
        self.tabBarController?.selectedIndex = 4
        SelectPlateformContainerView.layer.cornerRadius = 15
        SelectGameContainerView.layer.cornerRadius = 15
         self.SelectPlateformView.isHidden = true
         self.SelectGameView.isHidden = true
       // PastTournamentView.layer.cornerRadius = 15
         user_id = UserDefaults.standard.value(forKey: "user_id") as! String
         self.MessageLabel.isHidden = true
        get_platforms()
        get_games()
        get_tournamentlist()
        CellLayout()
        OpenSideMenu()
      
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("iPhone 5 or 5S or 5C")
            case 1334:
                print("iPhone 6/6S/7/8")
            case 2208:
                print("iPhone 6+/6S+/7+/8+")
            case 2436:
                print("iPhone X")
            default:
                print("unknown")
              
                
            }
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapBGView))
        bgView.addGestureRecognizer(tap)
 }
    
    @objc func tapBGView()
    {
        print("Tappedd......")
        bgView.isHidden = true
        self.SelectPlateformView.isHidden = true
        open = true
        
        self.SelectGameView.isHidden = true
        openGame = true
    }
    
    func OpenSideMenu()  {
        //Actions for the SideMenu.
        MenuButton.target = revealViewController()
        MenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        //set the delegate to teh SWRevealviewcontroller
        revealViewController().delegate = self
        //self.revealViewController().rearViewRevealWidth = 240
        if self.revealViewController() != nil {
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
    }                          //**** Here is IBActons of all Storyboad Objects *****//
    
    
    //for dissable homescreen
    public func revealController(_ revealController: SWRevealViewController!, willMoveTo position: FrontViewPosition) {
        
        let tagId = 112151
        
        print("revealController delegate called")
        
        if revealController.frontViewPosition == FrontViewPosition.right {
            
            let lock = self.view.viewWithTag(tagId)
            
            UIView.animate(withDuration: 0.25, animations: {
                
                lock?.alpha = 0
                
            }, completion: {(finished: Bool) in
                
                lock?.removeFromSuperview()
            })
            lock?.removeFromSuperview()
        } else if revealController.frontViewPosition == FrontViewPosition.left {
            
            let lock = UIView(frame: self.view.bounds)
            
            lock.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            lock.tag = tagId
            
            lock.alpha = 0
            
            lock.backgroundColor = UIColor.black
            
            lock.addGestureRecognizer(UITapGestureRecognizer(target: self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:))))
            
            self.view.addSubview(lock)
            
            UIView.animate(withDuration: 0.75, animations: {
                
                lock.alpha = 0.333})
        }}
    
    override func viewWillAppear(_ animated: Bool) {
         OpenSideMenu()
        guard let tabBar = tabBarController?.tabBar else { return }
        tabBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        tabBar.selectionIndicatorImage = UIImage().makeImageWithColorAndSize(color: #colorLiteral(red: 0.04705882353, green: 0.09019607843, blue: 0.168627451, alpha: 1), size: CGSize(width: tabBar.frame.width/5, height: tabBar.frame.height))
        tabBar.unselectedItemTintColor = UIColor.white
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if tournamentListArr.count == 0{
            self.MessageLabel.isHidden = false
            self.UpComingTMCollectionView.isHidden = true
        }else{
            self.MessageLabel.isHidden = true
            self.UpComingTMCollectionView.isHidden = false
        }
        
        if tournamentListArr.count % 2 == 0{
             self.HeightOfthemainView.constant = CGFloat((self.tournamentListArr.count / 2 * 318) + 230)
        }
        else{
               self.HeightOfthemainView.constant = CGFloat(((self.tournamentListArr.count + 1) / 2 * 318) + 230)
        }
       
        return tournamentListArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UPComingTMCell", for: indexPath) as! UPComingTMCell
        let obj = tournamentListArr[indexPath.row] as! TournamentModel
        cell.GameTitleLabel.text = obj.TournamentTitle
        cell.TMPrizeCoins.text = obj.TournamentWinnerPrize+" IGL COINS"
        cell.TMDateLabel.text = obj.TournamentDate
        let url = URL(string:obj.TournamentLogo)
         cell.TMBannerImageView.clipsToBounds = true
        cell.TMBannerImageView?.kf.setImage(with: url,
                                         placeholder:UIImage(named: "placeholder"),
                                         options: [.transition(.fade(1))],
                                         progressBlock: nil,
                                         completionHandler: nil)
            
        cell.JoinNowView.layer.cornerRadius = 15
      
        cell.JoinNowButton.tag = indexPath.row
        //cell.selectionStyle = .none
        cell.JoinNowButton.addTarget(self,
                                          action: #selector(self.GoToOtherView),
                                          for: .touchUpInside)
        cell.gameNameLabel.text! = obj.GameName
        cell.platformName.text! = obj.PlatformName
        cell.teamJoinedLabel.text! = obj.Teamjoined + " / 8"  // 8  This is Static
        return cell
    }
    
    
  
    
    
    
    @objc func GoToOtherView(sender : UIButton){
        print("Task indexPath.row:",sender.tag)
        let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
        let vc : TournamentDetailsVC = mainStoryboard.instantiateViewController(withIdentifier: "TournamentDetailsVC") as! TournamentDetailsVC
        let obj = tournamentListArr[sender.tag] as! TournamentModel
        vc.tournament_id = obj.TournamentID
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
       
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        return true
    }
        

    
    // =============================
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == SelectPlateformTV
        {
             return self.PlatformlistArray.count
        }
        else
        {
             return self.GameListArray.count
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if tableView == SelectPlateformTV
        {
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            let Dict = PlatformlistArray[indexPath.row] as! NSDictionary
           // cell.textLabel?.font = UIFont(name: "system", size: 10.0)
            cell.textLabel?.text = Dict.value(forKey: "PlatformName") as! String
            
            cell.textLabel?.numberOfLines = 0
            return cell
        }
        else
        {
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            let Dict = GameListArray[indexPath.row] as! NSDictionary
            cell.textLabel?.text = Dict.value(forKey: "GameTitle") as! String
           
            cell.textLabel?.numberOfLines = 0
            return cell
        }
       
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == SelectPlateformTV
        {
            let Dict = PlatformlistArray[indexPath.row] as! NSDictionary
            self.selectPlateformTextField.text = Dict.value(forKey: "PlatformName") as! String
            self.platform_id = String(describing: Dict.value(forKey: "PlatformID")!)
            self.SelectPlateformView.isHidden = true
            open = true
            print("data from the server is-------", self.platform_id)
            //self.get_tournamentlist()
        }
        else
        {
            let Dict = GameListArray[indexPath.row] as! NSDictionary
            self.selectGameTextField.text = Dict.value(forKey: "GameTitle") as! String
            self.game_id =  String(describing: Dict.value(forKey: "GameID")!)
            self.SelectGameView.isHidden = true
            openGame = true
           // self.get_tournamentlist()
        }
        
        self.bgView.isHidden = true
        if ispastTournamentAction{
            get_pasttournamentlist()
        }else{
            get_tournamentlist()
        }
       
    }
    
    var open = true
    
    @IBAction func ActionOpenPlateformList(_ sender: Any)
    {
        if open == true
        {
             self.bgView.isHidden = false
             self.SelectPlateformView.isHidden = false
             open = false
        }
        else
        {
            bgView.isHidden = true
            self.SelectPlateformView.isHidden = true
            open = true
        }
        
    }
    
    var openGame = true
    
    @IBAction func ActionOpenGameList(_ sender: Any)
    {
        if openGame == true
        {
            self.bgView.isHidden = false
            self.SelectGameView.isHidden = false
            openGame = false
        }
        else
        {
            bgView.isHidden = true
            self.SelectGameView.isHidden = true
            openGame = true
        }
    }
    
    
    

    
    // ============ API Calling ============
    
    func get_platforms()
    {
        var dictPost:[String: AnyObject]!
        dictPost = ["platform":"" as AnyObject]
        print("Dictionary:",dictPost)
        
        WebHelper.requestPostUrl(strURL: GlobalConstant.get_platforms, Dictionary: dictPost, Success:{
            success in
            let status = success.object(forKey: "status") as! String
           // print("success:",success)
            /// Result fail
            if status == "0"
            {
                
                //Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage: success.object(forKey: "msg") as! String)
            }
                /// Result success
            else if status == "1"
            {
                //Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage: success.object(forKey: "msg") as! String)
                self.PlatformlistArray = success.object(forKey: "Platformlist") as! [Any]
                self.SelectPlateformTV.reloadData()
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
    

    func get_games()
    {
        var dictPost:[String: AnyObject]!
        dictPost = ["games":"" as AnyObject]
        print("Dictionary:",dictPost)
        
        WebHelper.requestPostUrl(strURL: GlobalConstant.get_games, Dictionary: dictPost, Success:{
            success in
            let status = success.object(forKey: "status") as! String
            //print("success:",success)
            /// Result fail
            if status == "0"
            {
                
                //Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage: success.object(forKey: "msg") as! String)
            }
                /// Result success
            else if status == "1"
            {
                //Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage: success.object(forKey: "msg") as! String)
                self.GameListArray = success.object(forKey: "Gamelist") as! [Any]
                self.SelectGameTV.reloadData()
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
    
    func get_tournamentlist()
    {
       var dictPost:[String: AnyObject]!
      dictPost = ["user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject,"game_id":self.game_id as AnyObject,"platform_id":self.platform_id as AnyObject,"PNO":self.PNO as AnyObject]
          // dictPost = ["user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject]
        print("ACTIVE Tournament ..Dictionary:****************************************************************",dictPost)
        
        WebHelper.requestPostUrl(strURL: GlobalConstant.get_tournamentlist, Dictionary: dictPost, Success:{
            success in
            let status = success.object(forKey: "status") as! String
            print("ACTIVE Tournament List of Tournament is ------>>>>>>>>>>>>>>:",success)
            /// Result fail
            if status == "0"
            {
            //Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage: success.object(forKey: "msg") as! String)
                 self.tournamentListArr.removeAll()
                self.UpComingTMCollectionView.reloadData()
            }
                /// Result success
            else if status == "1"
            {
               // self.TournamentList = []
                self.tournamentListArr.removeAll()
                let arr = success.object(forKey: "Tournamentlist") as! NSArray
                
                for i in 0..<arr.count
                {
                    let obj = TournamentModel()
                    let dict = arr[i] as! NSDictionary
                    
                    obj.TournamentDate = Global.getStringValue(dict.value(forKey: "TournamentDate") as AnyObject)
                    obj.TournamentEntryFees = Global.getStringValue(dict.value(forKey: "TournamentEntryFees") as AnyObject)
                    
                    obj.TournamentID = Global.getStringValue(dict.value(forKey: "TournamentID") as AnyObject)
                    obj.TournamentLogo = Global.getStringValue(dict.value(forKey: "TournamentLogo") as AnyObject)
                    
                    obj.TournamentTitle = Global.getStringValue(dict.value(forKey: "TournamentTitle") as AnyObject)
                    obj.TournamentWinnerPrize = Global.getStringValue(dict.value(forKey: "TournamentWinnerPrize") as AnyObject)
                    
                    obj.Tournament2RunnerUpPrize = Global.getStringValue(dict.value(forKey: "Tournament2RunnerUpPrize") as AnyObject)
                    obj.TournamentRunnerup1Points = Global.getStringValue(dict.value(forKey: "TournamentRunnerup1Points") as AnyObject)
                    
                    obj.TournamentRunnerup2Points = Global.getStringValue(dict.value(forKey: "TournamentRunnerup2Points") as AnyObject)
                    obj.TournamentRunnerupPrize = Global.getStringValue(dict.value(forKey: "TournamentRunnerupPrize") as AnyObject)
                    obj.TournamentWinnerPoints = Global.getStringValue(dict.value(forKey: "TournamentWinnerPoints") as AnyObject)
                   
                    obj.GameName = Global.getStringValue(dict.value(forKey: "GameName") as AnyObject)
                    obj.GameID = Global.getStringValue(dict.value(forKey: "GameID") as AnyObject)
                    obj.PlatformName = Global.getStringValue(dict.value(forKey: "PlatformName") as AnyObject)
                    obj.PlatformID = Global.getStringValue(dict.value(forKey: "PlatformID") as AnyObject)
                    obj.Teamjoined = Global.getStringValue(dict.value(forKey: "Teamjoined") as AnyObject)
                    self.tournamentListArr.append(obj)
                }
                
                self.UpComingTMCollectionView.reloadData()
            
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
    
    
    
    func get_pasttournamentlist()
    {
        var dictPost:[String: AnyObject]!
        dictPost = ["user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject,"game_id":self.game_id as AnyObject,"platform_id":self.platform_id as AnyObject,"PNO":self.PNO as AnyObject]
        // dictPost = ["user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject]
        print("PAST Dictionary:****************************************************************",dictPost)
        
        WebHelper.requestPostUrl(strURL: GlobalConstant.get_pasttournamentlist, Dictionary: dictPost, Success:{
            success in
            let status = success.object(forKey: "status") as! String
            print("PAST List of Tournament is ------>>>>>>>>>>>>>>:",success)
            /// Result fail
            if status == "0"
            {
                //Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage: success.object(forKey: "msg") as! String)
                 self.tournamentListArr.removeAll()
                 self.UpComingTMCollectionView.reloadData()
            }
            /// Result success
            else if status == "1"
            {
              //  self.TournamentList = []
              //  self.TournamentList = success.object(forKey: "Tournamentlist") as! NSArray
               
                self.tournamentListArr.removeAll()
                let arr = success.object(forKey: "Tournamentlist") as! NSArray
                
                for i in 0..<arr.count
                {
                    let obj = TournamentModel()
                    let dict = arr[i] as! NSDictionary
                    
                    obj.TournamentDate = Global.getStringValue(dict.value(forKey: "TournamentDate") as AnyObject)
                    obj.TournamentEntryFees = Global.getStringValue(dict.value(forKey: "TournamentEntryFees") as AnyObject)
                    
                    obj.TournamentID = Global.getStringValue(dict.value(forKey: "TournamentID") as AnyObject)
                    obj.TournamentLogo = Global.getStringValue(dict.value(forKey: "TournamentLogo") as AnyObject)
                    
                    obj.TournamentTitle = Global.getStringValue(dict.value(forKey: "TournamentTitle") as AnyObject)
                    obj.TournamentWinnerPrize = Global.getStringValue(dict.value(forKey: "TournamentWinnerPrize") as AnyObject)
                    
                    obj.Tournament2RunnerUpPrize = Global.getStringValue(dict.value(forKey: "Tournament2RunnerUpPrize") as AnyObject)
                    obj.TournamentRunnerup1Points = Global.getStringValue(dict.value(forKey: "TournamentRunnerup1Points") as AnyObject)
                    
                    obj.TournamentRunnerup2Points = Global.getStringValue(dict.value(forKey: "TournamentRunnerup2Points") as AnyObject)
                    obj.TournamentRunnerupPrize = Global.getStringValue(dict.value(forKey: "TournamentRunnerupPrize") as AnyObject)
                    obj.TournamentWinnerPoints = Global.getStringValue(dict.value(forKey: "TournamentWinnerPoints") as AnyObject)
                    
                    obj.GameName = Global.getStringValue(dict.value(forKey: "GameName") as AnyObject)
                    obj.GameID = Global.getStringValue(dict.value(forKey: "GameID") as AnyObject)
                    obj.PlatformName = Global.getStringValue(dict.value(forKey: "PlatformName") as AnyObject)
                    obj.PlatformID = Global.getStringValue(dict.value(forKey: "PlatformID") as AnyObject)
                    obj.Teamjoined = Global.getStringValue(dict.value(forKey: "Teamjoined") as AnyObject)
                    self.tournamentListArr.append(obj)
                }
                
                print("Past tournament Count::::::::::::::",self.tournamentListArr.count)
                self.UpComingTMCollectionView.reloadData()
              
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
    
    
    func get_pasttournamentlistMoreData()
    {
        self.PNO += 1
        var dictPost:[String: AnyObject]!
        dictPost = ["user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject,"game_id":self.game_id as AnyObject,"platform_id":self.platform_id as AnyObject,"PNO":self.PNO as AnyObject]
        // dictPost = ["user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject]
        print("GET MOREDictionary:****************************************************************",dictPost)
        
        WebHelper.requestPostUrl(strURL: GlobalConstant.get_pasttournamentlist, Dictionary: dictPost, Success:{
            success in
            let status = success.object(forKey: "status") as! String
            print("GET MORE...List of Tournament is ------>>>>>>>>>>>>>>:",success)
            /// Result fail
            if status == "0"
            {
                //Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage: success.object(forKey: "msg") as! String)
               // self.tournamentListArr.removeAll()
                //self.UpComingTMCollectionView.reloadData()
            }
                /// Result success
            else if status == "1"
            {
                //  self.TournamentList = []
                //  self.TournamentList = success.object(forKey: "Tournamentlist") as! NSArray
                
               // self.tournamentListArr.removeAll()
                let arr = success.object(forKey: "Tournamentlist") as! NSArray
                
                for i in 0..<arr.count
                {
                    let obj = TournamentModel()
                    let dict = arr[i] as! NSDictionary
                    
                    obj.TournamentDate = Global.getStringValue(dict.value(forKey: "TournamentDate") as AnyObject)
                    obj.TournamentEntryFees = Global.getStringValue(dict.value(forKey: "TournamentEntryFees") as AnyObject)
                    
                    obj.TournamentID = Global.getStringValue(dict.value(forKey: "TournamentID") as AnyObject)
                    obj.TournamentLogo = Global.getStringValue(dict.value(forKey: "TournamentLogo") as AnyObject)
                    
                    obj.TournamentTitle = Global.getStringValue(dict.value(forKey: "TournamentTitle") as AnyObject)
                    obj.TournamentWinnerPrize = Global.getStringValue(dict.value(forKey: "TournamentWinnerPrize") as AnyObject)
                    
                    obj.Tournament2RunnerUpPrize = Global.getStringValue(dict.value(forKey: "Tournament2RunnerUpPrize") as AnyObject)
                    obj.TournamentRunnerup1Points = Global.getStringValue(dict.value(forKey: "TournamentRunnerup1Points") as AnyObject)
                    
                    obj.TournamentRunnerup2Points = Global.getStringValue(dict.value(forKey: "TournamentRunnerup2Points") as AnyObject)
                    obj.TournamentRunnerupPrize = Global.getStringValue(dict.value(forKey: "TournamentRunnerupPrize") as AnyObject)
                    obj.TournamentWinnerPoints = Global.getStringValue(dict.value(forKey: "TournamentWinnerPoints") as AnyObject)
                    
                    
                    obj.GameName = Global.getStringValue(dict.value(forKey: "GameName") as AnyObject)
                    obj.GameID = Global.getStringValue(dict.value(forKey: "GameID") as AnyObject)
                    obj.PlatformName = Global.getStringValue(dict.value(forKey: "PlatformName") as AnyObject)
                    obj.PlatformID = Global.getStringValue(dict.value(forKey: "PlatformID") as AnyObject)
                    obj.Teamjoined = Global.getStringValue(dict.value(forKey: "Teamjoined") as AnyObject)
                    
                    
                    self.tournamentListArr.append(obj)
                }
                
                print("Past tournament Count::::::::::::::",self.tournamentListArr.count)
                self.UpComingTMCollectionView.reloadData()
              
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
    
    
    
//    @IBAction func TOGetPastTournament(_ sender: Any) {
//        get_pasttournamentlist()
//    }
    
    var ispastTournamentAction = false
    @IBAction func upcomingTournamentAction(_ sender: Any) {
        // 3486CC
        resetData()
        self.upcomingTournament.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.5254901961, blue: 0.8, alpha: 1)
        self.pastTournament.backgroundColor = #colorLiteral(red: 0.1098039216, green: 0.2549019608, blue: 0.4196078431, alpha: 1)
        ispastTournamentAction = false
        get_tournamentlist()
    }
    
    @IBAction func pastTournamentAction(_ sender: Any) {
         resetData()
         self.pastTournament.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.5254901961, blue: 0.8, alpha: 1)
         self.upcomingTournament.backgroundColor = #colorLiteral(red: 0.1098039216, green: 0.2549019608, blue: 0.4196078431, alpha: 1)
         ispastTournamentAction = true
         get_pasttournamentlist()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        print("touchesBegan...........................")
        var touch: UITouch = touches.first!
        //location is relative to the current view
        // do something with the touched point
        if touch.view != SelectPlateformView || touch.view != SelectGameView
        {
            bgView.isHidden = true
            self.SelectPlateformView.isHidden = true
            open = true
            
            self.SelectGameView.isHidden = true
            openGame = true
        }
    }
    
   
    
    
    func resetData()
    {
        self.selectPlateformTextField.text = ""
        self.platform_id = ""
        self.SelectPlateformView.isHidden = true
        open = true
        
        self.selectGameTextField.text = ""
        self.game_id =  ""
        self.SelectGameView.isHidden = true
        openGame = true
    }
    

    
    
    
}
extension UpComingTournamentVC{
    
  
    @IBAction func Login(_ send: Any)
    {
        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
        let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(SwreavelObj, animated: true)
        //self.Validate_text_fields()
    }

    func CellLayout(){
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("iPhone 5 or 5S or 5C")
            case 1334:
                print("iPhone 6/6S/7/8")
            case 2208:
                print("iPhone 6+/6S+/7+/8+")
            case 2436:
                print("iPhone X")
               // XPhoneHeight = 88 + 32
                //    self.collectionViewDemo.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
                //    self.collectionViewDemo.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
                //    self.collectionViewDemo.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            //    self.collectionViewDemo.heightAnchor.constraint(equalToConstant: 300).isActive = true
            default:
                print("unknown")
            }
        }
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
      //let newHeight = height - XPhoneHeight
        layout.itemSize = CGSize(width: width/2-22, height: 300)
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 15
        UpComingTMCollectionView!.collectionViewLayout = layout
        //UpComingTMCollectionView.isScrollEnabled = false
    }
   
}
extension UIImage {
    func makeImageWithColorAndSize(color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: size.height))//CGRect(0, 0, size.width, size.height)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
extension UIButton {
    func roundedButtonLeft(){
        let maskPAth1 = UIBezierPath(roundedRect: self.bounds,
                                     byRoundingCorners: [.topLeft , .bottomLeft],
                                     cornerRadii:CGSize(width:10.0, height:10.0))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = self.bounds
        maskLayer1.path = maskPAth1.cgPath
        self.layer.mask = maskLayer1
    }
    func roundedButtonRight(){
        let maskPAth1 = UIBezierPath(roundedRect: self.bounds,
                                     byRoundingCorners: [.topRight , .bottomRight],
                                     cornerRadii:CGSize(width:10.0, height:10.0))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = self.bounds
        maskLayer1.path = maskPAth1.cgPath
        self.layer.mask = maskLayer1
    }
}
