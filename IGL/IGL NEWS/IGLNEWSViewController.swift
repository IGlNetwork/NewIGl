//
//  IGLNEWSViewController.swift
//  IGL
//
//  Created by baps on 07/10/18.
//  Copyright © 2018 Mac Min. All rights reserved.
//

import UIKit
import Foundation
class CommentCell: UITableViewCell {
    @IBOutlet weak var ProfileImageView:UIImageView!
    @IBOutlet weak var UserNameLabel:UILabel!
    @IBOutlet weak var CommentedTimelabel:UILabel!
    @IBOutlet weak var CommentLavel:UILabel!
}

class IGLNEWSViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate{

    @IBOutlet weak var VIEWMOREBUTTON: UIButton!
    @IBOutlet weak var LikesListView: UIView!
    
    @IBOutlet weak var LikesTableView: UITableView!
    @IBOutlet weak var NewsTitle: UILabel!
    @IBOutlet weak var NewsDate: UILabel!
    @IBOutlet weak var NewImage: UIImageView!
    @IBOutlet weak var NewsDecriptionLabel: UILabel!
    @IBOutlet weak var NLikeLabel: UILabel!
    @IBOutlet weak var CommentLabel: UILabel!
    @IBOutlet weak var ComentView: UIView!
    @IBOutlet weak var ComentTextView: UITextView!
    @IBOutlet weak var Comentlisttableview: UITableView!
    
    @IBOutlet weak var PostButton: UIButton!
    
    @IBOutlet weak var BackgroundView: UIView!
    
    
    var NewsId = ""
    var newsLink = ""
    var comentarray = ["sunt in culpm aperiam, eaque ipsa quae ab illo inventore veritatis","sunt ins , eaque ipsa quae ab illo inventore veritatis","sue ipsa quae ab illo inventore veritatis","good New for igl Associations","Good App development By IOs Team in culpa qui officia deserunt mollit"]
    var ComentArrayData:NSArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
        ComentTextView.delegate =  self
        VIEWMOREBUTTON.layer.cornerRadius = 10
        PostButton.layer.cornerRadius = 16
       // ComentTextView.layer.borderWidth = 0.3
        BackgroundView.isHidden = true
        ComentView.isHidden = true
        LikesListView.isHidden = true
        Comentlisttableview.sectionHeaderHeight = 0.0;
        self.Comentlisttableview.separatorStyle = .none
        ComentTextView.text = "Write your comment"
        ComentTextView.textColor = .lightGray
        LikesTableView.separatorStyle = .none
        GetAll_Comment()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.GetNewsDetils()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func CloseLikeView(_ sender: Any) {
       BackgroundView.isHidden = true
        LikesListView.isHidden = true
       
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.LikesTableView{
            return self.arrLikesArray.count
        }else{
            print("count of the dat which is coming from the server is",ComentArrayData.count)
            return ComentArrayData.count
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.LikesTableView{
           let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
               Global.roundRadius(cell.ProfileImageView)
            let obj = self.arrLikesArray[indexPath.row] as! NSDictionary
            cell.UserNameLabel.text = obj.value(forKey: "username") as! String
            let ProfileUrl = URL(string: obj.value(forKey: "UserProfileImage") as! String)
            cell.ProfileImageView?.kf.setImage(with: ProfileUrl,
                                               placeholder:UIImage(named: "placeholder"),
                                               options: [.transition(.fade(1))],
                                               progressBlock: nil,
                                               completionHandler: nil)
            cell.selectionStyle = .none
             return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
            print("cell for row at index is99999((((((((((((")
            let obj  = ComentArrayData[indexPath.row] as! NSDictionary
            let comment = obj["NewsCommentText"] as! String //"hello world".firstCapitalized
            cell.CommentLavel.text = comment.firstCapitalized
            let DateFormate = Global.nsdateFromString(obj["NewsCommentCreatedAt"] as! String, dateFormate: "yyyy-MM-dd HH-mm-ss")
            let date =  DateFormate.timeAgoSinceDate()
            cell.CommentedTimelabel.text = obj.value(forKey: "TimeAgo") as! String
            cell.UserNameLabel.text = obj["username"] as! String
            let ProfileUrl = URL(string: obj.value(forKey: "UserProfileImage") as! String)
            cell.ProfileImageView?.kf.setImage(with: ProfileUrl,
                                               placeholder:UIImage(named: "vikings-war-of-clans_min"),
                                               options: [.transition(.fade(1))],
                                               progressBlock: nil,
                                               completionHandler: nil)
            Global.roundRadius(cell.ProfileImageView)
            cell.selectionStyle = .none
             return cell
        }
        
       
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
        if tableView == self.LikesTableView{
            print("Task indexPath.row:",indexPath.row)
            let vc : PersonalProfileViewController = mainStoryboard.instantiateViewController(withIdentifier: "PersonalProfileViewController")as! PersonalProfileViewController
            let obj = self.arrLikesArray[indexPath.row] as! NSDictionary
           let userid  = obj.value(forKey: "id") as! String
            vc.otherUserId = userid
            vc.COmingFromLandingScreen = false
            print("user id ic coming", vc.otherUserId)
           self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if (textView.text == "Write your comment" && textView.textColor == .lightGray)
        {
            textView.text = ""
            textView.textColor = .black
        }
        textView.becomeFirstResponder() //Optional
    }
    
    func textViewDidEndEditing(_ textView: UITextView)
    {
        if (textView.text == "")
        {
            textView.text = "Write your comment"
            textView.textColor = .lightGray
        }
        textView.resignFirstResponder()
    }
    @IBAction func CloseViewAction(_ sender: Any) {
        ComentView.isHidden = true
        BackgroundView.isHidden = true
         self.GetNewsDetils()
    }
    
    
    @IBAction func OpenComentView(_ sender: Any) {
      
        BackgroundView.isHidden = false
        ComentView.isHidden =  false
        ComentTextView.text == "Write your comment"
        self.GetAll_Comment()
        self.Comentlisttableview.reloadData()
    }
    
    @IBAction func AddCommentAction(sender:UIButton){
        if ComentTextView.text == "Write your comment" || ComentTextView.text ==  nil || ComentTextView.text ==  "" {
            Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage: "Comment cannot be blank")
        }
        else{
        AddComment()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let touch: UITouch = touches.first!
        if touch.view != self.ComentView
        {
            self.BackgroundView.isHidden = true
            self.ComentView.isHidden = true
            LikesListView.isHidden = true
            GetNewsDetils()
            
        }
    }
    
    @IBAction func openLikeAction(_ sender: Any) {
        BackgroundView.isHidden = false
        LikesListView.isHidden = false
        GetLikesMemberList()
    }
    
    @IBAction func ShareAction(sender:UIButton){
        let text =  self.newsLink
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop]
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
    @IBAction func BackAction(_sender:Any)
    {
//        let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
//        let vc : IGLNewsListViewController = mainStoryboard.instantiateViewController(withIdentifier: "SW-Reaveal")as! SWRevealViewController
//        self.present(vc, animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ViewMoreNewsAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "IGLNewsListViewController")as! IGLNewsListViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
        
       // self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func LikeAction(_ sender: Any) {
        Like_Action()
    }
    
    @IBAction func NotiAction(_ sender:Any)
    {
        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
        let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(SwreavelObj, animated: true)
    }
    
    func GetNewsDetils(){
        var DIcInput = [String:AnyObject]()
        DIcInput = ["user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject,"news_id":self.NewsId as AnyObject]
        print("Dict Newsss:::::::",DIcInput)
        WebHelper.requestPostUrl(strURL: GlobalConstant.newsdetails, Dictionary: DIcInput, Success: {success in
          
            if success["status"] as! String == "1"{
                
                let  newsDetails = success["NewsDetails"] as! NSDictionary
                self.NewsTitle.text = newsDetails["NewsTitle"] as! String
                self.NewsDate.text = newsDetails["NewsDate"] as! String
                self.NewsDecriptionLabel.text = newsDetails["NewsDescription"] as! String
                self.newsLink =  newsDetails["ShareLink"] as! String//ShareLink
                //   0 Likes | 1 Like | 2 Likes
                let NLike = String(describing: newsDetails.value(forKey: "Nlike")!)//newsDetails["Nlike"] as! String
                print("like count us",NLike)
                if NLike == "0"{
                   self.NLikeLabel.text = "0 LIKES"
                }else if NLike == "1"{
                   self.NLikeLabel.text = "\(NLike) LIKE"
                }else if NLike == ""{
                     self.NLikeLabel.text = "0 LIKES"
                }else{
                     self.NLikeLabel.text = "\(NLike) LIKES"
                }
                //  0 Comments | 1 Comment | 2 Comments
                let comment = String(describing: newsDetails.value(forKey: "NCommentCount")!)//newsDetails["NCommentCount"] as! String
                if comment == "0"{
                      self.CommentLabel.text = "0 COMMENTS"
                }else if comment == "1"{
                      self.CommentLabel.text = "1 COMMENT"
                }else if comment == ""{
                      self.CommentLabel.text = "0 COMMENTS"
                }else{
                     self.CommentLabel.text = "\(comment) COMMENTS"
                }
                
              
                let url1 = URL(string:newsDetails["NewsImage"] as! String)
                self.NewImage?.kf.setImage(with: url1,
                                                 placeholder:UIImage(named: "profile-top-banner"),
                                                 options: [.transition(.fade(1))],
                                                 progressBlock: nil,
                                                 completionHandler: nil)
                self.GetLikesMemberList()
            }
        }, Failure: {failler in
            
        })
    }
    
    func Like_Action()
    {
        var DIcInput = [String:AnyObject]()
        DIcInput = ["user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject,"news_id":self.NewsId as AnyObject]
        print("input dictionary of the input parameter is coming api name newslike",DIcInput)
        WebHelper.requestPostUrl(strURL:GlobalConstant.newslike, Dictionary: DIcInput, Success: { success in
            if success["status"] as! String ==  "1"{
//                let NLike = success["Nlike"] as! String
//               self.NLikeLabel.text = "Like(\(NLike))"
                self.GetNewsDetils()
            }
        }, Failure: {faillelr in
            print("something went wrong??",faillelr.localizedDescription,faillelr.localizedFailureReason,faillelr.localizedRecoveryOptions)
          // Global.showAlertMessageWithOkButtonAndTitle("IGL", andMessage: faillelr.localizedDescription)
        })
    }
    
    //URL : https://iglnetwork.com/beta/api-V1/get_newslikememberlist
   //Parameters : news_id
    var arrLikesArray:NSArray = []
    func GetLikesMemberList() {
        var DIcInput = [String:AnyObject]()
        DIcInput = ["news_id":self.NewsId as AnyObject]
        WebHelper.requestPostUrl(strURL: GlobalConstant.get_newslikememberlist, Dictionary: DIcInput, Success: {success in
            let status = String(describing: success.value(forKey: "status")!)
            if status == "1"{
                self.arrLikesArray = success.value(forKey: "Userlist") as! NSArray
                self.LikesTableView.reloadData()
            }else{
                
            }
        }, Failure: {failler in
            print("somethng went wrong???")
        })
        
    }
    
    func GetAll_Comment(){
        var DicInput = ["user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject,"news_id":self.NewsId as AnyObject]
        WebHelper.requestPostUrl(strURL: GlobalConstant.get_newscomments, Dictionary: DicInput, Success: {success in
            
            if success["status"] as! String == "1"
            {
                self.ComentArrayData = success.value(forKey: "NewsComment") as! NSArray
                print("sunil----------------------------------------------------",self.ComentArrayData)
                self.Comentlisttableview.reloadData()
            }
            else if success["status"] as! String == "0"
            {
              Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage: success.value(forKey: "msg") as! String)
            }
        }, Failure: {failler in
            Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage:failler.localizedDescription)
        })
    }
    func AddComment(){
        var DicInput = ["user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject,"news_id":self.NewsId as AnyObject,"commenttext": self.ComentTextView.text  as AnyObject]
        WebHelper.requestPostUrl(strURL: GlobalConstant.comment_news, Dictionary: DicInput, Success: {
            success in
            if success["status"] as! String == "1"{
                self.GetAll_Comment()
                
                self.Comentlisttableview.reloadData()
                self.ComentTextView.text = ""
            }
            else if  success["status"] as! String == "0"{
            Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage: success.value(forKey: "msg") as! String)
            }
        }, Failure: {failler in
            Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APIKey, andMessage: failler.localizedDescription)
        })
    }
}



    extension Date {
        
        func timeAgoSinceDate() -> String {
            
            // From Time
            let fromDate = self
            
            // To Time
            let toDate = Date()
            
            // Estimation
            // Year
            if let interval = Calendar.current.dateComponents([.year], from: fromDate, to: toDate).year, interval > 0  {
                
                return interval == 1 ? "\(interval)" + " " + "year ago" : "\(interval)" + " " + "years ago"
            }
            
            // Month
            if let interval = Calendar.current.dateComponents([.month], from: fromDate, to: toDate).month, interval > 0  {
                
                return interval == 1 ? "\(interval)" + " " + "month ago" : "\(interval)" + " " + "months ago"
            }
            
            // Day
            if let interval = Calendar.current.dateComponents([.day], from: fromDate, to: toDate).day, interval > 0  {
                
                return interval == 1 ? "\(interval)" + " " + "day ago" : "\(interval)" + " " + "days ago"
            }
            
            // Hours
            if let interval = Calendar.current.dateComponents([.hour], from: fromDate, to: toDate).hour, interval > 0 {
                
                return interval == 1 ? "\(interval)" + " " + "hour ago" : "\(interval)" + " " + "hours ago"
            }
            
            // Minute
            if let interval = Calendar.current.dateComponents([.minute], from: fromDate, to: toDate).minute, interval > 0 {
                
                return interval == 1 ? "\(interval)" + " " + "minute ago" : "\(interval)" + " " + "minutes ago"
            }
            
            return "a moment ago"
        }
       
    }

extension String {
    var firstCapitalized: String {
        var components = self.components(separatedBy: " ")
        guard let first = components.first else {
            return self
        }
        components[0] = first.capitalized
        return components.joined(separator: " ")
    }
}
