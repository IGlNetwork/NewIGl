//
//  HowToPlayChallengesVC.swift
//  IGL
//
//  Created by apple on 09/06/19.
//  Copyright © 2019 Mac Min. All rights reserved.
//

import UIKit

class HowToPlayChallengesVC: UIViewController {
    @IBOutlet weak var HowtoaccptchallengeView: UIView!
    @IBOutlet weak var HowtochallengeView: UIView!
    @IBOutlet weak var MAinHeight: NSLayoutConstraint!
    @IBOutlet weak var btn1BackgroundColor: UIButton!
    @IBOutlet weak var btn2backgroundcolor: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.HowtoaccptchallengeView.isHidden = true
        self.HowtochallengeView.isHidden = false
        MAinHeight.constant = 3800
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func howtochallengeAction(_ sender: Any) {
        self.HowtoaccptchallengeView.isHidden = true
        self.HowtochallengeView.isHidden = false
        MAinHeight.constant = 3800
        btn2backgroundcolor.backgroundColor = #colorLiteral(red: 0.1098039216, green: 0.2549019608, blue: 0.4196078431, alpha: 1)
        btn1BackgroundColor.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.5254901961, blue: 0.8, alpha: 1)
    }
    
    @IBAction func Howtoacceptaction(_ sender: Any) {
        self.HowtoaccptchallengeView.isHidden = false
        self.HowtochallengeView.isHidden = true
         MAinHeight.constant = 2600
        btn2backgroundcolor.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.5254901961, blue: 0.8, alpha: 1)
        btn1BackgroundColor.backgroundColor = #colorLiteral(red: 0.1098039216, green: 0.2549019608, blue: 0.4196078431, alpha: 1)
    }
    
}
