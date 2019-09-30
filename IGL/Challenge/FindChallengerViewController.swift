//
//  FindChallengerViewController.swift
//  IGL
//
//  Created by baps on 02/10/18.
//  Copyright © 2018 Mac Min. All rights reserved.
//

import UIKit
class FindchallengeCell: UITableViewCell {
    @IBOutlet weak var ImageView:UIImageView!
    @IBOutlet weak var opponentNameLabel:UILabel!
    @IBOutlet weak var HourLabel:UILabel!
    @IBOutlet weak var SendChallengeButton:UIButton!
    @IBOutlet weak var Favoiratebutton: UIButton!
}
class FindChallengerViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchDisplayDelegate{
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var FindchallengTableview: UITableView!
    @IBOutlet weak var SearchBar: UISearchBar!
    static var Game_id = ""
    var TeamListArray:NSArray = []
    var isSearching = false
    var Pending:[SearchModelForChallenger] = []
    var filteredModel = [SearchModelForChallenger]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchView.layer.cornerRadius = 15
        FindchallengTableview.indicatorStyle = .white
        ToGetChallengerTeam()
        FindchallengTableview.separatorStyle = .none
        
        
        SearchBar.searchBarStyle = .minimal;
        SearchBar.delegate = self
        SearchBar.returnKeyType = UIReturnKeyType.done
        SearchBar.showsCancelButton = false
        
        
        let searchTextField:UITextField = SearchBar.subviews[0].subviews.last as! UITextField
        // searchTextField.layer.cornerRadius = 15
        // searchTextField.textAlignment = NSTextAlignment.left
        // let image:UIImage = UIImage(named: "search-icon-btn")!
        // let imageView:UIImageView = UIImageView.init(image: image)
        searchTextField.leftView = nil
        //searchTextField.placeholder = ""
        //searchTextField.rightView = imageView
        // searchTextField.rightViewMode = UITextFieldViewMode.always
        
        
    }
    
    
    
    
@IBAction func Dofavouriteteam(_ sender: UIButton) {
    let obj = Pending[sender.tag]
    print("team id is ",obj.TeamID)
    dofavouriteteamsMember(TeamId: obj.TeamID)
    
    }
    
    func dofavouriteteamsMember(TeamId:String){
    var DicInput = [String:AnyObject]()
        DicInput = ["user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject,"team_id":TeamId as AnyObject]
        print("input dictionay is coming from the server is ",DicInput)
        WebHelper.requestPostUrl(strURL: GlobalConstant.maketeamfavarite, Dictionary: DicInput, Success: {success in
            let status = String(describing: success.value(forKey: "status")!)
            if status == "1"{
                self.ToGetChallengerTeam()
            }else{
             print("Something went wrong????")
            }
        }, Failure: {Failler in
            print("Something went wrong????",Failler.localizedDescription)
        })
    }
    
    
    
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == ""{
            isSearching = false
            view.endEditing(true)
            self.FindchallengTableview.reloadData()
            //
        }else{
            
            isSearching = true
            filteredModel = Pending.filter({( candy : SearchModelForChallenger) -> Bool in
                return candy.toString().lowercased().contains(searchText.lowercased())
            })
            self.FindchallengTableview.reloadData()
        }
    }
    
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return TeamListArray.count
        
        if isSearching {
            return filteredModel.count
        } else {
            return Pending.count
        }
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FindchallengeCell", for: indexPath) as! FindchallengeCell
        cell.SendChallengeButton.layer.cornerRadius = 10
        let dict: SearchModelForChallenger
        if isSearching {
            dict = filteredModel[indexPath.row]
            print(dict,"filteredModel[indexPath.row]")
        } else {
            dict = Pending[indexPath.row]
            print(dict,"Pending[indexPath.row]")
        }
        cell.Favoiratebutton.tag = indexPath.row
        cell.opponentNameLabel.text = dict.TeamName
        let url = URL(string:dict.TeamImage)
        cell.ImageView?.kf.setImage(with: url,
                                    placeholder:UIImage(named: "OpponentProfile"),
                                    options: [.transition(.fade(1))],
                                    progressBlock: nil,
                                    completionHandler: nil)
    
        if dict.isfavorite == "0"
        {
            
            cell.Favoiratebutton.setImage(UIImage(named: "heart-blank"), for: UIControlState.normal)
        }
        else if dict.isfavorite == "1"
        {
         cell.Favoiratebutton.setImage(UIImage(named:"heart-filled"), for: UIControlState.normal)
        }
        cell.SendChallengeButton.tag = indexPath.row
        cell.SendChallengeButton.addTarget(self, action: #selector(buttonSelected), for: .touchUpInside)
        Global.roundRadius(cell.ImageView)
        cell.selectionStyle = .none
        return cell
    }
    @objc func buttonSelected(sender: UIButton){
        //let obj = TeamListArray[sender.tag] as! NSDictionary
        let dict: SearchModelForChallenger
        if isSearching {
            dict = filteredModel[sender.tag]
            print(dict,"filteredModel[indexPath.row]")
        } else {
            dict = Pending[sender.tag]
            print(dict,"Pending[indexPath.row]")
        }
        
        
        ChallengePrizeViewController.To_team_id  = dict.TeamID
        let storyBoardObj = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoardObj.instantiateViewController(withIdentifier: "ChallengePrizeViewController") as! ChallengePrizeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func BackAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let storyBoardObj = UIStoryboard(name: "Main", bundle: nil)
        //        let vc = storyBoardObj.instantiateViewController(withIdentifier: "ChallengePrizeViewController") as! ChallengePrizeViewController
        //       self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func NotiAction(_ sender:Any)
    {
        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
        let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(SwreavelObj, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func ToGetChallengerTeam()  {
        var DicInput = [String:AnyObject]()
        DicInput = ["game_id":FindChallengerViewController.Game_id as AnyObject,"user_id":UserDefaults.standard.value(forKey:"user_id") as AnyObject]
        WebHelper.requestPostUrl(strURL:GlobalConstant.get_challengergameteams, Dictionary: DicInput, Success: {success in
            let status = success.object(forKey: "status") as! String
            if status == "1"{
                
                self.Pending.removeAll()
                let teamLists = success.object(forKey: "TeamList") as! NSArray
                for i in 0..<teamLists.count{
                    let dic:NSDictionary = teamLists[i] as! NSDictionary
                    let filter = SearchModelForChallenger()
                    filter.TeamID = Global.getStringValue(dic.value(forKey: "TeamID")  as AnyObject)
                    filter.TeamImage = Global.getStringValue(dic.value(forKey: "TeamImage")  as AnyObject)
                    filter.TeamName = Global.getStringValue(dic.value(forKey: "TeamName")  as AnyObject)
                    filter.UserID = Global.getStringValue(dic.value(forKey: "UserID")  as AnyObject)
                    filter.isfavorite = Global.getStringValue(dic.value(forKey: "isfavorite") as AnyObject)
                    self.Pending.append(filter)
                }
                
                self.FindchallengTableview.reloadData()
                
            }
            else if status == "0"{
                
            }
        }, Failure: {failler in
            Global.showAlertMessageWithOkButtonAndTitle("", andMessage:failler.localizedDescription)
        })
        
    }
    
    
    
    
    
}






class SearchModelForChallenger
{
    
    var TeamID = ""
    var TeamImage = ""
    var TeamName = ""
    var UserID = ""
    var isfavorite = ""
    
    func toString()-> String{
        return "SearchTeamListModel{TeamID:"+TeamID+",TeamImage:"+TeamImage+",TeamName:"+TeamName+",UserID:"+UserID+"}"
    }
}


/*
 
 "TeamID": "7",
 "UserID": "9491",
 "TeamName": "johnteam |",
 "TeamImage": "http://iglnetwork.com/beta/assets/uploads/teams/1541106339dota_2_official_9.jpg",
 "MemberCount": null
 */

