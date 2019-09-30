//
//  IGLTVDetailsViewController.swift
//  IGL
//
//  Created by Mac Min on 18/01/19.
//  Copyright © 2019 Mac Min. All rights reserved.
//

import UIKit
class CommentTvCell: UITableViewCell {
    @IBOutlet weak var CommentedBYLabel:UILabel!
    @IBOutlet weak var UserImageView:UIImageView!
    @IBOutlet weak var CommetedTimeLabel:UILabel!
    @IBOutlet weak var CommentDescription:UILabel!
}

class IGLTVDetailsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var CommentTableView: UITableView!
    
    @IBOutlet weak var CoometedtextView: UITextView!
    @IBOutlet weak var videowebview: UIWebView!
    
    var TVId =  ""
    var videoid = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        CommentTableView.separatorStyle = .none
         CoometedtextView.layer.borderWidth = 0.3
        GetTVDetails()
        let url = URL(string: "https://www.youtube.com/embed/\(videoid)")
        videowebview.loadRequest(URLRequest(url: url!))
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTvCell", for: indexPath) as! CommentTvCell
          cell.UserImageView.layer.cornerRadius = cell.UserImageView.frame.height/2
       
        cell.UserImageView.clipsToBounds = true
        return cell
    }
/*
     user_id: user logged in id
     tv_id : tv id

     */
    @IBAction func BackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func GetTVDetails() {
        var DicInput = ["user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject,"tv_id":self.TVId as AnyObject]
        WebHelper.requestPostUrl(strURL: GlobalConstant.tvdetails, Dictionary: DicInput, Success: {success in
            let status = String(describing: success.value(forKey: "status")!)
            if status == "1"{
                print("success from the serve is-----",success)
            }
        }, Failure: {failler  in
            Global.showAlertMessageWithOkButtonAndTitle("", andMessage: failler.localizedDescription)
            
        })
    }
}
