//
//  PushNotificationManager.swift
//  PushNotifcationDemo
//
//  Created by Knoxpo MacBook Pro on 12/02/21.
//


import Firebase
import FirebaseFirestore
import FirebaseMessaging
import UIKit
import UserNotifications

class PushNotificationManager: NSObject, MessagingDelegate, UNUserNotificationCenterDelegate {
    
    let userID: String
    init(userID: String) {
        self.userID = userID
        super.init()
    }
    
    func registerForPushNotification() {
        
        if #available (iOS 10.0, *)  {
            
            UserNotifications.UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          
            UserNotifications.UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: { _ , _ in })
            Messaging.messaging().delegate = self
                
      
            
        }
        else
        {
            let setting: UIUserNotificationSettings =  UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(setting)
            
        }
        
        UIApplication.shared.registerForRemoteNotifications()
        
        
        updateFirestorePushTokenIfNeeded()
        
        
        
        
    }
    
    
    
    func updateFirestorePushTokenIfNeeded() {
        
        if let token = Messaging.messaging().fcmToken {
            
            
            let userRef = Firestore.firestore().collection("user_table").document(userID)
            userRef.setData(["fcmToken": token],merge: true)
            
        }
        
        
        
    }
    
    //MessagingRemoteMessage
    
   
    
 /*   func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage)
    {
        print(remoteMessage.appData)
        
    }
    
    
   */
    
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken:  String?) {
        updateFirestorePushTokenIfNeeded()
        
    }
    
    func UserNotificationCenter(_ center:UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void)
    {
        
        print(response)
    }
    
    
}
