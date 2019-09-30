//
//  GameListingVC.swift
//  IGL
//
//  Created by Mac Min on 02/10/18.
//  Copyright © 2018 Mac Min. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher


class GameListModel
{
    var ChallengeCount = ""
    var GameBannerImage = ""
    var GameID = ""
    var GameImagePath = ""
    var GamePlatform = ""
    var GamePlayers = ""
    var GamePlayersType = ""
    var GamePrizePool = ""
    var GameTitle = ""
    var TeamCount = ""
    var TournamentCount = ""
}

 // MARK:- Infinite Enum
enum LoadMoreStatus {
    case loading
    case finished
    case haveMore
}





class GameListingCell: UICollectionViewCell
{
    @IBOutlet weak var CellCoverImage: UIImageView!
    @IBOutlet weak var CellTitle: UILabel!
    @IBOutlet weak var CellPlateform: UILabel!
    @IBOutlet weak var CellPrizePool: UILabel!
    @IBOutlet weak var CellTournaments: UILabel!
    @IBOutlet weak var CellChallenges: UILabel!
    @IBOutlet weak var CellTeams: UILabel!
    @IBOutlet weak var CellKnowMoreView: UIView!
    @IBOutlet weak var CellKnowMoreButton: UIButton!
}




class GameListingVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
{
    @IBOutlet weak var GameListingCollectionView:UICollectionView!
    
    @IBOutlet weak var PcGamesButton: UIButton!
    @IBOutlet weak var PlaystationsButton: UIButton!
    @IBOutlet weak var XBoxButton: UIButton!
    @IBOutlet weak var NintendoButton: UIButton!
    @IBOutlet weak var MobileButton: UIButton!
    
    @IBOutlet weak var SelectionView: UIView!
    
    var pageNumber = 0
    var platform = "1"
   // var gameListingArray:NSArray = []
     var gameListArr = [GameListModel]()
    
     var loadingStatus = LoadMoreStatus.haveMore
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let rectShape = CAShapeLayer()
        rectShape.bounds = self.SelectionView.frame
        rectShape.position = self.SelectionView.center
        rectShape.path = UIBezierPath(roundedRect: self.SelectionView.bounds, byRoundingCorners: [.bottomLeft , .bottomRight , .topLeft,.topRight], cornerRadii: CGSize(width: 20, height: 20)).cgPath
        
        // self.SelectionView.layer.backgroundColor = UIColor.green.cgColor
        //Here I'm masking the textView's layer with rectShape layer
        self.SelectionView.layer.mask = rectShape
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        //let newHeight = height - XPhoneHeight
        layout.itemSize = CGSize(width: width/2-20, height: 315)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 10
        GameListingCollectionView!.collectionViewLayout = layout
        // Do any additional setup after loading the view.
        self.get_games()
        
         self.automaticallyAdjustsScrollViewInsets = false
      
        
        
        
    }
    
    
    
    @objc func loadMore() {
        print("loadMore..........")
//        if numberOfCells >= 40 {
//            print("loadMore numberOfCells >= 40..........")
//            // here will show untill finished number
//            loadingStatus = .finished
//            collectionView?.reloadData()
//            return
//        }
        
        // Replace code with web service and append to data source
        print("New Data Coming.....................................")
//        Timer.schedule(delay: 2) { timer in
//            self.numberOfCells += 2
//            self.collectionView?.reloadData()
//            print("New Data Came:delay: 2:::::::::::::::::::::::\n\n")
//        }
        
        self.get_More_games()
        
    }
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        //return gameListingArray.count
         return self.gameListArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        if(indexPath.row==gameListArr.count-1) {
            if loadingStatus == .haveMore {
                self.perform(#selector(loadMore), with: nil, afterDelay: 0)
            }
        }
        
        
        let cell = GameListingCollectionView.dequeueReusableCell(withReuseIdentifier: "GameListingCell", for: indexPath) as! GameListingCell
        cell.CellKnowMoreView.layer.cornerRadius = 15
        let Obj = gameListArr[indexPath.row] as! GameListModel
        cell.CellTitle.text =  Obj.GameTitle
        cell.CellPlateform.text = Obj.GamePlatform
        //cell.CellPrizePool.text = Obj.value(forKey: "GamePrizePool") as! String
        cell.CellTournaments.text = String(describing:  Obj.TournamentCount)
        cell.CellChallenges.text =  String(describing:  Obj.ChallengeCount)
        cell.CellTeams.text = String(describing:  Obj.TeamCount)
        let url = URL(string: Obj.GameImagePath)
        cell.CellCoverImage?.kf.setImage(with: url,
                                         placeholder:UIImage(named: "placeholder"),
                                         options: [.transition(.fade(1))],
                                         progressBlock: nil,
                                         completionHandler: nil)
        cell.CellKnowMoreButton.tag = indexPath.row
        cell.CellKnowMoreButton.addTarget(self,
                                          action: #selector(self.GoToOtherView),
                              for: .touchUpInside)
        
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        print("willDisplay calling::::;;;;;")
        if indexPath.row == gameListArr.count - 1 {  //numberofitem count
            print("We are at last......Cell..............................")
            updateNextSet()
        }
    }
    
    func updateNextSet(){
        print("On Completetion we are at last..............................")
        //requests another set of data (20 more items) from the server.
       // DispatchQueue.main.async(execute: GameListingCollectionView.reloadData)
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: self.view.frame.width, height: 310)
//    }
    
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        return (loadingStatus == .finished) ? CGSize.zero : CGSize(width: self.view.frame.width, height: 50)
//    }
    
    
    
    
    
    @objc func GoToOtherView(sender : UIButton){
        print(sender.tag)
        let Obj = gameListArr[sender.tag] as! GameListModel
        print("Task indexPath.row:",sender.tag)
        let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
        let vc : GameDetailsVC = mainStoryboard.instantiateViewController(withIdentifier: "GameDetailsVC")as! GameDetailsVC
        vc.game_id =  Obj.GameID
        print("game_id:", vc.game_id)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func PC_games(_ sender: Any)
    {
        platform = "1"
        PcGamesButton.backgroundColor = #colorLiteral(red: 0.1254901961, green: 0.262745098, blue: 0.3725490196, alpha: 1)
        PlaystationsButton.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.4823529412, blue: 0.7725490196, alpha: 1)
        XBoxButton.backgroundColor  =  #colorLiteral(red: 0.1764705882, green: 0.4823529412, blue: 0.7725490196, alpha: 1)
        NintendoButton.backgroundColor =  #colorLiteral(red: 0.1764705882, green: 0.4823529412, blue: 0.7725490196, alpha: 1)
        MobileButton.backgroundColor =  #colorLiteral(red: 0.1764705882, green: 0.4823529412, blue: 0.7725490196, alpha: 1)
        self.get_games()
    }
    
    @IBAction func Playstation(_ sender: Any)
    {
        platform = "2"
        PcGamesButton.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.4823529412, blue: 0.7725490196, alpha: 1)
        PlaystationsButton.backgroundColor = #colorLiteral(red: 0.1254901961, green: 0.262745098, blue: 0.3725490196, alpha: 1)
        XBoxButton.backgroundColor  =  #colorLiteral(red: 0.1764705882, green: 0.4823529412, blue: 0.7725490196, alpha: 1)
        NintendoButton.backgroundColor =  #colorLiteral(red: 0.1764705882, green: 0.4823529412, blue: 0.7725490196, alpha: 1)
        MobileButton.backgroundColor =  #colorLiteral(red: 0.1764705882, green: 0.4823529412, blue: 0.7725490196, alpha: 1)
        self.get_games()
    }
    @IBAction func XBox(_ sender: Any)
    {
        platform = "3"
        PcGamesButton.backgroundColor =  #colorLiteral(red: 0.1764705882, green: 0.4823529412, blue: 0.7725490196, alpha: 1)
        PlaystationsButton.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.4823529412, blue: 0.7725490196, alpha: 1)
        XBoxButton.backgroundColor  =  #colorLiteral(red: 0.1254901961, green: 0.262745098, blue: 0.3725490196, alpha: 1)
        NintendoButton.backgroundColor =  #colorLiteral(red: 0.1764705882, green: 0.4823529412, blue: 0.7725490196, alpha: 1)
        MobileButton.backgroundColor =  #colorLiteral(red: 0.1764705882, green: 0.4823529412, blue: 0.7725490196, alpha: 1)
        self.get_games()
    }
    
    @IBAction func Nintendo(_ sender: Any)
    {
        platform = "4"
        PcGamesButton.backgroundColor =  #colorLiteral(red: 0.1764705882, green: 0.4823529412, blue: 0.7725490196, alpha: 1)
        PlaystationsButton.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.4823529412, blue: 0.7725490196, alpha: 1)
        XBoxButton.backgroundColor  =  #colorLiteral(red: 0.1764705882, green: 0.4823529412, blue: 0.7725490196, alpha: 1)
        NintendoButton.backgroundColor =   #colorLiteral(red: 0.1254901961, green: 0.262745098, blue: 0.3725490196, alpha: 1)
        MobileButton.backgroundColor =  #colorLiteral(red: 0.1764705882, green: 0.4823529412, blue: 0.7725490196, alpha: 1)
        self.get_games()
    }
    
    @IBAction func Mobile(_ sender: Any)
    {
        platform = "5"
        PcGamesButton.backgroundColor =  #colorLiteral(red: 0.1764705882, green: 0.4823529412, blue: 0.7725490196, alpha: 1)
        PlaystationsButton.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.4823529412, blue: 0.7725490196, alpha: 1)
        XBoxButton.backgroundColor  =  #colorLiteral(red: 0.1764705882, green: 0.4823529412, blue: 0.7725490196, alpha: 1)
        NintendoButton.backgroundColor =  #colorLiteral(red: 0.1764705882, green: 0.4823529412, blue: 0.7725490196, alpha: 1)
        MobileButton.backgroundColor =  #colorLiteral(red: 0.1254901961, green: 0.262745098, blue: 0.3725490196, alpha: 1)
        self.get_games()
    }
    
    
    @IBAction func BackAction(_sender:Any)
    {
        let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
        let vc : SWRevealViewController = mainStoryboard.instantiateViewController(withIdentifier: "SW-Reaveal")as! SWRevealViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func Cell_know_more_action(_ sender: Any)
    {
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
//        let Obj = gameListingArray[indexPath.row] as! NSDictionary
//
//        print("Task indexPath.row:",indexPath.row)
//        let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
//        let vc : GameDetailsVC = mainStoryboard.instantiateViewController(withIdentifier: "GameDetailsVC")as! GameDetailsVC
//        vc.game_id =  Obj.value(forKey: "GameID")  as! String
//        print("game_id:", vc.game_id)
//        self.navigationController?.pushViewController(vc, animated: true)
        
        
        return true
    }
    
    
    @IBAction func BackAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
   
    // ============ API Calling ============
    /* Page Number
     1-PC
     2-Playstation
     3-Xbox
     4-Ninetendo
     5-Mobile
     6-VR) (optional)
     */
    func get_games()
    {
        var dictPost:[String: AnyObject]!
        dictPost = ["PNO":pageNumber as AnyObject,"platform":platform as AnyObject]
        print("Dictionary:",dictPost)
        
        WebHelper.requestPostUrl(strURL: GlobalConstant.get_games, Dictionary: dictPost, Success:{
            success in
            let status = success.object(forKey: "status") as! String
            print("status:",success)
            /// Result fail
            if status == "0"
            {
                self.gameListArr.removeAll()
                self.GameListingCollectionView.reloadData()
                //Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage: success.object(forKey: "msg") as! String)
            }
                /// Result success
            else if status == "1"
            {
                //Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage: success.object(forKey: "msg") as! String)
                //self.gameListingArray
                let arr = success.object(forKey: "Gamelist") as! NSArray
                self.gameListArr.removeAll()
                
                for i in 0..<arr.count{
                    let obj = GameListModel()
                    let dict = arr[i] as! NSDictionary
                    
                    obj.ChallengeCount = String(describing: dict.value(forKey: "ChallengeCount")!) ////
                    obj.GameBannerImage = Global.getStringValue(dict.value(forKey: "GameBannerImage") as AnyObject)
                    obj.GameID = Global.getStringValue(dict.value(forKey: "GameID") as AnyObject)
                    obj.GameImagePath = Global.getStringValue(dict.value(forKey: "GameImagePath") as AnyObject)
                    obj.GamePlatform = Global.getStringValue(dict.value(forKey: "GamePlatform") as AnyObject)
                    obj.GamePlayers = Global.getStringValue(dict.value(forKey: "GamePlayers") as AnyObject)
                    obj.GamePlayersType = Global.getStringValue(dict.value(forKey: "GamePlayersType") as AnyObject)
                    
                    obj.GamePrizePool = Global.getStringValue(dict.value(forKey: "GamePrizePool") as AnyObject)
                    obj.GameTitle = Global.getStringValue(dict.value(forKey: "GameTitle") as AnyObject)
                    obj.TeamCount = String(describing: dict.value(forKey: "TeamCount")!) //
                    obj.TournamentCount = String(describing: dict.value(forKey: "TournamentCount")!) //
                    
                     print(obj.TournamentCount)
                    print("Appending Data to Array..........................................",i)
                    self.gameListArr.append(obj)
                    print("Data Appended to Array:::::............",i)
                }
                
                
                print("Data Filled....................................")
                self.GameListingCollectionView.reloadData()
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
    
    func get_More_games()
    {
        self.pageNumber += 1
        var dictPost:[String: AnyObject]!
        dictPost = ["PNO":pageNumber as AnyObject,"platform":platform as AnyObject]
        print("get_More_games:::::::::::::::::::::",dictPost)
        
        WebHelper.requestPostUrl(strURL: GlobalConstant.get_games, Dictionary: dictPost, Success:{
            success in
            let status = success.object(forKey: "status") as! String
            print("get_More_games:",success,"End of More Data")
            /// Result fail
            if status == "0"
            {
                
                //Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage: success.object(forKey: "msg") as! String)
            }
                /// Result success
            else if status == "1"
            {
                let arr = success.object(forKey: "Gamelist") as! NSArray
               
                for i in 0..<arr.count{
                    let obj = GameListModel()
                    let dict = arr[i] as! NSDictionary
                    
                    obj.ChallengeCount = String(describing: dict.value(forKey: "ChallengeCount")!) ////
                    obj.GameBannerImage = Global.getStringValue(dict.value(forKey: "GameBannerImage") as AnyObject)
                    obj.GameID = Global.getStringValue(dict.value(forKey: "GameID") as AnyObject)
                    obj.GameImagePath = Global.getStringValue(dict.value(forKey: "GameImagePath") as AnyObject)
                    obj.GamePlatform = Global.getStringValue(dict.value(forKey: "GamePlatform") as AnyObject)
                    obj.GamePlayers = Global.getStringValue(dict.value(forKey: "GamePlayers") as AnyObject)
                    obj.GamePlayersType = Global.getStringValue(dict.value(forKey: "GamePlayersType") as AnyObject)
                    
                    obj.GamePrizePool = Global.getStringValue(dict.value(forKey: "GamePrizePool") as AnyObject)
                    obj.GameTitle = Global.getStringValue(dict.value(forKey: "GameTitle") as AnyObject)
                    obj.TeamCount = String(describing: dict.value(forKey: "TeamCount")!) //
                    obj.TournamentCount = String(describing: dict.value(forKey: "TournamentCount")!) //
                    
                    print(obj.TournamentCount)
                    print("Appending Data to Array..........................................",i)
                    self.gameListArr.append(obj)
                    print("Data Appended to Array:::::............",i)
                }
                print("Data Filled....................................")
                self.GameListingCollectionView.reloadData()
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
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        var text=""
        
        switch UIDevice.current.orientation {
        case .portrait:
            text="Portrait"
        case .portraitUpsideDown:
            text="PortraitUpsideDown"
        case .landscapeLeft:
            text="LandscapeLeft"
        case .landscapeRight:
            text="LandscapeRight"
        default:
            text="Another"
        }
        
        NSLog("You have moved: \(text)")
        
        self.GameListingCollectionView.reloadData()
    }
    
    
    
    @IBAction func NotiAction(_ sender:Any)
    {
        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
        let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(SwreavelObj, animated: true)
    }
    
    
    
    
    
    
}

