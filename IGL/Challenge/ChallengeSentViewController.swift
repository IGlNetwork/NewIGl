//
//  ChallengeSentViewController.swift
//  IGL
//
//  Created by baps on 02/10/18.
//  Copyright © 2018 Mac Min. All rights reserved.
//

import UIKit

class ChallengeSentViewController: UIViewController {

    @IBOutlet weak var ViewYourProfileView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewYourProfileView.layer.cornerRadius = 15
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func BackAction(_ sender: UIBarButtonItem) {
       self.navigationController?.popViewController(animated: true)
    }
    

    @IBAction func GoToDashBoardProfileAction(_ sender: UIButton) {
        let storyObj = UIStoryboard(name: "Main", bundle: nil)
        let obj = storyObj.instantiateViewController(withIdentifier: "ChallengeRMadeViewController") as! ChallengeRMadeViewController
        self.navigationController?.pushViewController(obj, animated: true)
    }
    @IBAction func NotiAction(_ sender:Any)
    {
        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
        let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(SwreavelObj, animated: true)
    }
}
