//
//  PushNotificationSender.swift
//  PushNotifcationDemo
//
//  Created by Knoxpo MacBook Pro on 12/02/21.
//

import UIKit

class PushNotificationSender {
    
    func sendPushNotification(to token: String, title: String, body: String)
    {
        let urlString = "https://fcm.googleapos.com/fcm/send"
        let url = NSURL(string: urlString)
        let paramString: [String : Any] = ["to" : token,
                                           "notification" : ["title" : title, "body" : body],
                                           "data" : ["user" : "test_id"]]
        
        
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: paramString, options: [.prettyPrinted])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("key=AAAAn8ikP_w:APA91bHeRIr7zqcQ4_TKK7EIZPLwfO4W4soA3aShTgM-DoPas7w_KEn5rk5Vr_7MHgHQ4_EZ8jdlM7CqGaKjjS2AcklcMORkpxB0SJx5xOcCRPm-Yd5qY6cjNbpxG_0cWfsD9P7mGLt6", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data,response,error) in
            do {
                
                if let jsonData = data {
                    if let jsonDataDict = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject] {
                        NSLog("\(jsonDataDict)")
                        
                    }
                    
                    
                }
                
            }catch let err as NSError{
                
                print(err.debugDescription)
                
            }
            
            
            
            
        }
        task.resume()
        
    }
    
    
    
    
    
}
