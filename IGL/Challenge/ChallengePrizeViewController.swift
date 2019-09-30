//
//  ChallengeViewController.swift
//  IGL
//
//  Created by baps on 02/10/18.
//  Copyright © 2018 Mac Min. All rights reserved.
//

import UIKit

class ChallengePrizecell: UICollectionViewCell {
    @IBOutlet weak var NoOfIGLCoins:UILabel!
}
class ChallengePrizeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var Challengeview: UIView!
    @IBOutlet weak var ChallengeiconButoon: UIImageView!
    @IBOutlet weak var SearchView: UIView!
    @IBOutlet weak var ChallengeCollectionView: UICollectionView!
    @IBOutlet weak var AmounttextField:UITextField!
    var coinArray = ["10","20","30","40","60","100"]
    static var from_team_id = ""
    static var To_team_id = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        Challengeview.layer.cornerRadius = 15
        SearchView.layer.cornerRadius = 12
        ChallengeiconButoon.tintColor = UIColor.white
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("iPhone 5 or 5S or 5C")
                let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                let width = UIScreen.main.bounds.width
                let height = UIScreen.main.bounds.height
                //let newHeight = height - XPhoneHeight
                layout.itemSize = CGSize(width: width/4+5, height:width/4+5)
                layout.minimumInteritemSpacing = 1
                // layout.minimumLineSpacing =
                ChallengeCollectionView!.collectionViewLayout = layout
                
            case 1334:
                print("iPhone 6/6S/7/8")
                let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                let width = UIScreen.main.bounds.width
                let height = UIScreen.main.bounds.height
                //let newHeight = height - XPhoneHeight
                layout.itemSize = CGSize(width: width/4+10, height:  width/4+10)
                layout.minimumInteritemSpacing = 1
                layout.minimumLineSpacing = 15
                ChallengeCollectionView!.collectionViewLayout = layout
            case 2208:
                print("iPhone 6+/6S+/7+/8+")
                let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                let width = UIScreen.main.bounds.width
                let height = UIScreen.main.bounds.height
                //let newHeight = height - XPhoneHeight
                layout.itemSize = CGSize(width: width/4+13, height: width/4+13)
                layout.minimumInteritemSpacing = 1
                layout.minimumLineSpacing = 12
                ChallengeCollectionView!.collectionViewLayout = layout
            case 2436:
                print("iPhone X")
                let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                let width = UIScreen.main.bounds.width
                let height = UIScreen.main.bounds.height
                //let newHeight = height - XPhoneHeight
                layout.itemSize = CGSize(width: width/4+12, height: width/4+12)
                layout.minimumInteritemSpacing = 0
                layout.minimumLineSpacing = 8
                ChallengeCollectionView!.collectionViewLayout = layout
            default:
                print("unknown")
            }
        }
        }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coinArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChallengePrizecell", for: indexPath) as! ChallengePrizecell
        cell.NoOfIGLCoins.text = coinArray[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        AmounttextField.text = coinArray[indexPath.row]
    }
     override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    
    @IBAction func Backaction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func SentChallengeAction(_ sender: Any) {
      ToSendChallenge()
    }
    @IBAction func NotiAction(_ sender:Any)
    {
        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
        let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(SwreavelObj, animated: true)
    }
    
    
    /*
     user_id : logged in user id
     game_id : game id selected via ist api
     from_team_id: logged in user team id
     to_team_id : opponent team id
     amount : amunt of challenge

     */
    func ToSendChallenge()  {
        var DicInput = [String:AnyObject]()
        DicInput = ["user_id":UserDefaults.standard.value(forKey:"user_id") as AnyObject,"game_id": FindChallengerViewController.Game_id as AnyObject,"from_team_id":ChallengePrizeViewController.from_team_id as! AnyObject ,"to_team_id":ChallengePrizeViewController.To_team_id as AnyObject,"amount": self.AmounttextField.text! as AnyObject]
        print("passed data to server is",DicInput)
        WebHelper.requestPostUrl(strURL:GlobalConstant.submit_challenge, Dictionary: DicInput, Success: {success in
            let status = success.object(forKey: "status") as! String
            if status == "1"{
             // Global.showAlertMessageWithOkButtonAndTitle("", andMessage: <#T##String#>)
                let obj = UIStoryboard(name: "Main", bundle: nil)
                let vc = obj.instantiateViewController(withIdentifier: "ChallengeSentViewController") as! ChallengeSentViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if status == "0"{
                
            }
        }, Failure: {failler in
            Global.showAlertMessageWithOkButtonAndTitle("", andMessage: failler.localizedDescription)
        })
        
        
    }
}
