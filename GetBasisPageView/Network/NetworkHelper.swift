//
//  NetworkHelper.swift
//  GetBasisPageView
//
//  Created by Ramesh Madavaram on 22/09/20.
//  Copyright © 2020 Ramesh. All rights reserved.
//

import Foundation
import UIKit

//Card related Urls
enum CardURL : String{
    case getCardList = "https://gist.githubusercontent.com/anishbajpai014/d482191cb4fff429333c5ec64b38c197/raw/b11f56c3177a9ddc6649288c80a004e7df41e3b9/HiringTask.json"
}

class NetworkHelper:NSObject {
    weak var delegate:ViewController?
    var controllerDelegate:NetworkManagerDelegate?
    var requestName:String = ""
    let netCall = NetworkCalls()
    
    func getCardList(controller:UIViewController, completionResult:@escaping((_ success:Bool, _ json: [String:AnyObject]?) -> Void)) {
           //1
          let url = CardURL.getCardList.rawValue
           //2
           netCall.makeGetCall(url: url, controller: controller) { (success, responseData) in
               completionResult(success,responseData)
           }
       }
}
protocol NetworkManagerDelegate {
    //func networkCompletionBlock(success: Bool, requestName:String, msg:String, json:Any)
    func completionBlockWithRequest(data: Data?, requestName:String)
}
