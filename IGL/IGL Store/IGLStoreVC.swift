//
//  IGLStoreVC.swift
//  IGL
//
//  Created by Mac Min on 16/10/18.
//  Copyright © 2018 Mac Min. All rights reserved.
//

import UIKit
import SafariServices


class IGLStoreCell: UICollectionViewCell
{
    
    @IBOutlet weak var BuyNowView: UIView!
    @IBOutlet weak var CellImage: UIImageView!
    @IBOutlet weak var CoinsLabel: UILabel!
    @IBOutlet weak var Pricelabel: UILabel!
    

}



class IGLStoreVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
    
     @IBOutlet weak var IGLStoreCollectionView: UICollectionView!
    
    var CreditArray:NSArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
         ToGetIglCoins()
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        //let newHeight = height - XPhoneHeight
        layout.itemSize = CGSize(width: width/2-22, height: 194.0)
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 15
        IGLStoreCollectionView!.collectionViewLayout = layout
        // Do any additional setup after loading the view.
    }
    
    /*
     "ProductName": "10 ",
     "ProductPrice": "100"
     */
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.CreditArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = IGLStoreCollectionView.dequeueReusableCell(withReuseIdentifier: "IGLStoreCell", for: indexPath) as! IGLStoreCell
        cell.BuyNowView.layer.cornerRadius = 15
        cell.CellImage.layer.cornerRadius = cell.CellImage.frame.size.height/2
         cell.CellImage.clipsToBounds = true
        let obj  =  CreditArray[indexPath.row] as! NSDictionary
        cell.CoinsLabel.text = obj.value(forKey: "ProductName") as! String + "  IGL COINS"
        let price =  obj.value(forKey: "ProductPrice") as! String
        cell.Pricelabel.text =  "Price: ₹" + price
        return cell
    }
    
    
    @IBAction func BackAction(_sender:Any)
    {
        let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
        let vc : SWRevealViewController = mainStoryboard.instantiateViewController(withIdentifier: "SW-Reaveal")as! SWRevealViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        
//        print("Task indexPath.row:",indexPath.row)
//        let mainStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
//        let vc : EventDetailsVC = mainStoryboard.instantiateViewController(withIdentifier: "EventDetailsVC")as! EventDetailsVC
//        self.present(vc, animated: true, completion: nil)
//        
        
        return true
    }
    
    
    @IBAction func buyNowButtonAction(_ sender: Any) {
        let url = URL(string: "https://iglnetwork.com/beta/stores")!
        
        if UIApplication.shared.canOpenURL(url) {
            let svc = SFSafariViewController(url: url, entersReaderIfAvailable: true)
            svc.preferredBarTintColor = #colorLiteral(red: 0.2039215686, green: 0.5254901961, blue: 0.8, alpha: 1)
            self.present(svc, animated: true, completion: nil)
            if #available(iOS 11.0, *) {
                svc.dismissButtonStyle = .close
                
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    
    @IBAction func NotiAction(_ sender:Any)
    {
        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
        let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(SwreavelObj, animated: true)
    }
    
    
    
    
    
    
    func ToGetIglCoins() {
        var DicInput = [String:AnyObject]()
        WebHelper.requestPostUrl(strURL:GlobalConstant.get_credits, Dictionary: DicInput, Success: {success in
            let status = String(describing: success.value(forKey: "status")!)
            if status == "1"{
                self.CreditArray = success.object(forKey: "CreditList") as! NSArray
                self.IGLStoreCollectionView.reloadData()
            }
        }, Failure: {failler in
            print("Something went wrong.....",failler.localizedDescription)
        })
    }
    
    
    
    
}




/*
 
 
 
 
 */
