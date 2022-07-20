//
//  portalViewApp.swift
//  portalView
//
//  Created by IACD-013 on 2022/06/20.
//

import SwiftUI
import FirebaseCore



class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}


@main
struct portalViewApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var userStore = UserStore()
    var body: some Scene {
        WindowGroup {
//            ContentView()
//            TabBar()
            Home()
                .environmentObject(userStore)
//            Buttons()
        }
        
    }
}
