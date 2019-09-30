//
//  WalletViewController.swift
//  IGL
//
//  Created by baps on 07/10/18.
//  Copyright © 2018 Mac Min. All rights reserved.
//

import UIKit
import SafariServices
class RuleTableviewcell: UITableViewCell {
   
    @IBOutlet weak var  RuletextLabel:UILabel!
}
class WalletViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
   //UIView
    @IBOutlet weak var CouponView: UIView!
    @IBOutlet weak var BankAmountView: UIView!
    @IBOutlet weak var CreditAndDebitView: UIView!
    @IBOutlet weak var iglcoinslabel: UILabel!
    
    //UIButton
    @IBOutlet weak var ProceedButton: UIButton!
    @IBOutlet weak var RequestButton: UIButton!
    @IBOutlet weak var RedeemButton: UIButton!
    @IBOutlet weak var BankButton: UIButton!
    @IBOutlet weak var ledgericonlabel: UILabel!
    
    //Label
    @IBOutlet weak var BankLAbel:UILabel!
    
    //tabelview
 @IBOutlet weak var RulesTableview: UITableView!
    var ArrrayOfRule = ["Must have ₹1000 minimum in your account","Must have a win registered to your account either in an online Tournament or head to head challenge","Must have deposited money once into your wallet","Withdrawal amount can not be more than your total winning amount"]
    var IGLCoinsVar = ""
    var iglledgercoin = ""
    override func viewDidLoad() {
       
        super.viewDidLoad()
        if  self.IGLCoinsVar == ""{
          iglcoinslabel.text = "₹ 0(0 IGL COINS)"
        }else{
           iglcoinslabel.text = "₹ \(10*Int(IGLCoinsVar)!) (\(IGLCoinsVar) IGL COINS"
        }
        
        if iglledgercoin == ""{
          ledgericonlabel.text = "0 IGL COINS)"
        }else{
            ledgericonlabel.text = "0 IGL COINS"
        }
        
        CreditAndDebitView.layer.cornerRadius = 10
        
        ProceedButton.layer.cornerRadius = 10
        RequestButton.layer.cornerRadius = 10
        RedeemButton.layer.cornerRadius = 10
        
        Global.buttonRadius(BankButton)
        Global.labelRoundRadius(BankLAbel)
        // Do any additional setup after loading the view.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArrrayOfRule.count
    }
    var count = 0
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RuleTableviewcell", for: indexPath) as! RuleTableviewcell
       count = count + 1
       if count < 5{
        cell.RuletextLabel.text = ArrrayOfRule[indexPath.row]
     }
        else
        {
            RulesTableview.sectionHeaderHeight = 0.0;
           self.RulesTableview.separatorStyle = .none
        }
        cell.selectionStyle = .none
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func GoToNotification(_ sender: UIBarButtonItem) {
        
        let storyObj = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyObj.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func BackAction(_sender:Any)
    {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func BuyCoins(_ sender: Any) {
        let user_id = UserDefaults.standard.value(forKey: "user_id") as! String
        let url = "https://iglnetwork.com/beta/stores/index/\(user_id)"
        print("url is coming",url)
        let svc = SFSafariViewController(url: URL(string: url)!, entersReaderIfAvailable: true)
        svc.preferredBarTintColor =   #colorLiteral(red: 0.06274509804, green: 0.1411764706, blue: 0.2705882353, alpha: 1)
        svc.preferredControlTintColor = #colorLiteral(red: 0.06274509804, green: 0.1411764706, blue: 0.2705882353, alpha: 1)
        present(svc, animated: true, completion: nil)
        if #available(iOS 11.0, *) {
            svc.dismissButtonStyle = .close
        } else {
            // Fallback on earlier versions
        }
    }
    
    @IBAction func GoToWalletWeb(_ sender: Any) {
        RedirecttoWallet()
    }
    
    @IBAction func GotoWalletWebFromRedeem(_ sender: Any) {
        RedirecttoWallet()
    }
    
    func RedirecttoWallet(){
    let username = UserDefaults.standard.value(forKey: "username") as! String
    let url = "https://iglnetwork.com/beta/profile/wallet/\(username)"
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
    
    @IBAction func ViewLedger(_ sender: Any){
        let username = UserDefaults.standard.value(forKey: "username") as! String
        let url = "https://iglnetwork.com/beta/profile/ladgers/\(username)"
        print("url is coming",url)
        let svc = SFSafariViewController(url: URL(string: url)!, entersReaderIfAvailable: true)
        svc.preferredBarTintColor =   #colorLiteral(red: 0.06274509804, green: 0.1411764706, blue: 0.2705882353, alpha: 1)
        present(svc, animated: true, completion: nil)
        if #available(iOS 11.0, *) {
            svc.dismissButtonStyle = .close
        } else {
            // Fallback on earlier versions
        }
    }
}
