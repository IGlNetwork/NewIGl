//
//  GameDetailsTournamnetList.swift
//  IGL
//
//  Created by apple on 03/08/19.
//  Copyright © 2019 Mac Min. All rights reserved.
//

import UIKit
import SafariServices

class GameDetailsTournamnetList: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var UpComingTMCollectionView:UICollectionView!
    @IBOutlet var ErrorMessageLabel: UILabel!
    
    
    var PlatformlistArray = [Any]()
    var GameListArray = [Any]()
    var TournamentList:NSArray = []
    var platform_id = ""
    var game_id = ""
    var user_id = ""
    var PNO = "" // Page number
    
    
    //var XPhoneHeight:CGFloat = 64;
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewdid load is start from here????")
        get_tournamentlist()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        //let newHeight = height - XPhoneHeight
        layout.itemSize = CGSize(width: width/2-22, height: 256)
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 15
        UpComingTMCollectionView!.collectionViewLayout = layout
        ErrorMessageLabel.isHidden = true
        
     }
    
    
    override func viewWillAppear(_ animated: Bool) {
        //      OpenSideMenu()
        guard let tabBar = tabBarController?.tabBar else { return }
        tabBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        tabBar.selectionIndicatorImage = UIImage().makeImageWithColorAndSize(color: #colorLiteral(red: 0.04705882353, green: 0.09019607843, blue: 0.168627451, alpha: 1), size: CGSize(width: tabBar.frame.width/5, height: tabBar.frame.height))
        tabBar.unselectedItemTintColor = UIColor.white
    }
    
    
    @IBAction func backAction(_ sender: Any) {
//        let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
//        let vc : SWRevealViewController = mainStoryboard.instantiateViewController(withIdentifier: "SW-Reaveal")as! SWRevealViewController
//        self.present(vc, animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if TournamentList.count == 0{
           UpComingTMCollectionView.isHidden = true
           ErrorMessageLabel.isHidden = false
        }else{
            UpComingTMCollectionView.isHidden = false
            ErrorMessageLabel.isHidden = true
        }
        return TournamentList.count
    }
 
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BattleRoyalCell", for: indexPath) as! BattleRoyalCell
        let obj = TournamentList[indexPath.row] as! NSDictionary
        cell.GameTitleLabel.text = obj["TournamentTitle"] as! String
        cell.TMPrizeCoins.text = (obj["TournamentWinnerPrize"] as! String)+" IGL COINS"
        cell.TMDateLabel.text = obj["TournamentDate"] as! String
        let url = URL(string:obj["TournamentLogo"] as! String)
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
        let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
        let vc : TournamentDetailsVC = mainStoryboard.instantiateViewController(withIdentifier: "TournamentDetailsVC") as! TournamentDetailsVC
        let obj = TournamentList[sender.tag] as! NSDictionary
        vc.tournament_id = obj["TournamentID"] as! String
        self.navigationController?.pushViewController(vc, animated: true)
  }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    

 // ============ API Calling ============
    func get_tournamentlist()
    {
        var dictPost:[String: AnyObject]!
        dictPost = ["PNO":"0"as AnyObject,"game_id": self.game_id as AnyObject]
    //https://iglnetwork.com/beta/api-V1/get_allgamestournaments
        WebHelper.requestPostUrl(strURL: GlobalConstant.get_allgamestournaments, Dictionary: dictPost, Success:{
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
                self.TournamentList = success.object(forKey: "TournamentList") as! NSArray
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

//extension GameDetailsTournamnetList{
//  @IBAction func Login(_ send: Any)
//    {
//       self.navigationController?.popViewController(animated: true)
//    }
//
//
//}

