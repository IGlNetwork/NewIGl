//
//  HowToPlayVC.swift
//  IGL
//
//  Created by apple on 09/06/19.
//  Copyright © 2019 Mac Min. All rights reserved.
//

import UIKit

class HowToPlayVC: UIViewController, SWRevealViewControllerDelegate {

    @IBOutlet weak var MenuBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // OpenSideMenu()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tournamentAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HowToPlayTournamentVC") as! HowToPlayTournamentVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
  
    @IBAction func challengesAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HowToPlayChallengesVC") as! HowToPlayChallengesVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func battelRoyalAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HowToPlayBattleRoyalVC") as! HowToPlayBattleRoyalVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func NotificationAction(_ sender:Any)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier:"NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func back(_ sender: Any) {
        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
        let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"SW-Reaveal") as! SWRevealViewController
        self.present(SwreavelObj, animated: true, completion: nil)
    }
    
   
    
    
    
    
    func OpenSideMenu()  {
        //Actions for the SideMenu.
        MenuBtn.target = revealViewController()
        MenuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
        //set the delegate to teh SWRevealviewcontroller
        revealViewController().delegate = self
        //self.revealViewController().rearViewRevealWidth = 240
        if self.revealViewController() != nil {
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
    }

    
}
