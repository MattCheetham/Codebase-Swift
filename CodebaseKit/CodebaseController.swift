//
//  CodebaseController.swift
//  CodebaseKit
//
//  Created by Matthew Cheetham on 13/11/2015.
//  Copyright © 2015 Matt Cheetham. All rights reserved.
//

import Foundation
import ThunderRequestTV

/**
The CodeBase controller is responsible for all interactions with the codebase API. It must be initialised with a TSCRequestCredential containing the API username and key found in a users profile in order to be able to correctly request data
*/
public class CodeBaseController {
    
    let requestController = TSCRequestController(baseAddress: "https://api3.codebasehq.com")
    
    public init(credential: TSCRequestCredential!) {

        requestController.sharedRequestCredential = credential
        requestController.sharedRequestHeaders["Accept"] = "application/json"
        
    }
    
    /**
    Requests the first page of recent activity that is seen on the homepage of an account by the user
    */
    public func getActivity(completionHandler: (activities: [Event]?, requestError: NSError?) -> ()) {
        
        requestController.get("activity?raw=true") { (response: TSCRequestResponse?, requestError: NSError?) -> Void in
            
            if let error = requestError {
                completionHandler(activities: nil, requestError: error)
                return;
            }
            
            if let eventsArray = response?.array as? [[String: AnyObject]] {
            
                let events = eventsArray.map({
                    
                    Event(dictionary: $0)
                    
                })
                
                completionHandler(activities: events, requestError: nil)
                
            }
        
        }
        
    }
}