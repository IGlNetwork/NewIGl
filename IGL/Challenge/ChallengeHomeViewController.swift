//
//  ChallengeHomeViewController.swift
//  IGL
//
//  Created by baps on 02/10/18.
//  Copyright © 2018 Mac Min. All rights reserved.
//

import UIKit
struct ChallengeCell {
    
    var ImageName = ""
    var challengeName = ""
    var Challengedescription = ""
    
}

class ChooseGameCell: UITableViewCell{
    @IBOutlet weak var ChooseUrGameLabel:UILabel!
    @IBOutlet weak var GameImageView:UIImageView!
    @IBOutlet weak var GameDescription:UILabel!
}
class ChallengeListCell: UICollectionViewCell {
    @IBOutlet weak var ChallengeImageView:UIImageView!
    @IBOutlet weak var ChallengeNmaeLabel:UILabel!
    @IBOutlet weak var AddchallengeButton:UIButton!
}

class ChallengeHomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,SWRevealViewControllerDelegate{

    @IBOutlet weak var ChallengeListGameCollectionView: UICollectionView!
    @IBOutlet weak var ChooseyourgamwTableView: UITableView!
    @IBOutlet weak var TopSeparatoelabel:UILabel!
    @IBOutlet weak var midddleseparatorLabel:UILabel!
    @IBOutlet weak var MenuBtn: UIBarButtonItem!
    @IBOutlet weak var HowtochallengeView: UIView!
    @IBOutlet weak var BackgroundView: UIView!
    
    @IBOutlet weak var HeightOftheMAinView: NSLayoutConstraint!
    
    var ChallengeArray = [ChallengeCell]()
    var ChallengesGameListArray:NSArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BackgroundView.isHidden = true
        HowtochallengeView.isHidden =  true
        ChooseyourgamwTableView.sectionHeaderHeight = 0.0;
        self.ChooseyourgamwTableView.separatorStyle = .none
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        //let newHeight = height - XPhoneHeight
        layout.itemSize = CGSize(width: width/2-14, height: 137.0)
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 15
        ChallengeListGameCollectionView!.collectionViewLayout = layout
         staticArrayOfData()
         Get_AllGameList()

    }
    override func viewWillAppear(_ animated: Bool) {
         OpenSideMenu()
       
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    @IBAction func NotiAction(_ sender:Any)
    {
        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
        let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(SwreavelObj, animated: true)
    }
    
    
    
    @IBAction func openHowtochallengeView(_ sender: Any) {
        BackgroundView.isHidden =  false
        HowtochallengeView.isHidden =  false
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let touch: UITouch = touches.first!
        if touch.view == self.BackgroundView
        {
            BackgroundView.isHidden = true
            HowtochallengeView.isHidden = true
            
            
        }
    }
    @IBOutlet weak var closeAction: NSLayoutConstraint!
    
    @IBAction func CloseviewAction(_ sender: Any) {
        BackgroundView.isHidden = true
        HowtochallengeView.isHidden = true
        
    }
    
   
    
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let StoryBoardObj = UIStoryboard(name: "Main", bundle: nil)
        let obj = StoryBoardObj.instantiateViewController(withIdentifier: "ChooseTeamViewController") as! ChooseTeamViewController
        let dicobj = ChallengesGameListArray[indexPath.row] as! NSDictionary
        obj.gameObj = dicobj
        obj.Game_Id = dicobj.value(forKey: "GameID") as! String
        FindChallengerViewController.Game_id = dicobj.value(forKey: "GameID") as! String
        self.navigationController?.pushViewController(obj, animated: true)
        return true
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ChallengeArray.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ChallengesGameListArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChooseGameCell", for: indexPath) as! ChooseGameCell
        Global.roundRadius(cell.GameImageView)
        let obj = ChallengeArray[indexPath.row]
        cell.imageView?.image = UIImage(named: obj.ImageName)
        cell.ChooseUrGameLabel.text = obj.challengeName
        cell.GameDescription.text = obj.Challengedescription
        cell.selectionStyle = .none
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let StoryBoardObj = UIStoryboard(name: "Main", bundle: nil)
//        let obj = StoryBoardObj.instantiateViewController(withIdentifier: "ChooseTeamViewController") as! ChooseTeamViewController
//       self.navigationController?.pushViewController(obj, animated: true)
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChallengeListCell", for: indexPath) as! ChallengeListCell
        if ChallengesGameListArray.count != 0{
        let obj = ChallengesGameListArray[indexPath.row] as! NSDictionary
        cell.ChallengeNmaeLabel.text = obj.value(forKey:"GameTitle") as! String
        let image_url = obj.value(forKey:"GameImagePath") as! String
        let url1 = URL(string:image_url)
             cell.ChallengeImageView.clipsToBounds = true
        cell.ChallengeImageView?.kf.setImage(with: url1,
                                     placeholder:UIImage(named: "placeholder"),
                                     options: [.transition(.fade(1))],
                                     progressBlock: nil,
                                     completionHandler: nil)
        }
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
        }
        
    }

}

extension ChallengeHomeViewController
{
    
    func Get_AllGameList() {
        var DicInput = [String:AnyObject]()
        WebHelper.requestPostUrl(strURL:GlobalConstant.get_challengegames, Dictionary: DicInput, Success: {success in
            let status = String(describing: success.value(forKey: "status")!)
            if status == "1"
            {
                self.ChallengesGameListArray = success.object(forKey: "Gamelist") as! NSArray
                self.ChallengeListGameCollectionView.reloadData()
               // self.HeightOftheMAinView.constant = CGFloat((self.ChallengesGameListArray.count*150))
            }
            else if status == "0"{
                Global.showAlertMessageWithOkButtonAndTitle("", andMessage: success.value(forKey: "msg") as! String)
            }
            
        }, Failure: {failler in
            Global.showAlertMessageWithOkButtonAndTitle("", andMessage: failler.localizedDescription)
        })
    }
    
    func staticArrayOfData()  {
        let obj = ChallengeCell(ImageName: "ChooseGame1", challengeName: "CHOOSE YOUR GAME", Challengedescription: "Select a game of your choice and expertise from the list of available games.")
        ChallengeArray.append(obj)
        let obj1 = ChallengeCell(ImageName: "findhallenger1", challengeName: "FIND CHALLENGER", Challengedescription: "Find and select from the list of available users and fix the cash prize you want to associate.")
        ChallengeArray.append(obj1)
        let obj3 = ChallengeCell(ImageName: "Win1", challengeName:"WIN AND EARN CASH", Challengedescription: "Redeem all your winning points to play more games and to win cash prizes.")
        ChallengeArray.append(obj3)
    }
    
    func OpenSideMenu()  {
        //Actions for the SideMenu.
        MenuBtn.target = revealViewController()
        MenuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
        //set the delegate to teh SWRevealviewcontroller
        revealViewController().delegate = self
        //self.revealViewController().rearViewRevealWidth = 240
        if self.revealViewController() != nil {
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
    }
}
