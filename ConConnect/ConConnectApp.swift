//
//  ConConnectApp.swift
//  ConConnect
//
//  Created by Donald Johnson on 4/29/26.
//

import SwiftUI
import SwiftData

@main
struct ConConnectApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
                    AppDelegate.orientationLock = .all
                }
        }
        .modelContainer(for: ImageItem.self)
    }
}

// App Delegate for orientation locking
class AppDelegate: NSObject, UIApplicationDelegate {
    static var orientationLock = UIInterfaceOrientationMask.all
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
}
