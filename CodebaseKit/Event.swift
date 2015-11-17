//
//  Activity.swift
//  CodebaseKit
//
//  Created by Matthew Cheetham on 13/11/2015.
//  Copyright © 2015 Matt Cheetham. All rights reserved.
//

import Foundation

/**
An event is an entry recieved when quering activity from a codebase account. Each activity can relate to a varying number of things such as a commit, a ticket update or even exceptions raised
*/
public struct Event: Equatable {
    
    /**
    An enum to define types of events that come from the activity feed
    */
    public enum EventType: String {
        
        case Push = "push"
        case TicketCreated = "ticketing_ticket"
        case TicketUpdated = "ticketing_note"
        case ExceptionRaised = "exception_create"
        
        public var description : String {
            
            switch self {
                
            case .Push:
                return "Push"
            case .TicketCreated:
                return "Ticket Created"
            case .TicketUpdated:
                return "Ticket Updated"
            case .ExceptionRaised:
                return "Exception Raised"
            }
            
        }
        
    }
    
    /**
     A unique identifier for this event
     */
    public var identifier: Int?
    
    /**
    The title text of the event
    */
    public var title: String?
    
    /**
    The type of event as an EventType
    */
    public var type: EventType?
    
    /**
    The name of the person that triggered the event
    */
    public var authorName: String?
    
    /**
    The gravatar URL of the person that triggered the event
    */
    public var authorGravatarURL: NSURL?
    
    /**
    The name of the project the event is related too where available
    */
    public var projectName: String?
    
    internal init(dictionary: [String: AnyObject]) {
        
        guard let eventDictionary = dictionary["event"] as? [String: AnyObject] else {
            print("Event was missing event key")
            return
        }
        
        identifier = eventDictionary["id"] as? Int
        title = eventDictionary["title"] as? String
        
        if let eventTypeString = eventDictionary["type"] as? String {
            type = EventType(rawValue: eventTypeString)
        }
        
        authorName = eventDictionary["actor_name"] as? String
        
        if let gravatarURLString = eventDictionary["avatar_url"] as? String {
            authorGravatarURL = NSURL(string: gravatarURLString)
        }
        
        if let rawInfoDictionary = eventDictionary["raw_properties"] as? [String: AnyObject] {
            
            projectName = rawInfoDictionary["project_name"] as? String
            
        }
        
    }
    
}

//MARK: - Equatable

public func ==(lhs: Event, rhs: Event) -> Bool {
    return lhs.identifier == rhs.identifier
}
