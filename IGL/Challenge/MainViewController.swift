//
//  MainViewController.swift
//  IGL
//
//  Created by baps on 14/10/18.
//  Copyright © 2018 Mac Min. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    let instanceOfCometChat: CometChat = CometChat();
    let instanceOFreadyUIFile: readyUIFIle = readyUIFIle();
    
    override func viewDidLoad() {
        super.viewDidLoad()
         print("TAb Controller ViweDidLoad.......")
     self.delegate = self//vsp
     
        if let items = self.tabBar.items {
            
          tabBarController?.selectedIndex = 2
            //Get the height of the tab bar
            
            let height = self.tabBar.bounds.height
            
            //Calculate the size of the items
            
            let numItems = CGFloat(items.count)
            let itemSize = CGSize(
                width: tabBar.frame.width / numItems,
                height: tabBar.frame.height)
            
            for (index, _) in items.enumerated(){
                
                //We don't want a separator on the left of the first item.
                
                if index > 0 {
                    
                    //Xposition of the item
                    
                    let xPosition = itemSize.width * CGFloat(index)
                    
                    /* Create UI view at the Xposition,
                     with a width of 0.5 and height equal
                     to the tab bar height, and give the
                     view a background color
                     */
                    let separator = UIView(frame: CGRect(
                        x: xPosition, y: 0, width: 0.5, height: height+32))
                    separator.backgroundColor = UIColor.white
                    tabBar.insertSubview(separator, at: 1)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        
        print("TAb Controller.......")
      
        guard let tabBar = tabBarController?.tabBar else { return }
        tabBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        tabBar.selectionIndicatorImage = UIImage().makeImageWithColorAndSize(color: #colorLiteral(red: 0.04705882353, green: 0.09019607843, blue: 0.168627451, alpha: 1), size: CGSize(width: tabBar.frame.width/5, height: tabBar.frame.height))
        tabBar.unselectedItemTintColor = UIColor.white
        
        
        
    }

}



extension MainViewController:UITabBarControllerDelegate
{
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("viewController::::::::::::",viewController)
        guard let navigationController = viewController as? UINavigationController, navigationController.topViewController is ChatViewController else {
             print("ChatViewController::::::::::::")
            return true
        }
        openCometChat()
        return false
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("didSelect:item::::::",item.tag)
        
        if tabBarController?.selectedIndex == 2{
             openCometChat()
        }
        
       
       // if tabBar.selectedItem.
    }
    
    
    func openCometChat(){
       // showCustomHUD()
//        instanceOfCometChat.initializeCometChat("", licenseKey:"COMETCHAT-QQWLI-A1O8B-MAQIT-PBIZQ", apikey:"53496x614953047c26aaa7ac08222ceae01f35", isCometOnDemand:true, success: {(response) in
//            print("successfully initailized")
            //7 Defaults[PDUserDefaults.UserID] --> its a logged in user id
            self.instanceOfCometChat.login(withUID:"SUPERHERO1",success:{(response) in
                print("Tab View..Successful login ")
                
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
//
//
//        },failure:{(error) in
//            print(" Failed to initialized ")
//        })
    }
}
