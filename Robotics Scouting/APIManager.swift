//
//  APIManager.swift
//  Robotics Scouting
//
//  Created by Ayman Mohamud on 3/6/23.
//

import Foundation
import Alamofire

public class APIManager {
    
    /// API Endpoint
    public var endpoint: String
    
    /// Version of the API that the app runs on
    public var version: String
    
    /// Combined link with both the endpoint and version
    public var link: String
    
    /// An FRC team represented by the JSON returned from the API
    /// Represented as an optional because it does not exist upon startup.
    public var teamData: TeamJSON?
    
    init() {
        self.endpoint = "http://api.etronicindustries.org/"
        self.version = "v1"
        self.link = endpoint + version + "/"
        self.teamData = nil
    }
    
    public func fetchTeam(team: String) {
        AF.request("http://api.etronicindustries.org/v1/3082/data", method: .get).response { response in
             
             let decoder = JSONDecoder()
             
             let d = try! decoder.decode(responseJSON.self, from: response.data!)
             
             self.teamData = d.team
            
             print(self.teamData!)
         }
    }
    
    // TODO:
    // Make another function for pushing data to the API
    // Make a POST request (modify the .get method above)
    // To update the JSON for testing, we must send a single JSON that looks like this:
    // (Example: changing their current alliance value)
    // {
    //   "option": "alliance",
    //   "value": "blue",
    // }
    // In the real API/App/bullshit, we will send a JSON containing every value that we want to update whenever the "Submit" button is pressed in the app.
    // Working on that feature tonight.
}
