//
//  TeamStruct.swift
//  Robotics Scouting
//
//  Created by Cooper Hopkins on 3/2/23.
//

import Foundation

struct Team: Hashable, Codable {
    var name: String
    var averagePoints: Double
    var gamesPlayed: Int
}

class TeamsClass : ObservableObject {
    @Published var teams : [Team] = []
}
