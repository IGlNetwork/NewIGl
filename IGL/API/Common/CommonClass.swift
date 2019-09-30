//
//  CommonClass.swift
//  Larenon SFA
//
//  Created by tosif on 06/09/17.
//  Copyright © 2017 Cuztomise.Infotech. All rights reserved.
//

import Foundation

struct common {
    static let commonUrl = "http://worktoday.in/webapi/EmproWebServices/"
    //"http://nuanceinfotechdemo.website/Empro/EmproWebServices/"
    
    
    static let get_microsite_category_list = commonUrl + "get_microsite_category_list"
    static let get_microsite_product_list = commonUrl + "get_microsite_product_list"
    static let get_microsite_deals_of_day_list = commonUrl + "get_microsite_deals_of_day_list"
    static let get_microsite_contact_us_list = commonUrl + "get_microsite_contact_us_list"
    static let get_social = commonUrl + "get_social"
    static let microsite_social_link = commonUrl + "get_social"
    
    
    
    
    static func JSONStringify(value: AnyObject,prettyPrinted:Bool = false) -> AnyObject
    {
        
        let options = prettyPrinted ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions(rawValue: 0)
        
        
        if JSONSerialization.isValidJSONObject(value) {
            
            do{
                let data = try JSONSerialization.data(withJSONObject: value, options: options)
                if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    return string  as AnyObject
                }
            }catch {
                
                print("error")
                //Access error here
            }
            
        }
        return "" as AnyObject
        
    }
    
    static func JSONStringy(value: AnyObject,prettyPrinted:Bool = false) -> String{
        
        let options = prettyPrinted ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions(rawValue: 0)
        
        
        if JSONSerialization.isValidJSONObject(value) {
            
            do{
                let data = try JSONSerialization.data(withJSONObject: value, options: options)
                if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    return string as String
                }
            }catch {
                
                print("error")
                //Access error here
            }
            
        }
        return ""
        
    }
    
   
    
    
    static var from_Date = NSString()
    static var From_Time = NSString()
    static var T_Time = NSString()
    static var to_Date = NSString()
    static var Prior = NSString()
    static var status = Bool()
    
    
   static var task_id = ""
   static var empID = ""
    static var team = ""
  static var Location = ""
    static var Name = ""
    
    static var kkPushNotificationToken = ""
    
    
    
     static var customer_id = NSString()
     static var emp_id = NSString()
     static var phone = NSString()
     static var Username = NSString()
     static var salesman_id = NSString()
     static var name = NSString()
     static var id = NSNumber()
    static var ISSearch = NSString()
    
     static var PickDate = NSString()
    
     static var Complete:NSMutableArray = []
}
