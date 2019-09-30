//
//  EventDetailsVC.swift
//  IGL
//
//  Created by Mac Min on 07/10/18.
//  Copyright © 2018 Mac Min. All rights reserved.
//

import UIKit
import MapKit

class EventDetailsVC: UIViewController
{
    @IBOutlet weak var GoingButton: UIButton!
    @IBOutlet weak var NotGoingButton: UIButton!
    @IBOutlet weak var NotInterestedButton: UIButton!
    @IBOutlet weak var Addresslabel: UILabel!
    @IBOutlet weak var ContactNumberLabel: UILabel!
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var CoverImage: UIImageView!
    @IBOutlet weak var OverviewLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var MapView:MKMapView!
    var event_id = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
          CoverImage.clipsToBounds = true
       // GoingButton.layer.cornerRadius = 15
       // NotGoingButton.layer.cornerRadius = 15
        NotGoingButton.layer.cornerRadius = 15
        NotInterestedButton.layer.cornerRadius = 15
        GoingButton.layer.cornerRadius = 15
        // Do any additional setup after loading the view.
        eventdetails()
      
        
        
        
    }
    
    
    @IBAction func NotinterestAction(_ sender: Any) {
        ResponseAction(status: "0")
    }
    
    
    @IBAction func NotGoingAction(_ sender: Any) {
        ResponseAction(status: "2")
    }
    
    
    @IBAction func GoingAction(_ sender: Any) {
        ResponseAction(status: "1")
    }
   
    func ResponseAction(status:String){
        var DicInput = [String:AnyObject]()
        DicInput = ["user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject,"event_id":self.event_id as AnyObject,"status": status as AnyObject]
        WebHelper.requestPostUrl(strURL: GlobalConstant.eventusergoinnotgoing, Dictionary: DicInput, Success: {success in
            let status = String(describing: success.value(forKey: "status")!)
            if status == "1"{
                print("some will be done",success.value(forKey: "msg") as! String)
                let EventIntrested = success.value(forKey:"EventIntrested") as! String
               if EventIntrested == "Going"{
                    self.GoingButton.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.5254901961, blue: 0.8, alpha: 1)
                    self.NotGoingButton.backgroundColor = #colorLiteral(red: 0.1490196078, green: 0.3176470588, blue: 0.4823529412, alpha: 1)
                    self.NotInterestedButton.backgroundColor = #colorLiteral(red: 0.1490196078, green: 0.3176470588, blue: 0.4823529412, alpha: 1)
                }else if EventIntrested == "Notgoing" || EventIntrested == "nostatus"{
                    self.GoingButton.backgroundColor = #colorLiteral(red: 0.1490196078, green: 0.3176470588, blue: 0.4823529412, alpha: 1)
                    self.NotGoingButton.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.5254901961, blue: 0.8, alpha: 1)
                    self.NotInterestedButton.backgroundColor = #colorLiteral(red: 0.1490196078, green: 0.3176470588, blue: 0.4823529412, alpha: 1)
                }else if EventIntrested == "Notntrested"{
                    self.NotInterestedButton.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.5254901961, blue: 0.8, alpha: 1)
                    self.GoingButton.backgroundColor = #colorLiteral(red: 0.1490196078, green: 0.3176470588, blue: 0.4823529412, alpha: 1)
                    self.NotGoingButton.backgroundColor =  #colorLiteral(red: 0.1490196078, green: 0.3176470588, blue: 0.4823529412, alpha: 1)
                }
            }else {
                
            }
            
        }, Failure: {failler in
            print("Something went wrong",failler.localizedDescription)
        })
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func BackAction(_sender:Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func NotiAction(_ sender:Any)
    {
        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
        let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(SwreavelObj, animated: true)
    }
    
    
    
   func eventdetails()
    {
        var dictPost:[String: AnyObject]!
        dictPost = ["user_id":UserDefaults.standard.value(forKey: "user_id") as AnyObject,"event_id":self.event_id as AnyObject]
        WebHelper.requestPostUrl(strURL: GlobalConstant.eventdetails, Dictionary: dictPost, Success:{
            success in
            let status = success.object(forKey: "status") as! String
            print("List of Tournament is ------>>>>>>>>>>>>>>success:",success)
            /// Result fail
            if status == "0"
            {
                
            }/// Result success
            else if status == "1"
            {
               let dict = success.object(forKey: "EventDetails") as! NSDictionary
                let EventIntrested = dict.value(forKey:"EventIntrested") as! String
                if EventIntrested == "Going"{
                    self.GoingButton.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.5254901961, blue: 0.8, alpha: 1)
                    self.NotGoingButton.backgroundColor = #colorLiteral(red: 0.1490196078, green: 0.3176470588, blue: 0.4823529412, alpha: 1)
                    self.NotInterestedButton.backgroundColor = #colorLiteral(red: 0.1490196078, green: 0.3176470588, blue: 0.4823529412, alpha: 1)
                }else if EventIntrested == "Notgoing" || EventIntrested == "nostatus"{
                     self.GoingButton.backgroundColor = #colorLiteral(red: 0.1490196078, green: 0.3176470588, blue: 0.4823529412, alpha: 1)
                    self.NotGoingButton.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.5254901961, blue: 0.8, alpha: 1)
                      self.NotInterestedButton.backgroundColor = #colorLiteral(red: 0.1490196078, green: 0.3176470588, blue: 0.4823529412, alpha: 1)
                }else if EventIntrested == "Notntrested"{
                    self.NotInterestedButton.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.5254901961, blue: 0.8, alpha: 1)
                    self.GoingButton.backgroundColor = #colorLiteral(red: 0.1490196078, green: 0.3176470588, blue: 0.4823529412, alpha: 1)
                    self.NotGoingButton.backgroundColor =  #colorLiteral(red: 0.1490196078, green: 0.3176470588, blue: 0.4823529412, alpha: 1)
                }
                let url = URL(string:dict.value(forKey: "EventImage") as! String)
                self.CoverImage?.kf.setImage(with: url,
                                             placeholder:UIImage(named: "placeholder"),
                                             options: [.transition(.fade(1))],
                                             progressBlock: nil,
                                             completionHandler: nil)
                self.Addresslabel.text = dict.value(forKey: "EventAddress") as! String
                
                let location = dict.value(forKey: "EventAddress") as! String
                let geocoder = CLGeocoder()
                geocoder.geocodeAddressString(location) { [weak self] placemarks, error in
                    if let placemark = placemarks?.first, let location = placemark.location {
                        let mark = MKPlacemark(placemark: placemark)
                        
                        if var region = self?.MapView.region {
                            region.center = location.coordinate
                            region.span.longitudeDelta /= 1.0
                            region.span.latitudeDelta /= 0.9
                            self?.MapView.setRegion(region, animated: true)
                            self?.MapView.addAnnotation(mark)
                        }
                    }
                }
                
                self.ContactNumberLabel.text = "\(dict.value(forKey: "EventPhoneno1") as! String) | \(dict.value(forKey: "EventPhoneno2") as! String)"
                self.EmailLabel.text =  dict.value(forKey: "EventEmail") as! String
                self.OverviewLabel.text =  dict.value(forKey: "EventOverview") as! String
                self.DateLabel.text = "\( dict.value(forKey: "EventDate") as! String) | \( dict.value(forKey: "EventStartTime") as! String)-\( dict.value(forKey: "EventEndTime") as! String) | \( dict.value(forKey: "EventLocation") as! String)"
            }  /// Result nil
            else
            {
                Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage: "Internal Server Error")
            }
        }, Failure: {
            failure in
            Global.showAlertMessageWithOkButtonAndTitle(GlobalConstant.APP_NAME, andMessage: failure.localizedDescription)
            
        })
        
    }
}
