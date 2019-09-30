//
//  ChallengeDualVC.swift
//  IGL
//
//  Created by Mac Min on 05/11/18.
//  Copyright © 2018 Mac Min. All rights reserved.
//

import UIKit

class ChallengeDualVC: UIViewController {

    @IBOutlet weak var VSButton:UIButton!
    @IBOutlet weak var ReportWillLossButton:UIButton!
    @IBOutlet weak var ReportDispute:UIButton!
    
    @IBOutlet weak var ImageViewTeamA: UIImageView!
    @IBOutlet weak var TitleTeamA: UILabel!
    @IBOutlet weak var PlateformTeamA: UILabel!
    @IBOutlet weak var GameTeamA: UILabel!
    
   
     @IBOutlet weak var ImageViewTeamB: UIImageView!
     @IBOutlet weak var TitleTeamB: UILabel!
     @IBOutlet weak var PlateformTeamB: UILabel!
     @IBOutlet weak var GameTeamB: UILabel!
     @IBOutlet weak var PrizeMoney: UILabel!
     var challenge_id = ""
     var Team1ID = ""
     var Team2ID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
         VSButton.layer.cornerRadius = VSButton.frame.size.height/2
          ReportWillLossButton.layer.cornerRadius = 15
        ImageViewTeamB.clipsToBounds = true
        ImageViewTeamA.clipsToBounds = true
       // Do any additional setup after loading the view.
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTappedB(tapGestureRecognizer:)))
        ImageViewTeamB.isUserInteractionEnabled = true
        ImageViewTeamB.addGestureRecognizer(tapGestureRecognizer)
        
        let tapGestureRecognizerA = UITapGestureRecognizer(target: self, action: #selector(imageTappedA(tapGestureRecognizer:)))
        ImageViewTeamA.isUserInteractionEnabled = true
        ImageViewTeamA.addGestureRecognizer(tapGestureRecognizerA)
    }

    @objc func imageTappedB(tapGestureRecognizer: UITapGestureRecognizer)
    {
    let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
    let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"TeamDeatilsViewController") as! TeamDeatilsViewController
        SwreavelObj.team_id = self.Team2ID
    self.navigationController?.pushViewController(SwreavelObj, animated: true)
        }
    
    
    @objc func imageTappedA(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
        let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"TeamDeatilsViewController") as! TeamDeatilsViewController
         SwreavelObj.team_id = self.Team1ID
        self.navigationController?.pushViewController(SwreavelObj, animated: true)
        }
    
    override func viewWillAppear(_ animated: Bool) {
        ChallengeBetween()
    }
  
    @IBAction func GoToProfitNadLossAction(_ sender: Any) {
        let storyObj = UIStoryboard(name: "Main", bundle: nil)
        let obj = storyObj.instantiateViewController(withIdentifier: "ProfileOrLossViewController") as! ProfileOrLossViewController
        obj.challenge_id = self.challenge_id
        obj.yourTeamName =  self.TitleTeamA.text!
        obj.opponentTeamName = self.TitleTeamB.text!
        print("this is submit button")
        self.navigationController?.pushViewController(obj, animated: true)
    }
    
    @IBAction func BackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func NotiAction(_ sender:Any)
    {
        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
        let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(SwreavelObj, animated: true)
    }
    
    
    func ChallengeBetween() {
        var DicInput = [String:AnyObject]()
        DicInput = ["challenge_id":self.challenge_id as AnyObject]
        WebHelper.requestPostUrl(strURL: GlobalConstant.challenge_details, Dictionary: DicInput, Success: {success in
            let status = success.object(forKey: "status") as! String
            print(DicInput,"success::",success)
            if status == "1"{
                let dict = success.object(forKey: "ChallengeDetails") as! NSDictionary
               
                
                 let imgurlA = URL(string:dict.value(forKey: "Team1Image") as! String)
                 self.ImageViewTeamA?.kf.setImage(with: imgurlA,
                                            placeholder:UIImage(named: "placeholder"),
                                            options: [.transition(.fade(1))],
                                            progressBlock: nil,
                                            completionHandler: nil)
                self.Team1ID = Global.getStringValue(dict.value(forKey: "Team1ID") as AnyObject)
                self.Team2ID = Global.getStringValue(dict.value(forKey: "Team2ID") as AnyObject)
        
                self.TitleTeamA.text = Global.getStringValue(dict.value(forKey: "Team1Name") as AnyObject)//dict.value(forKey: "Team1Name") as? String
                self.TitleTeamB.text = Global.getStringValue(dict.value(forKey: "Team2Name") as AnyObject)
                self.PlateformTeamA.text = Global.getStringValue(dict.value(forKey: "Team1Platform") as AnyObject)
                self.PlateformTeamB.text = Global.getStringValue(dict.value(forKey: "Team2Platform") as AnyObject)
                self.GameTeamA.text = Global.getStringValue(dict.value(forKey: "Team1Game") as AnyObject)
                self.GameTeamB.text = Global.getStringValue(dict.value(forKey: "Team2Game") as AnyObject)
                let ChallengeAmount = Global.getStringValue(dict.value(forKey: "ChallengeAmount") as AnyObject)
                self.PrizeMoney.text = (ChallengeAmount) + " IGL COINS"
                let imgurlB = URL(string:dict.value(forKey: "Team2Image") as! String)
                self.ImageViewTeamB?.kf.setImage(with: imgurlB,
                                                 placeholder:UIImage(named: "placeholder"),
                                                 options: [.transition(.fade(1))],
                                                 progressBlock: nil,
                                                 completionHandler: nil)
            }
            else if status == "0"{
                self.TitleTeamA.text = ""
                self.TitleTeamB.text = ""
                self.PlateformTeamA.text = ""
                self.PlateformTeamB.text = ""
                self.GameTeamA.text = ""
                self.GameTeamB.text = ""
            }
        }, Failure: {failler in
            Global.showAlertMessageWithOkButtonAndTitle("", andMessage:failler.localizedDescription)
        })
    }
    
    
}
