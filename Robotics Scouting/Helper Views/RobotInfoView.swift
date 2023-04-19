//
//  RobotInfoView.swift
//  Robotics Scouting
//
//  Created by Cooper Hopkins on 4/18/23.
//

import SwiftUI

struct RobotInfoView: View {
    
    @State var selectedTeam = 0
    
    func getTeamRobotDataRequest() async {
        guard let selectedTeamURL = URL(string: "http://api.etronicindustries.org/v1/\(selectedTeam)/data/pit") else {
            print("Error")
            return
        }
        do {
            let(decodedTeamData, _) = try await URLSession.shared.data(from: selectedTeamURL)
            //Decode Data
            //Store In Variable
            //Plug Info Into Text
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        VStack {
            Text("Robot Info")
                .font(.system(size: 20))
                .fontWeight(.bold)
            ScrollView {
                
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
