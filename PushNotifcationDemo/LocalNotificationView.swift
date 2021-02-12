//
//  LocalNotificationView.swift
//  PushNotifcationDemo
//
//  Created by Knoxpo MacBook Pro on 12/02/21.
//

import SwiftUI
import UserNotifications
struct LocalNotificationView: View {
    var body: some View {
       
        
        Button("Send Notification") {
            
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { success,error in
                
                if success {
                   print("successfuly send notificattion")
                    
                }
                else if let error = error {
                    
                    print("\(error)")
                    
                }
                
                
                
                
            }
            //2
            let anyop = UNMutableNotificationContent()
            anyop.sound = UNNotificationSound.default
            anyop.title = "Notification"
            anyop.subtitle = "Notification Detail"
            anyop.badge = 1
            anyop.body = "To Show Local Notification"
            
            //3
            let imagename = "1"
            guard let imagepath = Bundle.main.url(forResource: imagename, withExtension: "png") else { return }
            
            let attachment = try!
                UNNotificationAttachment(identifier: imagename, url: imagepath, options: .none)
            anyop.attachments = [attachment]
            //4
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval:5.0, repeats: false)
            
            let request  = UNNotificationRequest(identifier: "Not.01", content: anyop, trigger: trigger)
            
            //5
            UNUserNotificationCenter.current().add(request)
            
            
        }
        
        
        
        
        
    }
}

struct LocalNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotificationView()
    }
}
