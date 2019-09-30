//
//  DropDownViewController.swift
//  RentalHomeProject
//
//  Created by CodeBetter on 16/03/18.
//  Copyright © 2018 Codebetter. All rights reserved.
//

import UIKit

class DropDownViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    @IBOutlet weak var TableView: UITableView!
    var CreateTeamObj:ProfileCreateTeamVC?
    var PlateformId = ""
    static var GameArrayList:NSArray = []
    var commingfrom  = ""
    var game_Id = ""
    static var userLiatarray:NSArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
      TableView.delegate = self
        TableView.dataSource = self
//        TableView.rowHeight = UITableView.automaticDimension
//        TableView.estimatedRowHeight = UITableView.automaticDimension
        

    }
    override func viewWillAppear(_ animated: Bool) {

    }
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if commingfrom == "Game"{
            return DropDownViewController.GameArrayList.count
        }
        else if commingfrom == "Player1" || commingfrom == "Player2" || commingfrom == "Player3" || commingfrom == "Player4" || commingfrom == "Player5" || commingfrom == "Player6"{
          return  DropDownViewController.userLiatarray.count
        }
        else{
       return ProfileCreateTeamVC.PlateformArray.count
    }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
         let cell = UITableViewCell()
         cell.textLabel?.font = cell.textLabel?.font.withSize(15)
        if commingfrom == "Game"{
            let obj = DropDownViewController.GameArrayList[indexPath.row] as! NSDictionary
              cell.textLabel!.text = obj.value(forKey: "GameTitle") as! String
        }
        else if commingfrom == "Player1"{
            let obj = DropDownViewController.userLiatarray[indexPath.row] as! NSDictionary
            cell.textLabel!.text = obj.value(forKey: "username") as! String
        }
        else if commingfrom == "Player2"{
            let obj = DropDownViewController.userLiatarray[indexPath.row] as! NSDictionary
            cell.textLabel!.text = obj.value(forKey: "username") as! String
        } else if commingfrom == "Player3"{
            let obj = DropDownViewController.userLiatarray[indexPath.row] as! NSDictionary
            cell.textLabel!.text = obj.value(forKey: "username") as! String
        }
        else if commingfrom == "Player4"{
            let obj = DropDownViewController.userLiatarray[indexPath.row] as! NSDictionary
            cell.textLabel!.text = obj.value(forKey: "username") as! String
        } else if commingfrom == "Player5"{
            let obj = DropDownViewController.userLiatarray[indexPath.row] as! NSDictionary
            cell.textLabel!.text = obj.value(forKey: "username") as! String
        } else if commingfrom == "Player6"{
            let obj = DropDownViewController.userLiatarray[indexPath.row] as! NSDictionary
            cell.textLabel!.text = obj.value(forKey: "username") as! String
        }    
        else{
        let obj = ProfileCreateTeamVC.PlateformArray[indexPath.row] as! NSDictionary
       cell.textLabel!.text = obj.value(forKey: "PlatformName") as! String
        }
        return cell
    }
    
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
            if commingfrom == "Game"{
            let obj = DropDownViewController.GameArrayList[indexPath.row] as! NSDictionary
            CreateTeamObj?.SelectGameIdtextField.text = obj.value(forKey: "GameTitle") as! String
            self.game_Id = obj.value(forKey: "GameID") as! String
            ProfileCreateTeamVC.game_id = obj.value(forKey: "GameID") as! String
            let noofplayers = obj.value(forKey: "GamePlayers") as! String
            CreateTeamObj?.NoOfPlayer = noofplayers
            let TeamSizetype = obj.value(forKey: "GamePlayersType") as! String//GamePlayersType
            if TeamSizetype == "1"{
                CreateTeamObj?.TeamSizetextField.text = noofplayers
                ProfileCreateTeamVC.isOpenTeamSizePopUp = false
                showTextFields(noofplayers: noofplayers)
            }else if TeamSizetype == "2"{
                ProfileCreateTeamVC.arrTeamSize = ["1",noofplayers]
                ProfileCreateTeamVC.isOpenTeamSizePopUp = true
            }else if TeamSizetype == "3"{
                 ProfileCreateTeamVC.arrTeamSize = ["1","2",noofplayers]
                   ProfileCreateTeamVC.isOpenTeamSizePopUp = true
            }
                
           
         GetIdOfGame()
        }else if commingfrom == "Player1"{
            let obj = DropDownViewController.userLiatarray[indexPath.row] as! NSDictionary
            CreateTeamObj?.SelectRole1.text = obj.value(forKey: "UserGameGameUID") as! String
             CreateTeamObj?.TeamMembers1.text = obj.value(forKey: "username") as! String
         }
        else if commingfrom == "Player2"{
            let obj = DropDownViewController.userLiatarray[indexPath.row] as! NSDictionary
            CreateTeamObj?.SelectRole2.text = obj.value(forKey: "UserGameGameUID") as! String
             CreateTeamObj?.TeamMembers2.text = obj.value(forKey: "username") as! String
        }
        else if commingfrom == "Player3"{
            let obj = DropDownViewController.userLiatarray[indexPath.row] as! NSDictionary
            CreateTeamObj?.SelectRole3.text = obj.value(forKey: "UserGameGameUID") as! String
             CreateTeamObj?.TeamMembers3.text = obj.value(forKey: "username") as! String
        }
        else if commingfrom == "Player4"{
            let obj = DropDownViewController.userLiatarray[indexPath.row] as! NSDictionary
            CreateTeamObj?.SelectRole4.text = obj.value(forKey: "UserGameGameUID") as! String
             CreateTeamObj?.TeamMembers4.text = obj.value(forKey: "username") as! String
        }
        else if commingfrom == "Player5"{
            let obj = DropDownViewController.userLiatarray[indexPath.row] as! NSDictionary
            CreateTeamObj?.SelectRole5.text = obj.value(forKey: "UserGameGameUID") as! String
             CreateTeamObj?.TeamMembers5.text = obj.value(forKey: "username") as! String
        }
        else if commingfrom == "Player6"{
            let obj = DropDownViewController.userLiatarray[indexPath.row] as! NSDictionary
            CreateTeamObj?.SelectRole1.text = obj.value(forKey: "UserGameGameUID") as! String
            CreateTeamObj?.TeamMembers6.text = obj.value(forKey: "username") as! String
        }
        else{
        let obj = ProfileCreateTeamVC.PlateformArray[indexPath.row] as! NSDictionary
        CreateTeamObj?.GamingPlateformTextField.text =  obj.value(forKey: "PlatformName") as! String
        self.PlateformId = obj.value(forKey: "PlatformID") as! String
        CreateTeamObj?.TeamPlateForm_Id =  obj.value(forKey: "PlatformID") as! String
            GetgameList()
        }
         self.dismiss(animated: true, completion: nil)
      }
    
 override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func GetgameList(){
        var DicInput = [String:AnyObject]()
        DicInput = ["platform":self.PlateformId as AnyObject]
        WebHelper.requestPostUrlWithoutprogressHud(strURL: GlobalConstant.get_games, Dictionary: DicInput, Success: {success in
            let  status = String(describing: success.value(forKey: "status")!)
            if status == "1"{
                 DropDownViewController.GameArrayList = []
                DropDownViewController.GameArrayList = success.object(forKey: "Gamelist") as! NSArray
            }
            else if status == "0"{
                
            }
        }, Failure: {failler in
            print("something wrong happened")
        })
        
    }
     func GetIdOfGame(){
        var DIcInput = [String:AnyObject]()
         DIcInput = ["user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject ,"game_id": self.game_Id  as AnyObject]
        WebHelper.requestPostUrl(strURL: GlobalConstant.gameusers, Dictionary: DIcInput, Success: {success in
        let status =  String(describing: success.value(forKey: "status")!)
       if status == "1"{
            let data = success.object(forKey:"UserGameInfo") as! NSArray
            let obj = data[0] as! NSDictionary
            let userGameid = obj.value(forKey: "UserGameGameUID") as! String
         //   self.CreateTeamObj?.GameIDTextField.text = userGameid
            
        }
        else if status == "0"{
            
        }
       }, Failure: {failler in
        print("some error occured")
       })
    }

    func showTextFields(noofplayers:String)
    {
        if noofplayers == "1"{
        }
        else if noofplayers == "2"{
            CreateTeamObj?.TeamMemberView1.isHidden = false
            CreateTeamObj?.SelectRoleView1.isHidden = false
            CreateTeamObj?.CreateButtonTopConstrain.constant = 120-35
        }
        else if noofplayers == "3"{
            CreateTeamObj?.TeamMemberView1.isHidden = false
            CreateTeamObj?.SelectRoleView1.isHidden = false
            CreateTeamObj?.TeamMemberView2.isHidden = false
            CreateTeamObj?.SelectRoleView2.isHidden = false
            CreateTeamObj?.CreateButtonTopConstrain.constant = 170-35
        }
        else if noofplayers == "4"{
            CreateTeamObj?.TeamMemberView1.isHidden = false
            CreateTeamObj?.SelectRoleView1.isHidden = false
            CreateTeamObj?.TeamMemberView2.isHidden = false
            CreateTeamObj?.SelectRoleView2.isHidden = false
            CreateTeamObj?.TeamMemberView3.isHidden = false
            CreateTeamObj?.SelectRoleView3.isHidden = false
            CreateTeamObj?.CreateButtonTopConstrain.constant = 200-35
        }
        else if noofplayers == "5"{
            CreateTeamObj?.TeamMemberView1.isHidden = false
            CreateTeamObj?.SelectRoleView1.isHidden = false
            CreateTeamObj?.TeamMemberView2.isHidden = false
            CreateTeamObj?.SelectRoleView2.isHidden = false
            CreateTeamObj?.TeamMemberView3.isHidden = false
            CreateTeamObj?.SelectRoleView3.isHidden = false
            CreateTeamObj?.TeamMemberView4.isHidden = false
            CreateTeamObj?.SelectRoleView4.isHidden = false
            CreateTeamObj?.CreateButtonTopConstrain.constant = 250-35
            
        }
        else if noofplayers == "6"{
            CreateTeamObj?.TeamMemberView1.isHidden = false
            CreateTeamObj?.SelectRoleView1.isHidden = false
            CreateTeamObj?.TeamMemberView2.isHidden = false
            CreateTeamObj?.SelectRoleView2.isHidden = false
            CreateTeamObj?.TeamMemberView3.isHidden = false
            CreateTeamObj?.SelectRoleView3.isHidden = false
            CreateTeamObj?.TeamMemberView4.isHidden = false
            CreateTeamObj?.SelectRoleView4.isHidden = false
            CreateTeamObj?.TeamMemberView5.isHidden = false
            CreateTeamObj?.SelectRoleView5.isHidden = false
            CreateTeamObj?.CreateButtonTopConstrain.constant = 295-35
        }
    }
    
    
    
}
