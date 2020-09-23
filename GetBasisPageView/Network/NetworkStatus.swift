//
//  NetworkStatus.swift
//  ProjectG1
//
//  Created by Ramesh Madavaram on 22/09/20.
//  Copyright © 2020 Ramesh. All rights reserved.
//

import Foundation
import UIKit
import Reachability

class NetworkStatus: NSObject {
    
    static let networkStatus = NetworkStatus()
    let reachability = try! Reachability()
    var networkState: Bool? = false
    
    func isInternet() -> Bool {
        var temp : Bool = false
        reachability.whenReachable = { reachability in
            print(" **** " , reachability.connection)
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
                 temp = true
            }
            else if reachability.connection == .cellular {
                print("Reachable via Cellular")
                  temp = true
            }
            else  if reachability.connection == .unavailable {
                print("** No Connection")
                 temp = false
            }
        }
        return temp
    }
    
    func checkInternet()  {
        //declare this property where it won't go out of scope relative to your listener
        reachability.whenReachable = { reachability in
            print(" **** " , reachability.connection)
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
            }
            else if reachability.connection == .cellular {
                print("Reachable via Cellular")
            }
            else  if reachability.connection == .unavailable {
                print("** No Connection")
            }
           
        }
        reachability.whenUnreachable = { _ in
            print("Not reachable")
        }
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
    }
    
    func stopNotification() {
        reachability.stopNotifier()
    }
    
    func reachabilityStartNotification() {
        //declare this property where it won't go out of scope relative to your listener
        //let reachability = Reachability()!
        
        //declare this inside of viewWillAppear
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            networkState = true
            print("Reachable via WiFi")
        case .cellular:
            networkState = true
            print("Reachable via Cellular")
        case .none:
            networkState = false
            print("Network not reachable")
        case .unavailable:
             print("unavailable")

        }
    }
        func displayNetworkAlert() {
            
            let alertController = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            alertController.show()
        }
    
     func reachabilityStopNotification() {
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
    
}
extension UIAlertController {
    func show() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let vc = UIViewController()
        vc.view.backgroundColor = .clear
        appDelegate.alertWindow.rootViewController = vc
        appDelegate.alertWindow.makeKeyAndVisible()
        vc.present(self, animated: true, completion: nil)
    }
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.alertWindow.isHidden = true
    }
}
