//
//  CheckedInTeamViewController.swift
//  IGL
//
//  Created by Mac Min on 15/01/19.
//  Copyright © 2019 Mac Min. All rights reserved.
//
class CheckedInTeams
{
    var TeamName = ""
    var imageUrl = ""
    var TeamID = ""
    func toString() -> String {
        return "CheckedInTeams{TeamName:"+TeamName+"}"
    }
    
    
}



import UIKit

class CheckedInTeamListCell: UITableViewCell {
    @IBOutlet weak var TeamPfofileImage:UIImageView!
    @IBOutlet weak var TeamNameLabel:UILabel!
}


class CheckedInTeamViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{

    @IBOutlet weak var TeamListTableview: UITableView!
    
    @IBOutlet weak var Searchiew: UIView!
    
    @IBOutlet weak var SearchField: UISearchBar!
    var Tournament_Id = ""
    var CheckedInTeamsArray:NSArray = []
    var arrTeasmList:[CheckedInTeams] = []
    var filteredModel = [CheckedInTeams]()
      var isSearching = false
    override func viewDidLoad() {
        super.viewDidLoad()
        GetCheckedInTeamList()
        SearchField.delegate = self
        Searchiew.layer.cornerRadius = 15
        TeamListTableview.separatorStyle = .none
        // Do any additional setup after loading the view.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredModel.count
        }else{
        if arrTeasmList.count == 0{
            self.TeamListTableview.setEmptyMessage("No data found!!")
        }else {
            self.TeamListTableview.restore()
        }
            return arrTeasmList.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckedInTeamListCell", for: indexPath) as! CheckedInTeamListCell
     //   if CheckedInTeamsArray.count != 0{
            
            let obj: CheckedInTeams
            if isSearching {
                obj = filteredModel[indexPath.row]
               
            } else {
                obj = arrTeasmList[indexPath.row]
                
            }
         //   let obj = arrTeasmList[indexPath.row]
            let imageURl = obj.imageUrl
        print("url of the image is-=-=-=-=-=-=-=-=-=",imageURl)
           let url2 = URL(string:imageURl)
            //search-icon-btn
        cell.TeamPfofileImage?.kf.setImage(with: url2,
                                                placeholder:UIImage(named: "vikings-war-of-clans_min"),
                                                  options: [.transition(.fade(1))],
                                                  progressBlock: nil,
                                                 completionHandler: nil)
            cell.TeamPfofileImage.layer.cornerRadius =  cell.TeamPfofileImage.frame.height/2
            cell.TeamPfofileImage.clipsToBounds = true
            let TeamName = obj.TeamName
            cell.TeamNameLabel.text = TeamName
       // }
        cell.selectionStyle = .none
        return cell
    }
 /*
     TeamID = 51;
     TeamImage = "http://iglnetwork.com/beta/assets/uploads/teams/15475621931533021730dota_2_official_9.jpg";
     TeamName = "ido V test team";
     */
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == ""{
            isSearching = false
            view.endEditing(true)
            self.TeamListTableview.reloadData()
            //
        }else{
            
            isSearching = true
            filteredModel = arrTeasmList.filter({( candy : CheckedInTeams) -> Bool in
                return candy.toString().lowercased().contains(searchText.lowercased())
            })
            self.TeamListTableview.reloadData()
        }
    }
    func GetCheckedInTeamList() {
        var DicInpu = ["user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject,"tournament_id": self.Tournament_Id as AnyObject]
        WebHelper.requestPostUrl(strURL: GlobalConstant.tournamentcheckinteams, Dictionary: DicInpu, Success: {success in
            let status = String(describing: success.value(forKey: "status")!)
            if status == "1"{
             let CheckedInTeamsArray = success.object(forKey: "Teamlist") as! NSArray
                for obj in CheckedInTeamsArray{
                    let teamobj = CheckedInTeams()
                    let dic  = obj as! NSDictionary
                   teamobj.TeamName = dic.value(forKey: "TeamName") as! String
                   teamobj.TeamID = dic.value(forKey: "TeamID") as! String
                   teamobj.imageUrl = dic.value(forKey: "TeamImage") as! String
                 self.arrTeasmList.append(teamobj)
                }
               // print("data of array",self.CheckedInTeamsArray)
                self.TeamListTableview.reloadData()
                
            }
            else if status == "0"{
                
            }
            
        }, Failure: {failler in
            Global.showAlertMessageWithOkButtonAndTitle("", andMessage: failler.localizedDescription)
        })
    }
    

}
extension UITableView {
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.textColor = UIColor.white
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel;
        self.separatorStyle = .none;
    }
    
    func restore() {
        self.backgroundView = nil
      ///  self.separatorStyle = .singleLine
    }
}
