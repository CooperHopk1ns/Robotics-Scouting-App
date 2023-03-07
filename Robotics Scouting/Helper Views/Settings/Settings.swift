//
//  Settings.swift
//  Robotics Scouting
//
//  Created by Cooper Hopkins on 3/2/23.
//

import SwiftUI

struct Settings: View {
        
    var body: some View {
        NavigationView {
            VStack {
                //User Info
                VStack {
                    
                }
                //Customizable
                    List() {
                        //Language
                        NavigationLink {
                            Languages()
                        } label: {
                            Text("Language")
                        }
                        //Advanced
                        NavigationLink {
                            
                        } label: {
                            Text("Advanced")
                        }
                        //App Icon
                        NavigationLink {
                            
                        } label: {
                            Text("App Icon")
                        }
                //Information
                        //Send Feedback
                        NavigationLink {
                            
                        } label: {
                            Text("Send Feedback")
                        }
                        //Rate
                        NavigationLink {
                            
                        } label: {
                            Text("Rate Our App")
                        }
                        //About
                        NavigationLink {
                            About()
                        } label: {
                            Text("About")
                        }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
