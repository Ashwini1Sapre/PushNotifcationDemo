//
//  ContentView.swift
//  PushNotifcationDemo
//
//  Created by Knoxpo MacBook Pro on 12/02/21.
//

import SwiftUI
import UserNotifications
struct ContentView: View {
    var body: some View {
        
       //1
        Button("SendNotificaton") {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) {
                success,error in
                if success {
                    
                    print("Authorization granted")
                    
                    
                }
                
                else if let error = error
                {
                    print(error.localizedDescription)
                    
                }
                
                
            }
            //2
            let content = UNMutableNotificationContent()
            content.title = "Notif tutorial"
            content.subtitle = "iOS APP"
            content.body = "notif trigger"
            content.sound = UNNotificationSound.default
            //3
            let imageName = "applelogo"
            guard let imagUrl = Bundle.main.url(forResource: imageName, withExtension: "png") else { return }
            let attachment  = try! UNNotificationAttachment(identifier: imageName, url: imagUrl, options: .none)
            content.attachments = [attachment]
                //4
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request = UNNotificationRequest(identifier: "notification.id.01", content: content, trigger: trigger)
            //5
            UNUserNotificationCenter.current().add(request)
          
            
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
