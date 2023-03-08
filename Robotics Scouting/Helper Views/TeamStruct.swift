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

public struct TeamJSON: Decodable {
    public let id: Int
    public let team: String
    public let matchNumber: String
    public let alliance: String
    public let priorMatches: String
    public let autoBottom: String
    public let autoMiddle: String
    public let autoTop: String
    public let teleBottom: String
    public let teleMiddle: String
    public let teleTop: String
    public let allianceLinks: String
    public let createdAt: String
    public let updatedAt: String
}

public struct responseJSON: Decodable {
    public let success: Bool
    public let team: TeamJSON
}
