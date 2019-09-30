//
//  IGLTVViewController.swift
//  IGL
//
//  Created by Mac Min on 16/10/18.
//  Copyright © 2018 Mac Min. All rights reserved.
//

import UIKit

class IGLTVCell: UICollectionViewCell
{
    @IBOutlet weak var YoutubeVideoWeb: UIWebView!
    @IBOutlet weak var GameNameLabel: UILabel!
    @IBOutlet weak var GameDtaeLabel: UILabel!
    @IBOutlet weak var LikeLabel: UILabel!
    @IBOutlet weak var CommmentLabel: UILabel!
    @IBOutlet weak var ShareLabel: UILabel!
    @IBOutlet weak var LikeButton: UIButton!
    @IBOutlet weak var CommentButton: UIButton!
    @IBOutlet weak var ShareButton: UIButton!
    @IBOutlet weak var TournamentNAmeLabel: UILabel!
    @IBOutlet weak var GameNameLAbel: UILabel!
    @IBOutlet weak var likelistbutton: UIButton!
    
}
class GameListCell: UITableViewCell {
    @IBOutlet weak var GameNameLabel:UILabel!
}
class CommentCel: UITableViewCell {
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var CommentedByLabel: UILabel!
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var CommentDescription: UILabel!
    
}
class IGLTVViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate
{
    
    
    
    @IBOutlet weak var CommentTableView: UITableView!
    @IBOutlet weak var Scrollview:UIScrollView!
    @IBOutlet weak var IGLTVCollectionView:UICollectionView!
    @IBOutlet weak var GameListTableView:UITableView!
    @IBOutlet weak var GameListView:UIView!
    @IBOutlet weak var SelectAGameView: UIView!
    @IBOutlet weak var BackgroundView:UIView!
    @IBOutlet weak var GAmeTextField:UITextField!
    @IBOutlet weak var CommentView: UIView!
    @IBOutlet weak var BackgroundView1: UIView!
    @IBOutlet weak var IconButton: UIButton!
    
    @IBOutlet weak var LikesTAbleView: UITableView!
    @IBOutlet weak var LikeSListView: UIView!
    @IBOutlet weak var CommentTextView: UITextView!
    var GameListArray = [Any]()
    var PNO = "0"
    var game_id = ""
    var TVlist = [Any]()
    var TVVideoID = ""
    var TV_ID = ""
    var listofCommetArray:NSArray = []
    var arrLikesMember:NSArray = []
    override func viewDidLoad()
    {
        LikeSListView.isHidden = true
        BackgroundView1.isHidden = true
        self.LikesTAbleView.separatorStyle = .none
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(doSomething), for: .valueChanged)
        
        IGLTVCollectionView.refreshControl = refreshControl
        CommentTextView.delegate = self
        CommentTextView.text = "Write a comment.."
        CommentTextView.textColor = UIColor.lightGray
        CommentTableView.delegate = self
        CommentTableView.dataSource = self
        super.viewDidLoad()
        BackgroundView1.isHidden = true
        CommentView.isHidden = true
        SelectAGameView.layer.cornerRadius = 15
        SelectAGameView.clipsToBounds = true
        GameListView.layer.cornerRadius = 5
        
        CommentTableView.separatorStyle = .none
        
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        //let newHeight = height - XPhoneHeight
        layout.itemSize = CGSize(width:width, height:365)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        IGLTVCollectionView!.collectionViewLayout = layout
        print("View did load5454564564+56jjhdfgb hdjf gbdfjgkdgdkghksjdhgaksjdhk dhgkjsadhgk;asjd")
        self.GetGameList()
        BackgroundView.isHidden = true
        GameListView.isHidden = true
        GameListTableView.sectionHeaderHeight = 0.0;
        self.GameListTableView.separatorStyle = .none
        get_tvlist()
        
        
    }
    
    
    @IBAction func CloselikesView(_ sender: Any) {
        BackgroundView1.isHidden = true
        LikeSListView.isHidden  = true
        get_tvlist()
    }
    
    
    @objc func doSomething(refreshControl: UIRefreshControl) {
        print("Hello World!")
        
        // somewhere in your code you might need to call:
        self.game_id = ""
        GAmeTextField.text = "Search.."
        GAmeTextField.textColor = UIColor.lightGray
        get_tvlist()
        
        refreshControl.endRefreshing()
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Write a comment.."
            textView.textColor = UIColor.lightGray
        }
    }
    var flag = 0
    @IBAction func OpenpopUp(Sender:UIButton){
        
        if flag == 0
        {
            // BackgroundView.isHidden = false
            GameListView.isHidden = false
            flag = 1
            //  Scrollview.isScrollEnabled = false
            // IGLTVCollectionView.isScrollEnabled = false
            // IGLTVCollectionView.isUserInteractionEnabled = false
        }
        else{
            BackgroundView.isHidden = true
            GameListView.isHidden = true
            // Scrollview.isScrollEnabled = true
            IGLTVCollectionView.isScrollEnabled = true
            IGLTVCollectionView.isUserInteractionEnabled = true
            flag = 0
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let touch: UITouch = touches.first!
        if touch.view != GameListView ||  touch.view == IGLTVCollectionView
        {
            self.BackgroundView.isHidden = true
            self.GameListView.isHidden = true
            
            flag = 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  tableView == CommentTableView{
            return listofCommetArray.count
        }else if tableView == self.LikesTAbleView{
            return self.arrLikesMember.count
        }
        else{
            return GameListArray.count
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        print("count-------",GameListArray.count)
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == CommentTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCel", for: indexPath) as! CommentCel
            cell.ProfileImage.layer.cornerRadius = cell.ProfileImage.frame.height/2
            cell.ProfileImage.clipsToBounds = true
            if listofCommetArray.count != 0{
                let obj = listofCommetArray[indexPath.row] as! NSDictionary
                cell.CommentDescription.text = obj.value(forKey: "TVCommentText") as! String
                cell.CommentedByLabel.text = obj.value(forKey: "username") as! String
                cell.TimeLabel.text =  obj.value(forKey: "TimeAgo") as! String
                let url1 = URL(string:obj.value(forKey: "UserProfileImage") as! String)
                cell.ProfileImage.kf.setImage(with: url1,
                                              placeholder:UIImage(named: "profile-top-banner"),
                                              options: [.transition(.fade(1))],
                                              progressBlock: nil,
                                              completionHandler: nil)
            }
            cell.selectionStyle = .none
            return cell
            // "username": "Ido Gammer",
           // "UserProfileImage": "photos/small/1534919686Greyjoy_Banner_jpg.jpeg"
        }else if tableView == LikesTAbleView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
            cell.selectionStyle = .none
            let obj = self.arrLikesMember[indexPath.row] as! NSDictionary
            cell.UserNameLabel.text = obj.value(forKey: "username") as! String
            let url1 = URL(string:obj.value(forKey: "UserProfileImage") as! String)
            cell.ProfileImageView.layer.cornerRadius = cell.ProfileImageView.frame.height/2
            cell.ProfileImageView.clipsToBounds = true
            cell.ProfileImageView.kf.setImage(with: url1,
                                          placeholder:UIImage(named: "profile-top-banner"),
                                          options: [.transition(.fade(1))],
                                          progressBlock: nil,
                                          completionHandler: nil)
            
            
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "GameListCell", for: indexPath) as! GameListCell
            let obj = GameListArray[indexPath.row] as! NSDictionary
            print("Game title is-----",obj.value(forKey: "GameTitle") as! String)
            cell.GameNameLabel.text = obj.value(forKey: "GameTitle") as! String
           
            return cell
        }
    }
    
    @IBAction func AddCommentAction(_ sender: Any) {
        if CommentTextView.textColor == UIColor.lightGray || CommentTextView.text! == "" ||  CommentTextView.text! == nil || CommentTextView.text == "Write a comment.."{
            Global.showAlertMessageWithOkButtonAndTitle("", andMessage: "Comment cannot be blank")
        }else{
            AddComment()
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == GameListTableView{
            let obj = GameListArray[indexPath.row] as! NSDictionary
            GAmeTextField.text = obj.value(forKey: "GameTitle") as! String
            self.game_id =  obj.value(forKey: "GameID") as! String
            GAmeTextField.placeholder = "Search.."
            get_tvlist()
            BackgroundView.isHidden = true
            GameListView.isHidden = true
            flag = 0
            //   Scrollview.isScrollEnabled = true
            IGLTVCollectionView.isScrollEnabled = true
            IGLTVCollectionView.isUserInteractionEnabled = true
        }else if tableView == self.LikesTAbleView{
                let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
                print("Task indexPath.row:",indexPath.row)
                let vc : PersonalProfileViewController = mainStoryboard.instantiateViewController(withIdentifier: "PersonalProfileViewController")as! PersonalProfileViewController
                let obj = self.arrLikesMember[indexPath.row] as! NSDictionary
                let userid  = obj.value(forKey:"id") as! String
                vc.otherUserId = userid
                vc.COmingFromLandingScreen = false
                self.navigationController?.pushViewController(vc, animated: true)
       }
        
    }
   
    
   
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  TVlist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = IGLTVCollectionView.dequeueReusableCell(withReuseIdentifier: "IGLTVCell", for: indexPath) as! IGLTVCell
        if TVlist.count != 0{
            print("TVList ",TVlist)
            cell.CommentButton.tag = indexPath.row
            cell.LikeButton.tag = indexPath.row
            cell.ShareButton.tag = indexPath.row
            let dict = TVlist[indexPath.row] as! NSDictionary
            
           let comment = dict.value(forKey: "TVCommentCount") as! String
            let likeString = dict.value(forKey: "islike") as! String
            let likecount = dict.value(forKey: "TVlike") as! String
           // cell.CommmentLabel.text = "COMMENT \(comment)"
            
            //   0 Likes | 1 Like | 2 Likes
           // let NLike = String(describing: dict.value(forKey: "TVlike")!)//newsDetails["Nlike"] as! String
            print("like count us",likecount)
            if likecount == "0"{
                  cell.LikeLabel.text = "0 LIKES"
            }else if likecount == "1"{
                 cell.LikeLabel.text = "\(likecount) LIKE"
            }else if likecount == ""{
                  cell.LikeLabel.text = "0 LIKES"
            }else{
                  cell.LikeLabel.text = "\(likecount) LIKES"
            }
            //  0 Comments | 1 Comment | 2 Comments
         //  let comment = String(describing: dict.value(forKey: "TVCommentCount")!)//newsDetails["NCommentCount"] as! String
            if comment == "0"{
                cell.CommmentLabel.text = "0 COMMENTS"
            }else if comment == "1"{
                cell.CommmentLabel.text = "1 COMMENT"
            }else if comment == ""{
               cell.CommmentLabel.text = "0 COMMENTS"
            }else{
               cell.CommmentLabel.text = "\(comment) COMMENTS"
            }
            
            
            
        //    cell.LikeLabel.text = likeString + " " + likecount
            cell.ShareLabel.text = "SHARE"
            cell.GameNameLabel.text! = dict.value(forKey: "TVTitle") as! String
            cell.GameDtaeLabel.text! = "TOURNAMENT DATE:" + "\(dict.value(forKey: "TVDate") as! String)"
            let videoCode = dict.value(forKey: "TVVideoID") as! String
            let url = URL(string: "https://www.youtube.com/embed/\(videoCode)")
            cell.YoutubeVideoWeb.loadRequest(URLRequest(url: url!))
            let GameName = dict.value(forKey: "GameTitle") as! String
            cell.GameNameLAbel.text = "GAME NAME : \(GameName)"
           
            let tournament = dict.value(forKey: "TournamentTitle") as! String
            cell.TournamentNAmeLabel.text = "COMPETITION NAME: \(tournament)"
         
            cell.likelistbutton.tag = indexPath.row     }
        return cell
    }
    
    //https://iglnetwork.com/beta/api-V1/get_tvlikememberlist
    
    @IBAction func LikeList(_ sender: UIButton) {
        let tv_id  = (self.TVlist[sender.tag] as! NSDictionary).value(forKey: "TVID") as! String
       ToGetLikesMemberList(TV_ID:tv_id)
    }
    
    
    func ToGetLikesMemberList(TV_ID:String) {
        var DicInput = [String:AnyObject]()
        DicInput = ["tv_id":TV_ID as AnyObject]
        print("input dicnatioary is ",DicInput)
         WebHelper.requestPostUrl(strURL: GlobalConstant.get_tvlikememberlist, Dictionary: DicInput, Success: {success in
            let status = String(describing:success.value(forKey: "status")!)
            if status == "1"{
            self.arrLikesMember = success.value(forKey: "Userlist") as! NSArray
                self.LikesTAbleView.reloadData()
                self.BackgroundView1.isHidden = false
                self.LikeSListView.isHidden = false
            }else{
               Global.showAlertMessageWithOkButtonAndTitle("", andMessage: success.value(forKey: "msg") as! String)
            }
         }, Failure: {failler in
            
         })
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
        //        let dict = TVlist[indexPath.row] as! NSDictionary
        //
        //        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
        //        let vcobj = storyboardobj.instantiateViewController(withIdentifier:"IGLTVDetailsViewController") as! IGLTVDetailsViewController
        //        vcobj.TVId = dict.value(forKey: "TVID") as! String
        //        vcobj.videoid = dict.value(forKey: "TVVideoID") as! String
        //        self.navigationController?.pushViewController(vcobj, animated: true)
    }
    
    @IBAction func BackAction(_ send: Any)
    {
        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
        let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"SW-Reaveal") as! SWRevealViewController
        self.present(SwreavelObj, animated: true, completion: nil)
        // Please write here code for Login
        //self.Validate_text_fields()
    }
    
    @IBAction func NotiAction(_ sender:Any)
    {
        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
        let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(SwreavelObj, animated: true)
    }
    
    
    @IBAction func OpenCommentAction(_ sender: AnyObject) {
        BackgroundView1.isHidden = false
        CommentView.isHidden = false
        let dict = TVlist[sender.tag!] as! NSDictionary
        self.TV_ID = dict.value(forKey: "TVID") as! String
        TogetCommentList()
        
    }
    
    @IBAction func OpenComentPopUp(_ sender: Any) {
        BackgroundView1.isHidden = true
        CommentView.isHidden = true
    }
    
    @IBAction func LikeTvVewAction(_ sender: AnyObject) {
        let dict = TVlist[sender.tag!] as! NSDictionary
        self.TV_ID = dict.value(forKey: "TVID") as! String
        var dicInput = ["user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject,"tv_id":self.TV_ID as AnyObject]
        WebHelper.requestPostUrl(strURL: GlobalConstant.tvlike, Dictionary: dicInput, Success: {success in
            let status = String(describing: success.value(forKey: "status")!)
            if status == "1"{
                print("success data from the serve is ")
                let cell: IGLTVCell = self.IGLTVCollectionView.cellForItem(at:IndexPath(item: sender.tag!, section: 0)) as! IGLTVCell
               // cell.LikeLabel.text = "Like \(success.value(forKey: "TVlike") as! String) "
                self.get_tvlist()
            }
            else if status == "0"
            {
                
            }
        }, Failure: {failler in
            
        })
    }
    
    @IBAction func ShareVideoAction(_ sender: AnyObject) {
        let dict = TVlist[sender.tag!] as! NSDictionary
        let videoCode = dict.value(forKey: "TVVideoID") as! String
        let text = "https://www.youtube.com/embed/\(videoCode)"
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop]
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
    func GetGameList(){
        var DicInput = ["PNO":"" as AnyObject,"platform": "" as AnyObject]
        WebHelper.requestPostUrl(strURL: GlobalConstant.get_games, Dictionary: DicInput, Success: {
            success in
            print("Game list of the IGl",success)
            if  success.value(forKey: "status") as! String == "1"{
                self.GameListArray = success.object(forKey: "Gamelist") as! [Any]
                self.GameListTableView.reloadData()
            }
            else if success.value(forKey: "status") as! String == "0"
            {
                Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage:success.value(forKey: "msg") as! String)
            }
        }, Failure: {failler in
            Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage: failler.localizedDescription)
        })
    }
    
    
    func get_tvlist(){
        var DicInput = ["PNO":self.PNO as AnyObject,"game_id": self.game_id as AnyObject]
        WebHelper.requestPostUrl(strURL: GlobalConstant.get_tvlist, Dictionary: DicInput, Success: {
            success in
            print("Game list of the IGl",success)
            if  success.value(forKey: "status") as! String == "1"{
                self.TVlist = []
                self.TVlist =  success.value(forKey: "TVlist") as! [Any]
                self.IGLTVCollectionView.reloadData()
            }
            else if success.value(forKey: "status") as! String == "0"
            {
                self.TVlist = []
                self.IGLTVCollectionView.reloadData()
            }
        }, Failure: {failler in
            Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage: failler.localizedDescription)
        })
    }
}

extension IGLTVViewController{
    func AddComment()  {
        var dicInput = ["user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject,"tv_id":self.TV_ID as AnyObject,"commenttext":CommentTextView.text! as AnyObject]
        WebHelper.requestPostUrl(strURL: GlobalConstant.comment_tv, Dictionary: dicInput, Success: {success in
            let status = String(describing: success.value(forKey: "status")!)
            if status == "1"{
                self.CommentTextView.text = ""
             //   self.CommentTextView.textColor = UIColor.lightGray
                self.TogetCommentList()
                self.get_tvlist()
            }
            else if status == "0"{
                
            }
        }, Failure: {failler in
            Global.showAlertMessageWithOkButtonAndTitle("", andMessage: failler.localizedDescription)
        })
    }
    /*
     user_id : user logged in id
     tv_id : tvid
     
     */
    func TogetCommentList() {
        var dicInput = ["user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject,"tv_id":self.TV_ID as AnyObject]
        WebHelper.requestPostUrl(strURL: GlobalConstant.get_tvcomments, Dictionary: dicInput, Success: {success in
            let status = String(describing: success.value(forKey: "status")!)
            if status == "1"{
                print("success from the server is which is i am getting")
                self.listofCommetArray = []
                self.listofCommetArray = success.object(forKey:"TVComment") as! NSArray
                self.CommentTableView.reloadData()
            }
            else if status == "0"{
                self.listofCommetArray = []
                self.CommentTableView.reloadData()
            }
        }, Failure: {failler in
            //something wrong
        })
    }
    
    func LikeAction() {
        
    }
}
