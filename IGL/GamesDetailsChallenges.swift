//
//  GamesDetailsChallenges.swift
//  IGL
//
//  Created by apple on 03/08/19.
//  Copyright © 2019 Mac Min. All rights reserved.
//




import UIKit
class GamesChallengesCell: UICollectionViewCell {
    @IBOutlet weak var GametitleLabel:UILabel!
    @IBOutlet weak var Imageview:UIImageView!
    @IBOutlet weak var DateLabel:UILabel!
    @IBOutlet weak var IGLcoinLabel:UILabel!
    @IBOutlet weak var challengerLabel:UILabel!
    @IBOutlet weak var StatusLabel:UILabel!
    
    
}



class GamesDetailsChallenges: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{
    @IBOutlet var GamesDetailsChallenges: UICollectionView!
       @IBOutlet weak var ErrorMessage:UILabel!
     var ChallengeReceivedArray:NSArray = []
    var Game_ID = "'"
     override func viewDidLoad() {
        super.viewDidLoad()
        ///for the tab
       /// GamesDetailsChallenges.isHidden = true
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        layout.itemSize = CGSize(width: width/2-6, height: 280)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 10
        GamesDetailsChallenges!.collectionViewLayout = layout
        Challenge()
     
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("count of the arra is ",ChallengeReceivedArray.count)
        if ChallengeReceivedArray.count == 0 {
            self.ErrorMessage.isHidden = false
            self.GamesDetailsChallenges.isHidden = true
        }else{
            self.ErrorMessage.isHidden =  true
            self.GamesDetailsChallenges.isHidden = false
        }
        return ChallengeReceivedArray.count
    }
    

   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GamesChallengesCell", for: indexPath) as! GamesChallengesCell
            let obj = ChallengeReceivedArray[indexPath.row] as! NSDictionary
            cell.GametitleLabel.text = Global.getStringValue(obj.value(forKey: "ChallengeTitle") as AnyObject)
            cell.challengerLabel.text = Global.getStringValue(obj.value(forKey: "Challenger") as AnyObject)
            cell.DateLabel.text = Global.getStringValue(obj.value(forKey: "ChallengeDate") as AnyObject)
            cell.IGLcoinLabel.text = Global.getStringValue(obj.value(forKey: "ChallengeAmount") as AnyObject)
            cell.StatusLabel.text = Global.getStringValue(obj.value(forKey: "ChallengeStatusText") as AnyObject)
            let ProfileUrl = URL(string:Global.getStringValue(obj.value(forKey: "ChallengeImagePath") as AnyObject))
            cell.Imageview.clipsToBounds = true
            cell.Imageview?.kf.setImage(with: ProfileUrl,
                                        placeholder:UIImage(named: "placeholder"),
                                        options: [.transition(.fade(1))],
                                        progressBlock: nil,
                                        completionHandler: nil)
    
            return cell
      
       
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
  
    
    
    @IBAction func BackAction(_sender:Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
  
    
    
    @IBAction func GoToNotification(_ sender: UIBarButtonItem) {
        
        let storyObj = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyObj.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    func Challenge()  {
        var DicInput = [String:AnyObject]()
        DicInput = ["game_id":self.Game_ID as AnyObject,"PNO":"0" as AnyObject]
        print("input dictionary",DicInput)
        WebHelper.requestPostUrl(strURL: GlobalConstant.get_allgamechallenge, Dictionary: DicInput, Success: {
            success in
            let status = success.object(forKey: "status") as! String
            print("sattaus is",status)
            if status == "1"{
                print("ChallengeRecivedByUser",success,":End Success:::::::::: ")
               self.ChallengeReceivedArray = success.object(forKey: "ChallengeList") as! NSArray
               self.GamesDetailsChallenges.reloadData()
            }
            else if status == "0"{
             //   Global.showAlertMessageWithOkButtonAndTitle("", andMessage: success.value(forKey: "msg") as! String)
            }
        }, Failure: {failer in
            print("something went wrong")
        })
    }
    
}
