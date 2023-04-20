//
//  RobotInfoView.swift
//  Robotics Scouting
//
//  Created by Cooper Hopkins on 4/18/23.
//

import SwiftUI

struct RobotInfoView: View {
    
    var selectedTeam = 0
    @State var pitDataTeam : PitTeamFetchStruct = PitTeamFetchStruct(team: "", drivetrain: "", link: "", intake: "", pneumatics: "", pieceType: "", highestNode: "", bestAuto: "", defense: "")
    
    func getTeamRobotDataRequest() async {
        guard let selectedTeamURL = URL(string: "http://api.etronicindustries.org/v1/\(selectedTeam)/data/pit") else {
            print("Error")
            return
        }
            //Decode Data
            do {
                let(teamData, _) = try await URLSession.shared.data(from: selectedTeamURL)
                
                let decodedTeamData = try JSONDecoder().decode(PitTeamFetchOuterStruct?.self, from: teamData)
                
                pitDataTeam = decodedTeamData?.objectJSON ?? PitTeamFetchStruct(team: "", drivetrain: "", link: "", intake: "", pneumatics: "", pieceType: "", highestNode: "", bestAuto: "", defense: "")
            } catch {
                print(error)
            }
            //Store In Variable
            //Plug Info Into Text
    }
    
    var body: some View {
        VStack {
            Text("Robot Info")
                .font(.system(size: 20))
                .fontWeight(.bold)
                .padding()
            ScrollView {
                VStack {
                    Text("Build")
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                    VStack {
                        Text("Drivetrain: \(pitDataTeam.drivetrain.capitalized)")
                            .padding([.top, .bottom], 3)
                        Text("Arm: \(pitDataTeam.link.capitalized)")
                            .padding([.top, .bottom], 3)
                        Text("Intake: \(pitDataTeam.intake.capitalized)")
                            .padding([.top, .bottom], 3)
                        Text("Pneumatics: \(pitDataTeam.pneumatics.capitalized)")
                            .padding([.top, .bottom], 3)
                    }
                }
                .padding([.top])
                .frame(width: UIScreen.main.bounds.width-20)
                .padding([.bottom, .top], 5)
                .overlay (
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black, lineWidth: 3)
                )
                .background(Color(UIColor.systemBackground))
                .cornerRadius(20)
                .shadow(radius: 5, y: 5)
                VStack {
                    Text("Playstyle")
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                    VStack {
                        Text("Piece Type: \(pitDataTeam.pieceType.capitalized)")
                            .padding([.top, .bottom], 3)
                        Text("Highest Node: \(pitDataTeam.highestNode.capitalized)")
                            .padding([.top, .bottom], 3)
                        Text("Best Auto: \(pitDataTeam.bestAuto.capitalized)")
                            .padding([.top, .bottom], 3)
                        Text("Defense: \(pitDataTeam.defense.capitalized)")
                            .padding([.top, .bottom], 3)
                    }
                }
                .padding([.top])
                .frame(width: UIScreen.main.bounds.width-20)
                .padding([.bottom, .top], 5)
                .overlay (
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black, lineWidth: 3)
                )
                .background(Color(UIColor.systemBackground))
                .cornerRadius(20)
                .shadow(radius: 5, y: 5)
                
                
            }
        }
        .onAppear {
            Task {
                await getTeamRobotDataRequest()
            }
        }
    }
}

struct RobotInfoView_Previews: PreviewProvider {
    static var previews: some View {
        RobotInfoView()
    }
}
