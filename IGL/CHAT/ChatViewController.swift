//
//  ChatViewController.swift
//  IGL
//
//  Created by baps on 11/11/18.
//  Copyright © 2018 Mac Min. All rights reserved.
//

import UIKit


class ChatViewController: UIViewController,SWRevealViewControllerDelegate {
    @IBOutlet weak var MenuButton:UIBarButtonItem!
    
    let instanceOfCometChat:CometChat = CometChat()
    let instanceOFreadyUIFile:readyUIFIle = readyUIFIle()
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
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
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
         print("viewWillAppear..........")
        //RJ1GD-CM5OS-F4XTU-TE4HW-9XTJM
      //  self.showCustomHUD()
        //COMETCHAT-I9LSN-M8ZAB-1N1KT-4T9UG
//        instanceOfCometChat.initializeCometChat("", licenseKey:"COMETCHAT-QQWLI-A1O8B-MAQIT-PBIZQ", apikey:"53496x614953047c26aaa7ac08222ceae01f35", isCometOnDemand:true, success: {(response) in
//            print("successfully initailized")
            //7 Defaults[PDUserDefaults.UserID] --> its a logged in user id
            self.instanceOfCometChat.login(withUID:"SUPERHERO1",success:{(response) in
                print(" Successful login ")
                
                let isFullScreen : Bool = true;
                let readyUI: readyUIFIle = readyUIFIle();
                readyUI.launchCometChat(isFullScreen, observer: self, userInfo: { (response) in
                    
                }, groupInfo: { (response) in
                    
                }, onMessageReceive: { (response) in
                    
                }, success: { (response) in
                    
                }, failure: { (error) in
                    
                }, onLogout: { (response) in
                    
                })
              //  self.hideCustomHUD()
            },failure:{(error) in
                print(" Failed login ")
            });
            
            
//        },failure:{(error) in
//            print(" Failed to initialized ")
//        })
    }
    
    
    
    @IBAction func NotiAction(_ sender:Any)
    {
        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
        let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(SwreavelObj, animated: true)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        print("touchesBegan...........................")
        var touch: UITouch = touches.first!
        //location is relative to the current view
        // do something with the touched point
       
    }
    
    
    
}
