//
//  EventListingVC.swift
//  IGL
//
//  Created by Mac Min on 05/10/18.
//  Copyright © 2018 Mac Min. All rights reserved.
//

import UIKit

class EventListingCell: UICollectionViewCell
{
    @IBOutlet weak var KnowMoreView: UIView!
    @IBOutlet weak var KnowMoreButton: UIButton!
    @IBOutlet weak var CellTitle: UILabel!
    @IBOutlet weak var CellDate: UILabel!
    @IBOutlet weak var CellImage: UIImageView!
    
}

class CategoriesCell: UITableViewCell {
    @IBOutlet weak var CategoriesLAbel:UILabel!
}

class EventListingVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UIPopoverPresentationControllerDelegate,UITableViewDelegate,UITableViewDataSource
{
    //@IBOutlet weak var BottomlayoutofcollectionView: NSLayoutConstraint!
    
    @IBOutlet weak var bottomLayout: NSLayoutConstraint!
    @IBOutlet weak var EvenListingCollectionView: UICollectionView!
    @IBOutlet weak var SelectEventCatagory: UIView!
    @IBOutlet weak var BackgroundView: UIView!
    
    @IBOutlet weak var CategoriesView: UIView!
    @IBOutlet weak var CategoriesTableView: UITableView!
    @IBOutlet weak var selectevetlabel: UILabel!
    @IBOutlet weak var dropdownbutton: UIButton!
    var pno = "0"
    var category = ""
    var Eventlist = [Any]()
    var EventArray:NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bottomconstant()
        get_tournamentlist()
        getcategorylist()
        SelectEventCatagory.layer.cornerRadius = 18
        CategoriesTableView.separatorStyle = .none
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        //let newHeight = height - XPhoneHeight
        layout.itemSize = CGSize(width: width/2-22, height: 245)
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 15
        EvenListingCollectionView!.collectionViewLayout = layout
        CategoriesView.isHidden = true
        BackgroundView.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    func bottomconstant() {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("iPhone 5 or 5S or 5C")
                
                
            case 1334:
                print("iPhone 6/6S/7/8")
                // bottomLayout.constant = -60
                
            case 2208:
                print("iPhone 6+/6S+/7+/8+")
            // bottomLayout.constant = -75
            case 2436:
                print("iPhone X")
                // bottomLayout.constant = -80
                
            default:
                print("unknown")
                // bottomLayout.constant = -150
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  DropDownVCDayMonth.EventArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CategoriesTableView.dequeueReusableCell(withIdentifier: "CategoriesCell", for: indexPath) as! CategoriesCell
        cell.CategoriesLAbel.text = (DropDownVCDayMonth.EventArray[indexPath.row] as! NSDictionary).value(forKey: "category") as! String
        cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dicobj = DropDownVCDayMonth.EventArray[indexPath.row] as! NSDictionary
        self.selectevetlabel.text = dicobj.value(forKey: "category") as! String
        self.category = dicobj.value(forKey: "category") as! String
        self.get_tournamentlist()
        BackgroundView.isHidden = true
        CategoriesView.isHidden = true
    }
    
    
    
    @IBAction func CloseCategoriesView(_ sender: Any) {
        BackgroundView.isHidden  = true
        CategoriesView.isHidden = true
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let touch = touches.first!
        if touch.view == BackgroundView{
            BackgroundView.isHidden = true
            CategoriesView.isHidden =  true
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle
    {
        return UIModalPresentationStyle.none
    }
    
    @IBAction func opencategorylist(_ sender: Any) {
        BackgroundView.isHidden = false
        CategoriesView.isHidden = false
//        let obj = self.storyboard!.instantiateViewController(withIdentifier: "DropDownVCDayMonth") as! DropDownVCDayMonth
//        obj.commingFrom = "Category"
//        obj.evetobj =  self
//        obj.modalPresentationStyle = UIModalPresentationStyle.popover
//        obj.preferredContentSize = CGSize(width:200, height: 200)
//        obj.popoverPresentationController!.delegate = self
//        self.present(obj, animated: true, completion: nil)
//        let popover = obj.popoverPresentationController
//        popover!.sourceView = dropdownbutton
//        popover!.sourceRect =  dropdownbutton.bounds
//        popover!.permittedArrowDirections = UIPopoverArrowDirection.up
//        view.endEditing(true)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return Eventlist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = EvenListingCollectionView.dequeueReusableCell(withReuseIdentifier: "EventListingCell", for: indexPath) as! EventListingCell
        cell.KnowMoreView.layer.cornerRadius = 15
        cell.KnowMoreButton.tag = indexPath.row
        
        cell.KnowMoreButton.addTarget(self,
                                      action:#selector(self.GotoDetailsView),
                                      for: .touchUpInside)
        let dict = Eventlist[indexPath.row] as! NSDictionary
        cell.CellTitle.text = dict.value(forKey: "EventTitle") as! String
        cell.CellDate.text = "\(dict.value(forKey: "SDate") as! String) | \(dict.value(forKey: "EventCategory") as! String)"
        
        let url = URL(string:dict.value(forKey: "EventImage") as! String)
        cell.CellImage?.kf.setImage(with: url,
                                    placeholder:UIImage(named: "placeholder"),
                                    options: [.transition(.fade(1))],
                                    progressBlock: nil,
                                    completionHandler: nil)
        return cell
    }
    
    @objc func GotoDetailsView(sender : UIButton){
        print(sender.tag)
        let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
        let vc : EventDetailsVC = mainStoryboard.instantiateViewController(withIdentifier: "EventDetailsVC") as! EventDetailsVC
        let dict = Eventlist[sender.tag] as! NSDictionary
        vc.event_id = dict.value(forKey: "EventID") as! String
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func BackAction(_sender:Any)
    {
        let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
        let vc : SWRevealViewController = mainStoryboard.instantiateViewController(withIdentifier: "SW-Reaveal")as! SWRevealViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool
    {
        print("Task indexPath.row:",indexPath.row)
        return true
    }
    
    
    @IBAction func KnowMoreAction(_ sender: Any)
  {
//                let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
//                let vc : EventDetailsVC = mainStoryboard.instantiateViewController(withIdentifier: "EventDetailsVC") as! EventDetailsVC
//                self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func NotiAction(_ sender:Any)
    {
        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
        let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(SwreavelObj, animated: true)
    }
    
    func get_tournamentlist()
    {
        var dictPost:[String: AnyObject]!
        dictPost = ["PNO":self.pno as AnyObject,"category":self.category as AnyObject]
        WebHelper.requestPostUrl(strURL: GlobalConstant.get_events, Dictionary: dictPost, Success:{
            success in
            let status = success.object(forKey: "status") as! String
            print("List of Tournament is ------>>>>>>>>>>>>>>success:",success)
            /// Result fail
            if status == "0"
            {
                self.Eventlist.removeAll()
                self.EvenListingCollectionView.reloadData()
                 Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage:success.value(forKey: "msg") as! String)
            }/// Result success
            else if status == "1"
            {
                self.Eventlist = success.object(forKey: "Eventlist") as! [Any]
                self.EvenListingCollectionView.reloadData()
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
    
   
    func getcategorylist(){
        var DicInput = [String:AnyObject]()
        
        WebHelper.requestPostUrl(strURL: GlobalConstant.get_eventcategories, Dictionary: DicInput, Success: {success in
            let status = String(describing: success.value(forKey: "status")!)
            if status == "1"{
                DropDownVCDayMonth.EventArray = []
                DropDownVCDayMonth.EventArray = success.value(forKey: "Categories") as! NSArray
                self.CategoriesTableView.reloadData()
                
            }else if status == "0"{
                
            }
        }, Failure: {failler in
            print("something went wrong",failler.localizedDescription)
        })
    }

    
    
}
