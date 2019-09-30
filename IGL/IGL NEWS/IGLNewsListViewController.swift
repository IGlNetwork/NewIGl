//
//  IGLNewsListViewController.swift
//  IGL
//
//  Created by baps on 10/11/18.
//  Copyright © 2018 Mac Min. All rights reserved.
//

import UIKit
class IGLNewsCollectionCel: UICollectionViewCell {
    @IBOutlet weak var DateUIlabel:UILabel!
    @IBOutlet weak var PostedByLabel:UILabel!
    @IBOutlet weak var IGLNewsImage:UIImageView!
    @IBOutlet weak var DescriptionLabel:UILabel!
     @IBOutlet weak var NewsTitleLabel:UILabel!
    @IBOutlet weak var ReadMoreView:UIView!
    @IBOutlet weak var ReadMoreButton: UIButton!
    
}
class IGLNewsListViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var IGLNewsCollectionView: UICollectionView!
    var NewsArray:NSArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        //let newHeight = height - XPhoneHeight
        layout.itemSize = CGSize(width: width-20, height:385)
       layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        IGLNewsCollectionView!.collectionViewLayout = layout
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        Get_IGLNewsList()
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NewsArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IGLNewsCollectionCel", for: indexPath) as! IGLNewsCollectionCel
        let obj = NewsArray[indexPath.row] as! NSDictionary
         cell.DateUIlabel.text = obj["NewsDate"] as! String
         cell.NewsTitleLabel.text = obj["NewsTitle"] as! String
         cell.DescriptionLabel.text = obj["NewsDescription"] as! String
         cell.IGLNewsImage.clipsToBounds = true
        let url2 = URL(string:obj["NewsImage"] as! String)
        cell.IGLNewsImage.kf.setImage(with: url2,
                                               placeholder:UIImage(named: "vikings-war-of-clans_min"),
                                               options: [.transition(.fade(1))],
                                               progressBlock: nil,
                                               completionHandler: nil)
        
        cell.ReadMoreView.layer.cornerRadius = 15
        cell.ReadMoreButton.tag = indexPath.row
        cell.ReadMoreButton.addTarget(self, action: #selector(IGLNewsListViewController.GoToDetailsOfNews), for: .touchUpInside)
        
        return cell
    }
    @objc func GoToDetailsOfNews(sender:UIButton) {
       let storyobj = UIStoryboard(name: "Main", bundle: nil)
        let vcobj =  storyobj.instantiateViewController(withIdentifier: "IGLNEWSViewController") as! IGLNEWSViewController
        let obj = NewsArray[sender.tag] as! NSDictionary
        vcobj.NewsId = obj["NewsID"] as! String
        self.navigationController?.pushViewController(vcobj, animated: true)
    }

    @IBAction func BackAction(_ send: Any)
    {
        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
        let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"SW-Reaveal") as! SWRevealViewController
        self.present(SwreavelObj, animated: true, completion: nil)
        // Please write here code for Login
        //self.Validate_text_fields()
    }
    
    @IBAction func NotiAction(_ sender:Any)
    {
        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
        let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(SwreavelObj, animated: true)
    }
}
extension IGLNewsListViewController{
    func Get_IGLNewsList(){
        var DicInput = [String:AnyObject]()
        DicInput = ["PNO":"0" as! AnyObject]
        WebHelper.requestPostUrl(strURL: GlobalConstant.get_newslist, Dictionary: DicInput, Success: {success in
            if success.object(forKey: "status") as! String == "1"{
                self.NewsArray = success.object(forKey: "Newslist") as! NSArray
                self.IGLNewsCollectionView.reloadData()
            }
            else if success.object(forKey: "status") as! String == "0"{
                
            }
            
            
        }, Failure: {failler in
        Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage: failler.localizedDescription)
        })
    }
}
