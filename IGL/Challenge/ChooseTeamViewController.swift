//
//  ChooseTeamViewController.swift
//  IGL
//
//  Created by baps on 08/11/18.
//  Copyright © 2018 Mac Min. All rights reserved.
//

import UIKit

class ChooseTeamCell: UITableViewCell {
    @IBOutlet weak var TeamImage:UIImageView!
    @IBOutlet weak var TeamNameLabel:UILabel!
    @IBOutlet weak var SelectButton:UIButton!
}

class ChooseTeamViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchDisplayDelegate {
    
    @IBOutlet weak var SearchTeamView: UIView!
    @IBOutlet weak var ListOfTeamTableView: UITableView!
    @IBOutlet weak var CreateTeamButton: UIButton!
    @IBOutlet weak var SearchBar: UISearchBar!
    // var teamList:NSArray = []
    var tournament_id = ""
    var team_id = ""
    var Game_Id = ""
    var isSearching = false
    var Pending:[SearchModelForTeamList] = []
    var filteredModel = [SearchModelForTeamList]()
    
    // to pre populate data in Create team. send this obj to CreateTeam Class and Fill it to the fields.
    var gameObj:NSDictionary?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SearchTeamView.layer.cornerRadius = 15
        ListOfTeamTableView.separatorStyle = .none
        CreateTeamButton.layer.cornerRadius = 10
       
        // Do any additional setup after loading the view.
        
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
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        // write here your code
         self.TeamList()
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == ""{
            isSearching = false
            view.endEditing(true)
            self.ListOfTeamTableView.reloadData()
            //
        }else{
            
            isSearching = true
            filteredModel = Pending.filter({( candy : SearchModelForTeamList) -> Bool in
                return candy.toString().lowercased().contains(searchText.lowercased())
            })
            self.ListOfTeamTableView.reloadData()
        }
    }
    
    
    
    
    
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredModel.count
        } else {
            return Pending.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChooseTeamCell", for: indexPath) as! ChooseTeamCell
        Global.roundRadius(cell.TeamImage)
        cell.SelectButton.layer.cornerRadius = 10
        cell.SelectButton.tag = indexPath.row
        cell.SelectButton.addTarget(self, action: #selector(buttonSelected), for: .touchUpInside)
        cell.selectionStyle = .none
        
        let dict: SearchModelForTeamList
        if isSearching {
            dict = filteredModel[indexPath.row]
            print(dict,"filteredModel[indexPath.row]")
        } else {
            dict = Pending[indexPath.row]
            print(dict,"Pending[indexPath.row]")
        }
        
        // let dict = teamList[indexPath.row] as! NSDictionary
        cell.TeamNameLabel.text =  dict.TeamName   //dict.value(forKey: "TeamName") as! String
        
        let url = URL(string:dict.TeamImage)
        cell.TeamImage?.kf.setImage(with: url,
                                    placeholder:UIImage(named: "OpponentProfile"),
                                    options: [.transition(.fade(1))],
                                    progressBlock: nil,
                                    completionHandler: nil)
        
        cell.SelectButton.tag = indexPath.row
        
        return cell
    }
    
    @IBAction func CreateTeamAction(_ sender: Any) {
        let StoryBoardObj = UIStoryboard(name: "Main", bundle: nil)
        let AddTeamObj = StoryBoardObj.instantiateViewController(withIdentifier: "ProfileCreateTeamVC") as! ProfileCreateTeamVC
        AddTeamObj.gameObj = self.gameObj
        self.navigationController?.pushViewController(AddTeamObj, animated: true)
        
    }
    
    /*
     "TeamID": "18",
     "UserID": "9489",
     "TeamName": "Ido new team",
     "TeamImage": "http://iglnetwork.com/beta/assets/uploads/teams/1544415082_thumb_8a55928a-116c-4943-a0b4-5bf3a3094651.jpg",
     "MemberCount": null
     */
    @objc func buttonSelected(sender: UIButton){
        let dict: SearchModelForTeamList
        if isSearching {
            dict = filteredModel[sender.tag]
            print(dict,"filteredModel[indexPath.row]")
        } else {
            dict = Pending[sender.tag]
            print(dict,"Pending[indexPath.row]")
        }
        
        ChallengePrizeViewController.from_team_id = dict.TeamID
        //  self.join_tournament()
        let StoryBoardObj = UIStoryboard(name: "Main", bundle: nil)
        let obj = StoryBoardObj.instantiateViewController(withIdentifier: "FindChallengerViewController") as! FindChallengerViewController
        self.navigationController?.pushViewController(obj, animated: true)
    }
    
    func TeamList()
    {
        var dictPost:[String: AnyObject]!
        let user_id = UserDefaults.standard.value(forKey:"user_id")
        dictPost = ["user_id": user_id  as AnyObject,"game_id":self.Game_Id as AnyObject]
        print("Dictionary9394:",dictPost)
        
        WebHelper.requestPostUrl(strURL: GlobalConstant.get_usergameteams, Dictionary: dictPost, Success:{
            success in
            let status = success.object(forKey: "status") as! String
            print("success:",success)
            /// Result fail
            if status == "0"
            {
            }
                /// Result success
            else if status == "1"
            {
                self.Pending.removeAll()
                let teamLists = success.object(forKey: "TeamList") as! NSArray
                
                for i in 0..<teamLists.count{
                    let dic:NSDictionary = teamLists[i] as! NSDictionary
                    let filter = SearchModelForTeamList()
                    filter.TeamID = Global.getStringValue(dic.value(forKey: "TeamID")  as AnyObject)
                    filter.TeamImage = Global.getStringValue(dic.value(forKey: "TeamImage")  as AnyObject)
                    filter.TeamName = Global.getStringValue(dic.value(forKey: "TeamName")  as AnyObject)
                    filter.UserID = Global.getStringValue(dic.value(forKey: "UserID")  as AnyObject)
                    self.Pending.append(filter)
                }
                
                self.ListOfTeamTableView.reloadData()
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
    
    func join_tournament()
    {
        var dictPost:[String: AnyObject]!
        dictPost = ["tournament_id":self.tournament_id as AnyObject,"user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject,"team_id":self.team_id as AnyObject]
        print("Dictionary:",dictPost)
        
        WebHelper.requestPostUrl(strURL: GlobalConstant.join_tournament, Dictionary: dictPost, Success:{
            success in
            let status = success.object(forKey: "status") as! String
            print("success:",success)
            /// Result fail
            if status == "0"
            {
            }
                /// Result success
            else if status == "1"
            {
                
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




class SearchModelForTeamList
{
    
    var TeamID = ""
    var TeamImage = ""
    var TeamName = ""
    var UserID = ""
    
    
    func toString()-> String{
        return "SearchTeamListModel{TeamID:"+TeamID+",TeamImage:"+TeamImage+",TeamName:"+TeamName+",UserID:"+UserID+"}"
    }
}




/*
 
 success: {
 TeamList =     (
 {
 MemberCount = "<null>";
 TeamID = 10;
 TeamImage = "http://iglnetwork.com/beta/assets/images/thumb-7.jpg";
 TeamName = "nivi test team";
 UserID = 9493;
 },
 {
 MemberCount = "<null>";
 TeamID = 11;
 TeamImage = "http://iglnetwork.com/beta/assets/images/thumb-7.jpg";
 TeamName = "nivi team 2";
 UserID = 9493;
 },
 
 
 */

