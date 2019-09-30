//
//  AboutIGlViewController.swift
//  IGL
//
//  Created by baps on 05/11/18.
//  Copyright © 2018 Mac Min. All rights reserved.
//

import UIKit

class AboutIGlViewController: UIViewController {

    
    @IBOutlet weak var AboutWebView: UIWebView!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var AboutLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://www.youtube.com/embed/6oC-LQ3GbVM")
       AboutWebView.loadRequest(URLRequest(url: url!))
        TogetAboutUsdata()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func BackAction(_ sender: UIButton) {
        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
        let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"SW-Reaveal") as! SWRevealViewController
        self.present(SwreavelObj, animated: true, completion: nil)
    }
    @IBAction func NotiAction(_ sender:Any)
    {
        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
        let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(SwreavelObj, animated: true)
    }
    
    
    func TogetAboutUsdata() {
        var DicInput = ["page_id":"1" as AnyObject]
        WebHelper.requestPostUrl(strURL:GlobalConstant.get_pages_About, Dictionary: DicInput, Success: {success in
            let status = String(describing:success.value(forKey: "status")!)
            if status == "1"{
                let Pagedetails = success.object(forKey: "Pagedetails") as! NSArray
                let pageobj = Pagedetails[0] as! NSDictionary
                
                let About = pageobj.value(forKey: "PageDescription") as! String
                self.AboutLabel.text = About
                self.TitleLabel.text = pageobj.value(forKey: "PageTitile") as! String
                
            }
            else if status == "0"{
            }
        }, Failure: {failler in
            print("Something went wrong",failler.localizedDescription)
        })
    }
    
    
    
}
