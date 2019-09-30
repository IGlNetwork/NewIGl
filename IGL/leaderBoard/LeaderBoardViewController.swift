//
//  LeaderBoardViewController.swift
//  IGL
//
//  Created by Mac Min on 04/10/18.
//  Copyright © 2018 Mac Min. All rights reserved.
//

import UIKit
import SafariServices


class LeaderBoardcell: UITableViewCell {
    @IBOutlet weak var RanKLabeel:UILabel!
    @IBOutlet weak var TeamProfile:UIImageView!
    @IBOutlet weak var TeamNamelabel:UILabel!
    @IBOutlet weak var Pointlaabel:UILabel!
    
    @IBOutlet weak var CitiesNameLabel: UILabel!
    
    
}

class LeaderBoardViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIPopoverPresentationControllerDelegate{
@IBOutlet weak var LeaderBoadtable:UITableView!
@IBOutlet weak var BottomlayoutOfTaableView: NSLayoutConstraint!
    @IBOutlet weak var selectGameView:UIView!
    @IBOutlet weak var selectMonthView:UIView!
    @IBOutlet weak var selectYearView:UIView!
    
    @IBOutlet weak var BackgroundView: UIView!
    @IBOutlet weak var PickerViewContainer: UIView!
    @IBOutlet weak var YearTextField: UITextField!
    @IBOutlet weak var MonthtextField: UITextField!
    
    @IBOutlet weak var YearButton: UIButton!
    @IBOutlet weak var SearchView: UIView!
    
    @IBOutlet weak var SelectCityView: UIView!
    @IBOutlet weak var Monthbutton: UIButton!
    @IBOutlet weak var SelectgameButton: UIButton!
    @IBOutlet weak var SelectGameTextField: UITextField!
    
    @IBOutlet weak var CityDropButton: UIButton!
    
    @IBOutlet weak var SelectCitytextField: UITextField!
    
    var LeaderArray:NSArray = []
    
     var   month = ""
     var  year = ""
     var game_id = ""
     var city = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
         setCurrentMonthYear()
        //to removee the ine between cells of the tableview
        LeaderBoadtable.sectionHeaderHeight = 0.0;
        self.LeaderBoadtable.separatorStyle = .none
        // Do any additional setup after loading the view.
        selectGameView.layer.cornerRadius = 13
        selectMonthView.layer.cornerRadius = 13
        selectYearView.layer.cornerRadius = 13
        SelectCityView.layer.cornerRadius = 13
        SearchView.layer.cornerRadius = 15
        togetLeaderShipBoard(gameid: "", cityNmae: "", month:"", Year: "", PNO: "0")
     //   GetgameList()
        GetListOfCity()
        get_games()
       
        
    }
    
    func setCurrentMonthYear()
    {
        // MonthtextField
        // YearTextField
        let crntDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        MonthtextField.text! = formatter.string(from: crntDate)
        formatter.dateFormat = "yyyy"
        YearTextField.text! = formatter.string(from: crntDate)
        self.year = YearTextField.text!
        formatter.dateFormat = "MM"
        self.month =  formatter.string(from: crntDate)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.backgroundColor = UIColor(displayP3Red: 52, green: 134, blue: 204, alpha: 1)
//         self.navigationController?.navigationBar.isTranslucent = true
    }
    
    @IBAction func SelectMonthAction(_ sender: Any) {
        let obj = self.storyboard!.instantiateViewController(withIdentifier: "DropDownVCDayMonth") as! DropDownVCDayMonth
        obj.commingFrom = "Month"
        obj.VCObj =  self
        obj.modalPresentationStyle = UIModalPresentationStyle.popover
        obj.preferredContentSize = CGSize(width:150, height: 300)
        obj.popoverPresentationController!.delegate = self
        self.present(obj, animated: true, completion: nil)
        let popover = obj.popoverPresentationController
        popover!.sourceView = Monthbutton
        popover!.sourceRect =  Monthbutton.bounds
        popover!.permittedArrowDirections = UIPopoverArrowDirection.up
        view.endEditing(true)
    }
    
    
    @IBAction func SelectYearAction(_ sender: Any) {
        let obj = self.storyboard!.instantiateViewController(withIdentifier: "DropDownVCDayMonth") as! DropDownVCDayMonth
        obj.commingFrom = "Year"
        obj.VCObj =  self
        obj.modalPresentationStyle = UIModalPresentationStyle.popover
        obj.preferredContentSize = CGSize(width:100, height: 200)
        obj.popoverPresentationController!.delegate = self
        self.present(obj, animated: true, completion: nil)
        let popover = obj.popoverPresentationController
        popover!.sourceView = YearButton
        popover!.sourceRect =  YearButton.bounds
        popover!.permittedArrowDirections = UIPopoverArrowDirection.up
        view.endEditing(true)
        
    }
    
    @IBAction func SelectCityAction(_ sender: Any) {
       let obj = self.storyboard!.instantiateViewController(withIdentifier: "DropDownVCDayMonth") as! DropDownVCDayMonth
        obj.commingFrom = "City"
        obj.VCObj =  self
        obj.modalPresentationStyle = UIModalPresentationStyle.popover
        obj.preferredContentSize = CGSize(width:150, height: 500)
        obj.popoverPresentationController!.delegate = self
        self.present(obj, animated: true, completion: nil)
        let popover = obj.popoverPresentationController
        popover!.sourceView = CityDropButton
        popover!.sourceRect =  CityDropButton.bounds
        popover!.permittedArrowDirections = UIPopoverArrowDirection.up
        view.endEditing(true)
    }
    
    
    @IBAction func ToselectGameAction(_ sender: Any) {
        
        let obj = self.storyboard!.instantiateViewController(withIdentifier: "DropDownVCDayMonth") as! DropDownVCDayMonth
        obj.commingFrom = "Game"
        obj.VCObj =  self
        obj.modalPresentationStyle = UIModalPresentationStyle.popover
        obj.preferredContentSize = CGSize(width:150, height: 200)
        obj.popoverPresentationController!.delegate = self
        self.present(obj, animated: true, completion: nil)
        let popover = obj.popoverPresentationController
        popover!.sourceView = SelectgameButton
        popover!.sourceRect =  SelectgameButton.bounds
        popover!.permittedArrowDirections = UIPopoverArrowDirection.up
        view.endEditing(true)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.LeaderArray.count
    }
    
    /* City = "";
     LeaderboardPoints = 5;
     Rank = 12;*/
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderBoardcell", for: indexPath) as! LeaderBoardcell
        Global.roundRadius(cell.TeamProfile)
        cell.selectionStyle = .none
        
        let obj = self.LeaderArray[indexPath.row] as! NSDictionary
        cell.Pointlaabel.text = obj.value(forKey: "LeaderboardPoints") as! String
        cell.RanKLabeel.text = String(describing:obj.value(forKey:"Rank")!)//obj.value(forKey:"Rank") as! String
        if obj.value(forKey:"City") as! String == ""{
            cell.CitiesNameLabel.text = "City Name"
        }else{
        cell.CitiesNameLabel.text = obj.value(forKey:"City") as! String
        }
        let url2 = URL(string: obj.value(forKey: "TeamImage") as! String)
        cell.TeamProfile?.kf.setImage(with: url2,
                                               placeholder:UIImage(named: "vikings-war-of-clans_min"),
                                               options: [.transition(.fade(1))],
                                               progressBlock: nil,
                                               completionHandler: nil)
        cell.TeamNamelabel.text = obj.value(forKey: "TeamName") as! String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dict = self.LeaderArray[indexPath.row] as! NSDictionary
        let teamid = dict.value(forKey: "TeamID") as! String
       let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
        let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"TeamDeatilsViewController") as! TeamDeatilsViewController
        SwreavelObj.team_id = dict.value(forKey: "TeamID") as! String//Global.getStringValue(obj.value(forKey: "TeamID") as AnyObject)
        self.navigationController?.pushViewController(SwreavelObj, animated: true)
        
        
        
        
        
//        let user_id = UserDefaults.standard.value(forKey: "user_id") as! String
//        let url = "https://iglnetwork.com/beta/profile/teamdetails/\(teamid)/\(user_id)"
//        print("url is coming",url)
//        let svc = SFSafariViewController(url: URL(string: url)!, entersReaderIfAvailable: true)
//        svc.preferredBarTintColor =   #colorLiteral(red: 0.06274509804, green: 0.1411764706, blue: 0.2705882353, alpha: 1)
//        svc.preferredControlTintColor = #colorLiteral(red: 0.06274509804, green: 0.1411764706, blue: 0.2705882353, alpha: 1)
//        present(svc, animated: true, completion: nil)
//        if #available(iOS 11.0, *) {
//            svc.dismissButtonStyle = .close
//        } else {
//            // Fallback on earlier versions
//        }
        
    }
    
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func BackAction(_sender:Any)
    {
        let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
        let vc : SWRevealViewController = mainStoryboard.instantiateViewController(withIdentifier: "SW-Reaveal")as! SWRevealViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle
    {
        return UIModalPresentationStyle.none
    }
    


    @IBAction func NotiAction(_ sender:Any)
    {
        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
        let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(SwreavelObj, animated: true)
    }
    
    @IBAction func Searchaction(_ sender: UIButton) {
        
        self.year = YearTextField.text!
      //  self.month = MonthtextField.text!
        self.city = SelectCitytextField.text!
    print(self.game_id,"  ",self.year,"  ",self.city,"  ",self.month,"  ")
//        if self.game_id == "" || self.year == "" || self.city == "" || self.month == ""
//        {
//           togetLeaderShipBoard(gameid:"", cityNmae: "", month: "", Year:  "", PNO: "0")
//        }
//        else{//self.city
//        togetLeaderShipBoard(gameid: self.game_id, cityNmae:  self.city, month:  self.month, Year:  self.year, PNO: "0")
//        }
        
        togetLeaderShipBoard(gameid: self.game_id, cityNmae:  self.city, month:  self.month, Year:  self.year, PNO: "0")
    }
    /*
     
     //PNO: page number (start from 0)
    // month: for filter(2 digit)
    // year: for filter (4 digit)
    // game_id: game id
     city: city name

     */
    
    
    func togetLeaderShipBoard(gameid:String,cityNmae:String,month:String,Year:String,PNO:String) {
        var DicInput = ["PNO":PNO as AnyObject,"month":month  as AnyObject,"year":Year as AnyObject,"game_id": gameid as AnyObject,"city":cityNmae as AnyObject]
        print("input data is ",DicInput)
        WebHelper.requestPostUrl(strURL: GlobalConstant.get_leaderboard
, Dictionary: DicInput, Success: {success in
    let status = String(describing: success.value(forKey: "status")!)
    
    if status == "1"{
         self.LeaderArray = []
      self.LeaderArray = success.object(forKey: "Leaderboardlist") as! NSArray
        self.LeaderBoadtable.reloadData()
    }
    else if status == "0"{
         self.LeaderArray = []
        self.LeaderBoadtable.reloadData()
        Global.showAlertMessageWithOkButtonAndTitle("", andMessage: success.value(forKey: "msg") as! String)
    }
    
    
        }, Failure: {failler in
            print("Something went wrong",failler.localizedDescription)
        })
    }
    
    
    func GetListOfCity()  {
        var DicInput = [String:AnyObject]()
        WebHelper.requestPostUrl(strURL: GlobalConstant.get_cities, Dictionary: DicInput, Success: {success in
            let status = String(describing: success.value(forKey: "status")!)
            if status == "1"{
                DropDownVCDayMonth.CityArrray = []
                DropDownVCDayMonth.CityArrray = success.object(forKey: "CityList") as! NSArray
            }else if status == "0"{
                
            }
        }, Failure: {failler in
            print("something went wrong",failler.localizedDescription)
        })
    }
  
    func get_games()
    {
        var dictPost:[String: AnyObject]!
        dictPost = ["PNO":"0" as AnyObject,"platform":"1" as AnyObject]
        print("Dictionary:",dictPost)
        WebHelper.requestPostUrl(strURL: GlobalConstant.get_games, Dictionary: dictPost, Success:{
            success in
            let status = success.object(forKey: "status") as! String
            print("status:",success)
            /// Result fail
            if status == "0"
            {
                
            } /// Result success
            else if status == "1"
            {
                
                DropDownVCDayMonth.GameList = []
                DropDownVCDayMonth.GameList = success.object(forKey: "Gamelist") as! NSArray
               
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
