//
//  TeamStruct.swift
//  Robotics Scouting
//
//  Created by Cooper Hopkins on 3/2/23.
//

import Foundation

struct Team: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var averagePoints: Double
    var gamesPlayed: Int
    //Points
    var autoBottomPoints: Int
    var autoMiddlePoints: Int
    var autoTopPoints: Int
    var teleBottomPoints: Int
    var teleMiddlePoints: Int
    var teleTopPoints: Int
}

class TeamsClass : ObservableObject {
    @Published var teams : [Team] = []
}
