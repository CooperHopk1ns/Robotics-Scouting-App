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
    var gamesPlayed: Int
    //Points
    var totalPoints: Int
    var autoBottomPoints: Int
    var autoMiddlePoints: Int
    var autoTopPoints: Int
    var teleBottomPoints: Int
    var teleMiddlePoints: Int
    var teleTopPoints: Int
    var autoCharged: Int
    var teleCharged: Int
    var engagement: Int
    var mobilityPoints: Int
    var parkingPoints: Int
    var rankingPoints: Int
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
    public let autoCharged: String
    public let teleCharged: String
    public let engagement: String
    public let mobilityPoints: String
    public let parkingPoints: String
    public let rankingPoints: String
    public let createdAt: String
    public let updatedAt: String
}

public struct responseJSON: Decodable {
    public let success: Bool
    public let team: TeamJSON
}

public struct pushJSON: Encodable {
        var team: Int
        var password: String
        var matchNumber: Int
        var alliance: String
        var priorMatches: Int
        var autoBottom: Int
        var autoMiddle: Int
        var autoTop: Int
        var teleBottom: Int
        var teleMiddle: Int
        var teleTop: Int
        var allianceLinks: Int
        var autoCharged: Int
        var teleCharged: Int
        var engagement: Int
        var mobilityPoints: Int
        var parkingPoints: Int
        var rankingPoints: Int
}

public struct teamsAvailStruct: Decodable {
    public let success: Bool
    public let array: Array<teamAvailDataStruct>
}
public struct teamAvailDataStruct: Decodable {
    public let id: Int
    public let team: String
}

public struct AverageDataStruct: Decodable {
    var success: Bool
    var objectJSON: AverageDataTeamStruct
}

public struct AverageDataTeamStruct: Decodable, Hashable, Encodable {
        public let team: String
        public let matchNumber: String
        public let alliance: String
        public let autoBottom: Double
        public let autoMiddle: Double
        public let autoTop: Double
        public let teleBottom: Double
        public let teleMiddle: Double
        public let teleTop: Double
        public let allianceLinks: Double
        public let autoCharged: Double
        public let teleCharged: Double
        public let engagement: Double
        public let mobilityPoints: Double
        public let parkingPoints: Double
        public let rankingPoints: Double
}

public struct AverageTeamStruct: Hashable, Codable, Identifiable {
    public var id: Int
    var name: String
    var totalPoints: Double
    var obj: AverageDataTeamStruct
}

public struct PitTeamPushStruct: Decodable, Hashable, Encodable {
    public let team: String
    public let password: String
    public let drivetrain: String
    public let link: String
    public let intake: String
    public let pneumatics: String
    public let pieceType: String
    public let highestNode: String
    public let bestAuto: String
    public let defense: String
}

public struct PitTeamStruct: Hashable, Codable, Identifiable {
    public var id: Int
}
