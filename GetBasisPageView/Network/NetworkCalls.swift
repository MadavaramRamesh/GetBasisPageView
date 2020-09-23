//
//  NetworkCalls.swift
//  GetBasisPageView
//
//  Created by Ramesh Madavaram on 22/09/20.
//  Copyright © 2020 Ramesh. All rights reserved.
//

import Foundation
import Alamofire

class NetworkCalls: NSObject  {
    var session: URLSession!
    // Network Task
    let networkSharedManager = NetworkStatus.networkStatus
    
    // Mark:- Get call
    func makeGetCall(url:String, controller:UIViewController, completion:@escaping((_ success:Bool, _ json:[String:AnyObject]?) -> Void))  {
        // Internet check
        //        if !networkSharedManager.networkState! {
        //            networkSharedManager.displayNetworkAlert()
        //            return
        //        }
        guard let url = URL(string: url) else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print("Error: \(String(describing: error))")
                return
            }
            do {
                let jsonString = NSString(data: data , encoding: String.Encoding.utf8.rawValue)!
                //Remove "/" from jsonString
                let newjsonString = jsonString.replacingOccurrences(of: "/", with: "")
                //serializing newly created string
                let json = try JSONSerialization.jsonObject(with: Data(newjsonString.utf8)
                    , options: JSONSerialization.ReadingOptions.allowFragments) as? [String:AnyObject]
                if let dict = json {
                    print("GET -> responseObject >>>>> \n"  , dict)
                    completion(true, dict)
                }
            }catch let jsonErr{
                print("ERROR in ::::",jsonErr)
            }
        }.resume()
    }
}
