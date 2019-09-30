//
//  BattleRoyaleVC.swift
//  IGL
//
//  Created by Apple on 13/07/19.
//  Copyright © 2019 Mac Min. All rights reserved.
//

    import UIKit
    import SafariServices

    class BattleRoyalCell: UICollectionViewCell {
        @IBOutlet weak var TMBannerImageView:UIImageView!
        @IBOutlet weak var GameTitleLabel:UILabel!
        @IBOutlet weak var TMDateLabel:UILabel!
        @IBOutlet weak var TMPrizeCoins:UILabel!
        @IBOutlet weak var JoinNowView:UIView!
        @IBOutlet weak var JoinNowButton:UIButton!
    }


    class BattleRoyaleVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
       
        @IBOutlet weak var UpComingTMCollectionView:UICollectionView!
      
        @IBOutlet weak var UpComingBR: UIButton!
        @IBOutlet weak var PastBR: UIButton!
        
        var PlatformlistArray = [Any]()
        var GameListArray = [Any]()
        var TournamentList:NSArray = []
        var platform_id = ""
        var game_id = ""
        var user_id = ""
        var PNO = "" // Page number
        var isPastTournemetn = false
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
            if isPastTournemetn{
                 get_pasttournamentlist()
            }
            else{
                 get_tournamentlist()
            }
           
            refreshControl.endRefreshing()
        }
        
        
        //var XPhoneHeight:CGFloat = 64;
        override func viewDidLoad() {
            super.viewDidLoad()
            self.UpComingTMCollectionView.addSubview(self.refreshControl)
            get_tournamentlist()
            //OpenSideMenu()
             CellLayout()
          }
        
        
        override func viewWillAppear(_ animated: Bool) {
      //      OpenSideMenu()
            guard let tabBar = tabBarController?.tabBar else { return }
            tabBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            tabBar.selectionIndicatorImage = UIImage().makeImageWithColorAndSize(color: #colorLiteral(red: 0.04705882353, green: 0.09019607843, blue: 0.168627451, alpha: 1), size: CGSize(width: tabBar.frame.width/5, height: tabBar.frame.height))
            tabBar.unselectedItemTintColor = UIColor.white
        }
        
        
        @IBAction func backAction(_ sender: Any) {
            let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
            let vc : SWRevealViewController = mainStoryboard.instantiateViewController(withIdentifier: "SW-Reaveal")as! SWRevealViewController
            self.present(vc, animated: true, completion: nil)
        }
        
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return TournamentList.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BattleRoyalCell", for: indexPath) as! BattleRoyalCell
            let obj = TournamentList[indexPath.row] as! [String:AnyObject]
            cell.GameTitleLabel.text = obj["RoyalBattleTitle"] as! String
            cell.TMPrizeCoins.text = (obj["RoyalBattlePrize"] as! String)+" IGL COINS"
            cell.TMDateLabel.text = obj["RoyalBattleStartDate"] as! String
            let url = URL(string:obj["RoyalBattleLogo"] as! String)
            cell.TMBannerImageView?.kf.setImage(with: url,
                                                placeholder:UIImage(named: "placeholder"),
                                                options: [.transition(.fade(1))],
                                                progressBlock: nil,
                                                completionHandler: nil)
            cell.TMBannerImageView?.clipsToBounds = true
            cell.JoinNowView.layer.cornerRadius = 15
            cell.JoinNowButton.tag = indexPath.row
            
            cell.JoinNowButton.addTarget(self,
                                         action: #selector(self.GoToOtherView),
                                         for: .touchUpInside)
            return cell
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        @objc func GoToOtherView(sender : UIButton){
          let obj = TournamentList[sender.tag] as! [String:AnyObject]
           let RoyalBattleID = obj["RoyalBattleID"] as! String
//            //https://iglnetwork.com/beta/battleroyale/brdetails/4
//            let user_id = UserDefaults.standard.value(forKey: "user_id") as! String
//           let url = "https://iglnetwork.com/beta/battleroyale/brdetails/\(RoyalBattleID)/\(user_id)"
//            print("url is coming",url)
//           let svc = SFSafariViewController(url: URL(string: url)!, entersReaderIfAvailable: true)
//             svc.preferredBarTintColor =   #colorLiteral(red: 0.3333333333, green: 0.6509803922, blue: 0.9215686275, alpha: 1)
//             present(svc, animated: true, completion: nil)
//             if #available(iOS 11.0, *) {
//             svc.dismissButtonStyle = .close
//             } else {
//             // Fallback on earlier versions
//             }
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "BattleRoyaleDetailsVC") as! BattleRoyaleDetailsVC
            self.navigationController?.pushViewController(vc, animated: true)
         }
        
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
        {
            print("didSelectItemAt...................")
           
        }
        
        func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
//            print("shouldSelectItemAt...................")
//            let vc = storyboard?.instantiateViewController(withIdentifier: "BattleRoyaleDetailsVC") as! BattleRoyaleDetailsVC
//            self.navigationController?.pushViewController(vc, animated: true)
          return true
        }
        
        @IBAction func UpComingBR(_ sender: Any) {
            UpComingBR.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.5254901961, blue: 0.8, alpha: 1)
            PastBR.backgroundColor =   #colorLiteral(red: 0.1098039216, green: 0.2549019608, blue: 0.4196078431, alpha: 1)
            isPastTournemetn = false
            get_tournamentlist()
        }
        
        
        @IBAction func PastBRAction(_ sender: UIButton){
          
            UpComingBR.backgroundColor = #colorLiteral(red: 0.1098039216, green: 0.2549019608, blue: 0.4196078431, alpha: 1)
            PastBR.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.5254901961, blue: 0.8, alpha: 1)
            isPastTournemetn = true
            get_pasttournamentlist()
           
        }
        
       
        
        
        
        
        
    // ============ API Calling ============
        func get_tournamentlist()
        {
            var dictPost:[String: AnyObject]!
            dictPost = ["PNO":"0"as AnyObject]
            print("Dictionary:****************************************************************",dictPost)
            WebHelper.requestPostUrl(strURL: GlobalConstant.get_battleroylaelist, Dictionary: dictPost, Success:{
                success in
                let status = success.object(forKey: "status") as! String
                print("List of battle royle is ------>>>>>>>>>>>>>>:",success)
                /// Result fail
                if status == "0"
                {
                    print("Something went wrong!!!")
                    self.TournamentList = []
                  
                    self.UpComingTMCollectionView.reloadData()
                }
                /// Result success
                else if status == "1"
                {
                self.TournamentList = []
                self.TournamentList = success.object(forKey: "Tournamentlist") as! NSArray
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
        
        //https://iglnetwork.com/beta/api-V1/get_pastbattleroyalelist
        
        func get_pasttournamentlist()
        {
            var dictPost:[String: AnyObject]!
            dictPost = ["PNO":"0" as AnyObject]
            print("Dictionary:****************************************************************",dictPost)
            WebHelper.requestPostUrl(strURL: GlobalConstant.get_pastbattleroyalelist, Dictionary: dictPost, Success:{
                success in
                let status = String(describing: success.object(forKey: "status")!)//success.object(forKey: "status") as! String
                print("List of Tournament is ------>>>>>>>>>>>>>>:",success)
                /// Result fail
                if status == "0"
                {
                print("Something went wrong!!!")
                    self.TournamentList = []
                   
                    self.UpComingTMCollectionView.reloadData()
                }
                /// Result success
                else if status == "1"
                {
                    self.TournamentList = []
                    self.TournamentList = success.object(forKey: "Tournamentlist") as! NSArray
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
        
        
       
        
    }



    extension BattleRoyaleVC{
        
        
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
                   
                default:
                    print("unknown")
                }
            }
            
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            let width = UIScreen.main.bounds.width
            let height = UIScreen.main.bounds.height
            //let newHeight = height - XPhoneHeight
            layout.itemSize = CGSize(width: width/2-22, height: 256)
            layout.minimumInteritemSpacing = 15
            layout.minimumLineSpacing = 15
            UpComingTMCollectionView!.collectionViewLayout = layout
            //UpComingTMCollectionView.isScrollEnabled = false
        }
        
    }

