//
//  SideMenuViewController.swift
//  IGL
//
//  Created by baps on 30/09/18.
//  Copyright © 2018 Mac Min. All rights reserved.
//

import UIKit
import SafariServices
class SideMenuCell: UITableViewCell{
    @IBOutlet weak var TitleLabel:UILabel!
    @IBOutlet weak var Imageview:UIImageView!
}
class SideMenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var SideMenuTableview:UITableView!
    @IBOutlet weak var UserProfileImageView:UIImageView!
    @IBOutlet weak var UserNameLabel:UILabel!
    @IBOutlet weak var UserEmailLabel:UILabel!
    var SideMenuArray = ["HOME","GAMES","BATTLE ROYALE","LEADERBOARDS","STORE","EVENTS","IGL NEWS","IGL TV","HOW TO PLAY","SETTINGS","ABOUT","CONTACT US ","LOGOUT"]
    
    
    @IBOutlet weak var IGLCoinsLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        SideMenuTableview.sectionHeaderHeight = 0.0;
        self.SideMenuTableview.separatorStyle = .none
        self.navigationController?.isNavigationBarHidden = true
        Global.roundRadius(UserProfileImageView)
        UserProfileImageView.layer.borderWidth = 3
        UserProfileImageView.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
         self.Get_ProfileHeaderdetails()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SideMenuArray.count
    }
    var count = 0
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuCell", for: indexPath) as! SideMenuCell
        cell.TitleLabel.text = SideMenuArray[indexPath.row]
        count = count + 1
        if count == SideMenuArray.count
        {
        cell.Imageview.isHidden = true
        }
        cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
        if indexPath.row == 0
        {
            //let vcobj = storyboardobj.instantiateViewController(withIdentifier: "LeaderBoardViewController") as! LeaderBoardViewController
          // self.SWRevealViewController.pushFrontViewController(vcobj)
           // tabBarController?.selectedIndex = 0
           //
            let tabBarController = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
          //  tabBarController.selectedIndex = 4
            revealViewController().pushFrontViewController(tabBarController, animated: true)
            
        }
       else if indexPath.row == 1//BattleRoyale
        {
      
         performSegue(withIdentifier: "gamelist", sender: nil)
            
        }
       else if indexPath.row == 2//gamelist
        {
           //BattleRoyale
            performSegue(withIdentifier: "BattleRoyale", sender: nil)
           
          
        }
       else if indexPath.row == 3//leaderboard
        {
             performSegue(withIdentifier: "leaderboard", sender: nil)
           
        
        }
        
        else if indexPath.row == 4//IGL_STORE
        {
            // performSegue(withIdentifier: "IGL_STORE", sender: nil)
           
            //https://iglnetwork.com/beta/stores/index/9489
            let user_id = UserDefaults.standard.value(forKey: "user_id") as! String
            let url = "https://iglnetwork.com/beta/stores/index/\(user_id)"
            print("url is coming",url)
            let svc = SFSafariViewController(url: URL(string: url)!, entersReaderIfAvailable: true)
            svc.preferredBarTintColor =   #colorLiteral(red: 0.3333333333, green: 0.6509803922, blue: 0.9215686275, alpha: 1)
            present(svc, animated: true, completion: nil)
            if #available(iOS 11.0, *) {
                svc.dismissButtonStyle = .close
            } else {
                // Fallback on earlier versions
            }
          
            
        }
        else if indexPath.row == 5//event
        {
             performSegue(withIdentifier: "event", sender: nil)
           
           
        }
        else if indexPath.row == 6//IGLNews
        {
              performSegue(withIdentifier: "IGLNews", sender: nil)
           
        }
        else if indexPath.row == 7//IGL_TV
        {
             performSegue(withIdentifier: "IGL_TV", sender: nil)
            
        }
        else if indexPath.row == 8//howtoplay
        {
             performSegue(withIdentifier: "howtoplay", sender: nil)

        }
        else if indexPath.row == 9//SettingIGL
        {
              performSegue(withIdentifier: "SettingIGL", sender: nil)
           
            
        
//            let sb = UIStoryboard(name: "Main", bundle: nil)
//            let vc = sb.instantiateViewController(withIdentifier: "ContactIGLViewController") as! ContactIGLViewController
//            self.revealViewController().pushFrontViewController(vc, animated: true)
            
        }
        else if indexPath.row == 10//AboutIGL
        {
            
             performSegue(withIdentifier: "AboutIGL", sender: nil)
            
            
        }else if indexPath.row == 11{//ContactIGL
           performSegue(withIdentifier: "ContactIGL", sender: nil)
            
        }else if indexPath.row == 12{
            let Alert = UIAlertController(title: "Logout?", message: "Are you sure!", preferredStyle: UIAlertController.Style.alert)
            let ok = UIAlertAction(title: "Yes", style: UIAlertAction.Style.destructive, handler: {(action:UIAlertAction) in
                UserDefaults.standard.set("0", forKey: "isLoggedIn")
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                self.present(vc, animated: true, completion: nil)
                
            })
            let no = UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil)
            Alert.addAction(ok)
            Alert.addAction(no)
            self.present(Alert, animated: true, completion: nil)
        }
        
       
    }

    
    @objc func alertControllerBackgroundTapped()
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    func Get_ProfileHeaderdetails(){
       
       let url2 = URL(string: UserDefaults.standard.value(forKey:"UserProfileImage") as! String as! String)
            self.UserProfileImageView?.kf.setImage(with: url2,
                                           placeholder:UIImage(named: "vikings-war-of-clans_min"),
                                           options: [.transition(.fade(1))],
                                           progressBlock: nil,
                                           completionHandler: nil)
            self.UserNameLabel.text = UserDefaults.standard.value(forKey: "username") as! String
            self.UserEmailLabel.text = UserDefaults.standard.value(forKey: "email") as! String
            self.IGLCoinsLabel.text = UserDefaults.standard.value(forKey: "UserCredit") as! String + "  IGL COINS"
        
            }
    
}
