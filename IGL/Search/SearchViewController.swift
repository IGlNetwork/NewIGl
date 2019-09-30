//
//  SearchViewController.swift
//  IGL
//
//  Created by baps on 11/11/18.
//  Copyright © 2018 Mac Min. All rights reserved.
//

import UIKit


class ResultCategoryCell: UICollectionViewCell
{
    @IBOutlet weak var categoryButton: UIButton!
    
}

class SearchResultCell: UICollectionViewCell
{
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellTitleLable: UILabel!
    
}



class SearchViewController: UIViewController,SWRevealViewControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource
{
    
    
    @IBOutlet weak var MenuButton:UIBarButtonItem!

    @IBOutlet weak var searchCategory: UICollectionView!
    @IBOutlet weak var serachResultCollecationView: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var SearchView: UIView!
    
    
    /*
     tournament
     trending
     teams
     tv
     people
     news
     mentions
     games
     events
     */
                         //   0         1       2       3       4       5
     //let categoryArr = ["TRENDING","PEOPLE","NEWS","GAMES","TEAMS","IGL TV","EVENTS","TOURNAMENTS","MENTIONS"]
    
    //                      0       1       2        3       4       5
    let categoryArr = ["PEOPLE","NEWS","TRENDING","GAMES","TEAMS","IGL TV","EVENTS","TOURNAMENTS","MENTIONS"]
    
     var trendingArr = [Any]()
     var peopleArr = [Any]()
     var newsArr = [Any]()
     var gamesArr = [Any]()
     var teamsArr = [Any]()
     var tvArr = [Any]()
     var eventsArr = [Any]()
     var tournamentArr = [Any]()
     var mentionsArr = [Any]()
     var categorySelectedIndex = 0
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //searchTextField.layer.cornerRadius = 16
        SearchView.layer.cornerRadius = 21
        SearchView.layer.borderWidth = 1.0
        SearchView.layer.borderColor = #colorLiteral(red: 0.2039215686, green: 0.5254901961, blue: 0.8, alpha: 1)
         self.searchCategory.isHidden = true
         self.searchTextField.becomeFirstResponder()
        //Actions for the SideMenu.
        MenuButton.target = revealViewController()
        MenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        //set the delegate to teh SWRevealviewcontroller
        revealViewController().delegate = self
        self.revealViewController().rearViewRevealWidth = 280
        if self.revealViewController() != nil {
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
        // Do any additional setup after loading the view.
        // NavViewBar.titleTextAttributes =  attributes
        if UIDevice().userInterfaceIdiom == .phone {
            print("iPhone Height:::::::::::::",UIScreen.main.nativeBounds.height)
            
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("iPhone 5 or 5S or 5C")
                let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                let width = UIScreen.main.bounds.width
                let height = UIScreen.main.bounds.height
                //let newHeight = height - XPhoneHeight
                layout.itemSize = CGSize(width: width/4+5, height:width/4+5)
                layout.minimumInteritemSpacing = 1
                // layout.minimumLineSpacing =
                serachResultCollecationView!.collectionViewLayout = layout
                
            case 1334:
                print("iPhone 6/6S/7/8")
                let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                let width = UIScreen.main.bounds.width
                let height = UIScreen.main.bounds.height
                //let newHeight = height - XPhoneHeight
                layout.itemSize = CGSize(width: width/4+10, height:  width/4+10)
                layout.minimumInteritemSpacing = 1
                layout.minimumLineSpacing = 15
                serachResultCollecationView!.collectionViewLayout = layout
            case 2208:
                print("iPhone 6+/6S+/7+/8+")
                let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                let width = UIScreen.main.bounds.width
                let height = UIScreen.main.bounds.height
                //let newHeight = height - XPhoneHeight
                layout.itemSize = CGSize(width: width/4+13, height: width/4+13)
                layout.minimumInteritemSpacing = 1
                layout.minimumLineSpacing = 12
                serachResultCollecationView!.collectionViewLayout = layout
            case 2436:
                print("iPhone X/XS")
                let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                let width = UIScreen.main.bounds.width
                let height = UIScreen.main.bounds.height
                //let newHeight = height - XPhoneHeight
                layout.itemSize = CGSize(width: width/4+12, height: width/4+12)
                layout.minimumInteritemSpacing = 0
                layout.minimumLineSpacing = 8
                serachResultCollecationView!.collectionViewLayout = layout
            case 1792.0:
                print("iPhone XR")
                let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                let width = UIScreen.main.bounds.width
                let height = UIScreen.main.bounds.height
                //let newHeight = height - XPhoneHeight
                layout.itemSize = CGSize(width: width/4+12, height: width/4+12)
                layout.minimumInteritemSpacing = 0
                layout.minimumLineSpacing = 8
                serachResultCollecationView!.collectionViewLayout = layout
            case 2688.0:
                print("iPhone XS-Max")
                let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                let width = UIScreen.main.bounds.width
                let height = UIScreen.main.bounds.height
                //let newHeight = height - XPhoneHeight
                layout.itemSize = CGSize(width: width/4+12, height: width/4+12)
                layout.minimumInteritemSpacing = 0
                layout.minimumLineSpacing = 8
                serachResultCollecationView!.collectionViewLayout = layout
            case 1920.0:
                print("iPhone 7 Plus")
                let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                let width = UIScreen.main.bounds.width
                let height = UIScreen.main.bounds.height
                //let newHeight = height - XPhoneHeight
                layout.itemSize = CGSize(width: width/4+12, height: width/4+12)
                layout.minimumInteritemSpacing = 0
                layout.minimumLineSpacing = 8
                serachResultCollecationView!.collectionViewLayout = layout
            default:
                print("unknown")
            }
        }
       
    }
    

    @IBAction func NotiAction(_ sender:Any)
    {
        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
        let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(SwreavelObj, animated: true)
    }


    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        if collectionView == searchCategory  //
        {
             return categoryArr.count
        }
        else
        {
            //                          0      1        2        3
            //   let categoryArr = ["PEOPLE","NEWS","TRENDING","GAMES","TEAMS","IGL TV","EVENTS","TOURNAMENTS","MENTIONS"]
            
            if self.categorySelectedIndex == 0
            {
                 return self.peopleArr.count //
            }
            else  if self.categorySelectedIndex == 1
            {
                 return self.newsArr.count //
            }
            else  if self.categorySelectedIndex == 2
            {
                 return trendingArr.count
            }
            else  if self.categorySelectedIndex == 3
            {
                 return gamesArr.count
            }
            else  if self.categorySelectedIndex == 4
            {
                 return teamsArr.count
            }
            else  if self.categorySelectedIndex == 5
            {
                return tvArr.count
            }
            else  if self.categorySelectedIndex == 6
            {
                 return eventsArr.count
            }
            else  if self.categorySelectedIndex == 7
            {
                return tournamentArr.count
            }
            else
            {
                return mentionsArr.count
            }
            
        }
        
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == searchCategory
        {
            let cell = searchCategory.dequeueReusableCell(withReuseIdentifier: "ResultCategoryCell", for: indexPath) as! ResultCategoryCell
              cell.categoryButton.setTitle("\(categoryArr[indexPath.row])", for: .normal)
              if indexPath.row == self.categorySelectedIndex
              {
                cell.categoryButton.backgroundColor = #colorLiteral(red: 0.109867312, green: 0.332564801, blue: 0.5187458396, alpha: 1)
              }
              else{
                cell.categoryButton.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.5254901961, blue: 0.8, alpha: 1)
              }
            
            
             cell.categoryButton.tag = indexPath.row
            return cell
        }
        else
        {
            //                          0      1        2        3
            //   let categoryArr = ["PEOPLE","NEWS","TRENDING","GAMES","TEAMS","IGL TV","EVENTS","TOURNAMENTS","MENTIONS"]
            let cell = serachResultCollecationView.dequeueReusableCell(withReuseIdentifier: "SearchResultCell", for: indexPath) as! SearchResultCell
            
            if self.categorySelectedIndex == 0
            {
                // return self.peopleArr.count
                let dict = self.peopleArr[indexPath.row] as! NSDictionary
                cell.cellTitleLable.text! = Global.getStringValue(dict.value(forKey: "username") as AnyObject)
                let url = URL(string:Global.getStringValue(dict.value(forKey: "placeholderimg") as AnyObject))
                cell.cellImageView?.kf.setImage(with: url,
                                                placeholder:UIImage(named: "placeholderimg"),
                                                options: [.transition(.fade(1))],
                                                progressBlock: nil,
                                                completionHandler: nil)
            }
            else  if self.categorySelectedIndex == 1
            {
                // return newsArr.count
                let dict = self.newsArr[indexPath.row] as! NSDictionary
                cell.cellTitleLable.text! = Global.getStringValue(dict.value(forKey: "NewsTitle") as AnyObject)
                let url = URL(string:Global.getStringValue(dict.value(forKey: "NewsImage") as AnyObject))
                cell.cellImageView?.kf.setImage(with: url,
                                                placeholder:UIImage(named: "placeholderimg"),
                                                options: [.transition(.fade(1))],
                                                progressBlock: nil,
                                                completionHandler: nil)
            }
            else  if self.categorySelectedIndex == 2
            {
                //return self.trendingArr.count
                let dict = self.trendingArr[indexPath.row] as! NSDictionary
                cell.cellTitleLable.text! = Global.getStringValue(dict.value(forKey: "title") as AnyObject)
                let url = URL(string:Global.getStringValue(dict.value(forKey: "description") as AnyObject))
                cell.cellImageView?.kf.setImage(with: url,
                                                placeholder:UIImage(named: "placeholderimg"),
                                                options: [.transition(.fade(1))],
                                                progressBlock: nil,
                                                completionHandler: nil)
            }
            else  if self.categorySelectedIndex == 3
            {
               // return gamesArr.count\
                let dict = self.gamesArr[indexPath.row] as! NSDictionary
                cell.cellTitleLable.text! = Global.getStringValue(dict.value(forKey: "GameTitle") as AnyObject)
                let url = URL(string:Global.getStringValue(dict.value(forKey: "GameImagePath") as AnyObject))
                cell.cellImageView?.kf.setImage(with: url,
                                                placeholder:UIImage(named: "placeholderimg"),
                                                options: [.transition(.fade(1))],
                                                progressBlock: nil,
                                                completionHandler: nil)
            }
            else  if self.categorySelectedIndex == 4
            {
               // return teamsArr.count
                let dict = self.teamsArr[indexPath.row] as! NSDictionary
                cell.cellTitleLable.text! = Global.getStringValue(dict.value(forKey: "TeamName") as AnyObject)
                let url = URL(string:Global.getStringValue(dict.value(forKey: "TeamImage") as AnyObject))
                cell.cellImageView?.kf.setImage(with: url,
                                                placeholder:UIImage(named: "placeholderimg"),
                                                options: [.transition(.fade(1))],
                                                progressBlock: nil,
                                                completionHandler: nil)
            }
            else  if self.categorySelectedIndex == 5
            {
               // return tvArr.count
                let dict = self.tvArr[indexPath.row] as! NSDictionary
                cell.cellTitleLable.text! = Global.getStringValue(dict.value(forKey: "TVTitle") as AnyObject)
                let url = URL(string:Global.getStringValue(dict.value(forKey: "TeamImage") as AnyObject))
                cell.cellImageView?.kf.setImage(with: url,
                                                placeholder:UIImage(named: "placeholderimg"),
                                                options: [.transition(.fade(1))],
                                                progressBlock: nil,
                                                completionHandler: nil)
            }
            else  if self.categorySelectedIndex == 6
            {
                //return eventsArr.count
                let dict = self.eventsArr[indexPath.row] as! NSDictionary
                cell.cellTitleLable.text! = Global.getStringValue(dict.value(forKey: "EventTitle") as AnyObject)
                let url = URL(string:Global.getStringValue(dict.value(forKey: "EventImage") as AnyObject))
                cell.cellImageView?.kf.setImage(with: url,
                                                placeholder:UIImage(named: "placeholderimg"),
                                                options: [.transition(.fade(1))],
                                                progressBlock: nil,
                                                completionHandler: nil)
            }
            else  if self.categorySelectedIndex == 7
            {
               // return tournamentArr.count
                let dict = self.tournamentArr[indexPath.row] as! NSDictionary
                cell.cellTitleLable.text! = Global.getStringValue(dict.value(forKey: "TournamentTitle") as AnyObject)
                let url = URL(string:Global.getStringValue(dict.value(forKey: "TournamentCoverImage") as AnyObject))
                cell.cellImageView?.kf.setImage(with: url,
                                                placeholder:UIImage(named: "placeholderimg"),
                                                options: [.transition(.fade(1))],
                                                progressBlock: nil,
                                                completionHandler: nil)
            }
            else
            {
                //return mentionsArr.count
                let dict = self.mentionsArr[indexPath.row] as! NSDictionary
                cell.cellTitleLable.text! = Global.getStringValue(dict.value(forKey: "title") as AnyObject)
                let url = URL(string:Global.getStringValue(dict.value(forKey: "description") as AnyObject))
                cell.cellImageView?.kf.setImage(with: url,
                                                placeholder:UIImage(named: "placeholderimg"),
                                                options: [.transition(.fade(1))],
                                                progressBlock: nil,
                                                completionHandler: nil)
            }
            
            
            cell.layer.shadowOpacity = 0.3
            cell.layer.shadowRadius = 3
            cell.layer.shadowOffset = CGSize(width: 1, height: 1)
            return cell
        }
    }
    
   
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool
    {
        print("should..............")
        if collectionView == searchCategory
        {
            print("index path....searchCategory..........")
            self.categorySelectedIndex = indexPath.row
            self.searchCategory.reloadData()
            self.serachResultCollecationView.reloadData()
        }
        else{
            //                          0      1        2        3
            //   let categoryArr = ["PEOPLE","NEWS","TRENDING","GAMES","TEAMS","IGL TV","EVENTS","TOURNAMENTS","MENTIONS"]
             print("index path..............")
            if self.categorySelectedIndex == 0
            {
                //return self.peopleArr.count
                let dict = self.peopleArr[indexPath.row] as! NSDictionary
                let vc = storyboard?.instantiateViewController(withIdentifier: "PersonalProfileViewController") as! PersonalProfileViewController
                vc.otherUserId =  Global.getStringValue(dict.value(forKey: "id") as AnyObject)
                vc.isLoggedInUser = false
                print("game_id:", vc.otherUserId)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else  if self.categorySelectedIndex == 1
            {
                // return newsArr.count
                let dict = self.newsArr[indexPath.row] as! NSDictionary
                let vc = storyboard?.instantiateViewController(withIdentifier: "IGLNEWSViewController") as! IGLNEWSViewController
                vc.NewsId =  Global.getStringValue(dict.value(forKey: "NewsID") as AnyObject)
                print("game_id:", vc.NewsId)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else  if self.categorySelectedIndex == 2
            {
                // return self.trendingArr.count
                let dict = self.trendingArr[indexPath.row] as! NSDictionary
                let type = Global.getStringValue(dict.value(forKey: "type") as AnyObject)
                // type: 1- game ,2-Team, 3-video, 4-News, 5-people, 6-event, 7-tournament
                print("Tpye:::::::",type)
                if type == "1"
                {
                    let vc : GameDetailsVC = storyboard?.instantiateViewController(withIdentifier: "GameDetailsVC")as! GameDetailsVC
                    vc.game_id =  Global.getStringValue(dict.value(forKey: "id") as AnyObject)
                    print("game_id:", vc.game_id)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                else if type == "2"
                {
                    // Jump to Team details Screen .
                }
                else if type == "3"
                {
                    let vc = storyboard?.instantiateViewController(withIdentifier: "IGLTVViewController") as! IGLTVViewController
                    vc.game_id =  Global.getStringValue(dict.value(forKey: "id") as AnyObject)
                    print("game_id:", vc.game_id)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                else if type == "4"
                {
                    let vc = storyboard?.instantiateViewController(withIdentifier: "IGLNEWSViewController") as! IGLNEWSViewController
                    vc.NewsId =  Global.getStringValue(dict.value(forKey: "id") as AnyObject)
                    print("game_id:", vc.NewsId)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                else if type == "5"
                {
                    let vc = storyboard?.instantiateViewController(withIdentifier: "PersonalProfileViewController") as! PersonalProfileViewController
                    vc.otherUserId =  Global.getStringValue(dict.value(forKey: "id") as AnyObject)
                    vc.isLoggedInUser = false
                    print("game_id:", vc.otherUserId)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                else if type == "6"
                {
                    let vc = storyboard?.instantiateViewController(withIdentifier: "EventDetailsVC") as! EventDetailsVC
                    vc.event_id =  Global.getStringValue(dict.value(forKey: "id") as AnyObject)
                    print("game_id:", vc.event_id)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                else if type == "7"
                {
                    let vc = storyboard?.instantiateViewController(withIdentifier: "TournamentDetailsVC") as! TournamentDetailsVC
                    vc.tournament_id =  Global.getStringValue(dict.value(forKey: "id") as AnyObject)
                    print("game_id:", vc.tournament_id)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
            }
            else  if self.categorySelectedIndex == 3
            {
               // return gamesArr.count
                 let dict = self.gamesArr[indexPath.row] as! NSDictionary
                let vc : GameDetailsVC = storyboard?.instantiateViewController(withIdentifier: "GameDetailsVC")as! GameDetailsVC
                vc.game_id =  Global.getStringValue(dict.value(forKey: "GameID") as AnyObject)
                print("game_id:", vc.game_id)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else  if self.categorySelectedIndex == 4
            {
              //  return teamsArr.count
            }
            else  if self.categorySelectedIndex == 5
            {
               // return tvArr.count
                  let dict = self.tvArr[indexPath.row] as! NSDictionary
                let vc = storyboard?.instantiateViewController(withIdentifier: "IGLTVViewController") as! IGLTVViewController
                vc.game_id =  Global.getStringValue(dict.value(forKey: "TVID") as AnyObject)
                print("game_id:", vc.game_id)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else  if self.categorySelectedIndex == 6
            {
               // return eventsArr.count
                 let dict = self.eventsArr[indexPath.row] as! NSDictionary
                let vc = storyboard?.instantiateViewController(withIdentifier: "EventDetailsVC") as! EventDetailsVC
                vc.event_id =  Global.getStringValue(dict.value(forKey: "EventID") as AnyObject)
                print("game_id:", vc.event_id)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else  if self.categorySelectedIndex == 7
            {
               // return tournamentArr.count
                let dict = self.tournamentArr[indexPath.row] as! NSDictionary
                let vc = storyboard?.instantiateViewController(withIdentifier: "TournamentDetailsVC") as! TournamentDetailsVC
                vc.tournament_id =  Global.getStringValue(dict.value(forKey: "TournamentID") as AnyObject)
                print("game_id:", vc.tournament_id)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else
            {
              //  return mentionsArr.count
            }
            //   let categoryArr = ["TRENDING","PEOPLE","NEWS","GAMES","TEAMS","TV","EVENTS","TOURNAMENTS","ME
            // type: 1- game ,2-Team, 3-video, 4-News, 5-people, 6-event, 7-tournament
        }
        
        
        
        return true
    }
    
    @IBAction func cellCategoryButtonAction(_ sender: AnyObject) {
        self.categorySelectedIndex = sender.tag!
        self.searchCategory.reloadData()
        self.serachResultCollecationView.reloadData()
    }
    
    @IBAction func searchAction(_ sender: Any) {
         self.searchTextField.resignFirstResponder()
         self.searchCategory.isHidden = false
        
        globalSearch()
    }
    
    
    
    
}




extension SearchViewController{
    func globalSearch() {
        var DicInput = [String:AnyObject]()
        DicInput = ["searchtext":searchTextField.text! as AnyObject]
        WebHelper.requestPostUrl(strURL: GlobalConstant.globalsearch, Dictionary: DicInput, Success: {success in
            let status = Global.getStringValue(success.object(forKey: "status") as AnyObject)
            if status == "1"{
                 self.clearData()
                 self.eventsArr = success.value(forKey: "events") as! [Any]
                 self.gamesArr = success.value(forKey: "games") as! [Any]
                 self.mentionsArr = success.value(forKey: "mentions") as! [Any]
                 self.newsArr = success.value(forKey: "news") as! [Any]
                 self.peopleArr = success.value(forKey: "people") as! [Any]
                 self.teamsArr = success.value(forKey: "teams") as! [Any]
                 self.tournamentArr = success.value(forKey: "tournament") as! [Any]
                 self.trendingArr = success.value(forKey: "trending") as! [Any]
                 self.eventsArr = success.value(forKey: "tv") as! [Any]
                 self.categorySelectedIndex = 0
                 self.searchCategory.reloadData()
                 self.searchCategory.scrollToItem(at: IndexPath(item: 0, section: 0), at: .right, animated: true)
                 self.serachResultCollecationView.reloadData()
            }
            else if status == "0"{
                 self.clearData()
                 self.serachResultCollecationView.reloadData()
            }
        }, Failure: {failler in
            Global.showAlertMessageWithOkButtonAndTitle("", andMessage:failler.localizedDescription)
        })
    }
    
    func clearData()
    {
        self.eventsArr.removeAll()
        self.gamesArr.removeAll()
        self.mentionsArr.removeAll()
        self.newsArr.removeAll()
        self.peopleArr.removeAll()
        self.teamsArr.removeAll()
        self.tournamentArr.removeAll()
        self.trendingArr.removeAll()
        self.eventsArr.removeAll()
    }
    
    
}



/*
 
 mentions =     (
 {
 description = "1552460952golf_clash_game_image.jpg";
 id = 1;
 title = "\"Golf Clash\"";
 type = 1;
 },
 
 */


/*
 
 trending =     (
 {
 description = "1552460952golf_clash_game_image.jpg";
 id = 1;
 title = "\"Golf Clash\"";
 type = 1;
 },

 tv =     (
 {
 TVID = 5;
 TVTitle = "DOTA 2 GAMEPLAY";
 VideoEmbedLink = "8u6K6KsLW-g";
 },
 
 mentions =     (
 {
 description = "http://iglnetwork.com/beta/assets/uploads/games/1552460952golf_clash_game_image.jpg";
 id = 1;
 title = "\"Golf Clash\"";
 type = 1;
 },
 
 
 
 user_id:::::::::::::::::: 9493 ::game_id::::::: 22
 Dictionary: Optional(["game_id": 22, "user_id": 9493])
 Dictionary: Optional(["user_id": 9493, "game_id": 22])
 self.tournamentArray.count: 0
 {
 GameDetails =     {
 ChallengeCount = 0;
 GameCreatedAt = "<null>";
 GameDescription = "<null>";
 GameID = "<null>";
 GameImagePath = "http://iglnetwork.com/beta/assets/uploads/games/";
 GamePrizePool = "<null>";
 GameTitle = "<null>";
 Glikecount = 0;
 TeamCount = 0;
 TournamentCount = 0;
 isadded = "<null>";
 islike = "<null>";
 };
 status = 1;
 }
 
 
 */



