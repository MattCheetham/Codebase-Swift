//
//  CodebaseController.swift
//  CodebaseKit
//
//  Created by Matthew Cheetham on 13/11/2015.
//  Copyright © 2015 Matt Cheetham. All rights reserved.
//

import Foundation
import ThunderRequestTV

public class CodeBaseController {
    
    let requestController = TSCRequestController(baseAddress: "https://api3.codebasehq.com")
    
    public init(credential: TSCRequestCredential!) {

        requestController.sharedRequestCredential = credential
        requestController.sharedRequestHeaders["Accept"] = "application/json"
        
    }
    
    public func getActivity(completionHandler: (activities: [Any], requestError: NSError?) -> ()) {
        
        requestController.get("activity") { (response: TSCRequestResponse?, requestError: NSError?) -> Void in
            
            if ((requestError) != nil) {
                
                return;
                
            }
            
            if let activityArray = response?.array as? [[String: AnyObject]] {
            
                activityArray.map({
                    
                    print($0)
                    
                })
//                let services = servicesArray.map({
//                    
//                    Service(dictionary: $0)
//                    
//                })
                
//                completionHandler(services: services, requestError: nil)
                
//            }
        
            }
        
    }
}

}