//
//  AppDelegate.swift
//  EvangelhodoDia
//
//  Created by Bianca Cordeiro on 19/02/25.
//
import Swift
import Firebase
import FirebaseAuth
import FirebaseDatabase



class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
