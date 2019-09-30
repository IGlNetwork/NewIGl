//
//  DropDownViewController.swift
//  RentalHomeProject
//
//  Created by CodeBetter on 16/03/18.
//  Copyright © 2018 Codebetter. All rights reserved.
//

import UIKit

class DropDownVCDayMonth: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    @IBOutlet weak var TableView: UITableView!
    
    var yearsTillNow : [String] {
        var years = [String]()
        for i in (1970..<2020).reversed() {
            years.append("\(i)")
        }
        return years
    }
    var commingFrom = ""
     var Month = ["January","February","March","April","May","June","July","August","September","October","November","December"]
     var MonthInt = ["01","02","03","04","05","06","07","08","09","10","11","12"]
   static var CityArrray:NSArray = []
    var VCObj:LeaderBoardViewController?
    static var GameList :NSArray = []
    var evetobj:EventListingVC?
    static var EventArray:NSArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        TableView.separatorStyle = .none
        TableView.delegate = self
        TableView.dataSource = self
     //   TableView.rowHeight = UITableView.UITableViewAutomaticDimension
       // TableView.estimatedRowHeight = UITableView.UITableViewAutomaticDimension
        if commingFrom == "Game"{
          if DropDownVCDayMonth.GameList.count == 0{
         get_games()
            }
        }
        if DropDownVCDayMonth.CityArrray.count == 0{
            GetListOfCity()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if commingFrom == "Month"{
            return Month.count
        }
        else if commingFrom == "Year"{
            return yearsTillNow.count
        }else if commingFrom == "City"{
            return DropDownVCDayMonth.CityArrray.count
        }
        else if commingFrom == "Category"{
            return DropDownVCDayMonth.EventArray.count
        }
        else {
            return DropDownVCDayMonth.GameList.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell()
        cell.textLabel?.font = cell.textLabel?.font.withSize(17)
        cell.textLabel?.textAlignment = .center
        if commingFrom == "Month"{
          cell.textLabel!.text =   Month[indexPath.row]
            
        }
        else if commingFrom == "Year"{
           cell.textLabel!.text =   yearsTillNow[indexPath.row]
        }
        else if commingFrom == "Game"{
             cell.textLabel?.textAlignment = .left
             cell.textLabel?.font = cell.textLabel?.font.withSize(13)
            let obj =  DropDownVCDayMonth.GameList[indexPath.row] as! NSDictionary
           cell.textLabel!.text =  obj.value(forKey: "GameTitle") as! String
        }
        else if commingFrom == "City"{
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.font = cell.textLabel?.font.withSize(13)
            let obj =  DropDownVCDayMonth.CityArrray[indexPath.row] as! NSDictionary
            cell.textLabel!.text =  obj.value(forKey: "City") as! String
        }
        else if commingFrom == "Category"{
            let obj = DropDownVCDayMonth.EventArray[indexPath.row] as! NSDictionary
            cell.textLabel?.textAlignment = .left
            cell.textLabel?.font = cell.textLabel?.font.withSize(14)
            cell.textLabel!.text =   obj.value(forKey: "category") as! String
        }
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if commingFrom == "Month"{
            VCObj?.MonthtextField.font = VCObj?.MonthtextField.font!.withSize(11)
            VCObj?.MonthtextField.text! =  Month[indexPath.row]
            VCObj?.month = MonthInt[indexPath.row]
            VCObj?.MonthtextField.textAlignment = .center
        }
        else if commingFrom == "Year"{
       VCObj?.YearTextField.font = VCObj?.YearTextField.font!.withSize(11)
       VCObj?.YearTextField.text! =   yearsTillNow[indexPath.row]
       VCObj?.YearTextField.textAlignment = .center
        }
        else if commingFrom == "Game"{//
            let obj = DropDownVCDayMonth.GameList[indexPath.row] as! NSDictionary
            VCObj?.SelectGameTextField.font = VCObj?.YearTextField.font!.withSize(10)
            VCObj?.SelectGameTextField.text! =    obj.value(forKey: "GameTitle") as! String
            VCObj?.game_id = obj.value(forKey: "GameID") as! String//GameID
            VCObj?.SelectGameTextField.textAlignment = .center
        }
        else if commingFrom == "City"{
            let obj = DropDownVCDayMonth.CityArrray[indexPath.row] as! NSDictionary
            VCObj?.SelectCitytextField.text! = obj.value(forKey: "City") as! String
            VCObj?.SelectCitytextField.textAlignment = .center
            
        }
        else if commingFrom == "Category"{
            let obj = DropDownVCDayMonth.EventArray[indexPath.row] as! NSDictionary
            evetobj?.selectevetlabel.text! = obj.value(forKey: "category") as! String
            evetobj?.selectevetlabel.textAlignment = .left
        }
        
        self.dismiss(animated: true, completion: nil)
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
                 self.TableView.reloadData()
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
    
    
    
}
