//
//  About.swift
//  Robotics Scouting
//
//  Created by Cooper Hopkins on 3/6/23.
//

import SwiftUI

struct About: View {
    var body: some View {
        NavigationView {
            Text("This is a small app programmed by Chicken Bot Pie (Team 3082) for scouting at robotics competitions.")
                .padding([.leading, .trailing], 30)
        }
        .navigationTitle("About Us")
    }
}

struct About_Previews: PreviewProvider {
    static var previews: some View {
        About()
    }
}
