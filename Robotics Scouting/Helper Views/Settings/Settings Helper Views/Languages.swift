//
//  Language.swift
//  Robotics Scouting
//
//  Created by Cooper Hopkins on 3/6/23.
//

import SwiftUI

struct Languages: View {
    
    @State var searchText = ""
    @State var languages = ["English", "Français", "Español", "Italiano", "Português"]
    @State private var showAlert = false
    @State var change = false
    @State var selectedLanguage = ""
    
    var searchResults: [String] {
        if searchText.isEmpty {
            return languages
        } else {
            return languages.filter {
                $0.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    func changeLanguage(selected: String) {
        change = false
        print(selected)
    }
    
    var body: some View {
        NavigationView {
            List((searchResults), id: \.self) {language in
                Button(language) {
                    showAlert = true
                    selectedLanguage = language
                }
                .alert(
                            "Confirm",
                            isPresented: $showAlert,
                            presenting: selectedLanguage
                        ) { details in
                            Button() {
                                changeLanguage(selected: selectedLanguage)
                            } label: {
                                Text("Confirm")
                            }
                            Button(role: .cancel) {
                                // Handle the retry action.
                            } label: {
                                Text("Cancel")
                            }
                        } message: { details in
                            Text("Are you sure you want to change the language to \(selectedLanguage)?")
                        }
            }
        }
        .navigationTitle("Language")
        .searchable(text: $searchText, prompt: "Enter Language")
    }
}

struct Language_Previews: PreviewProvider {
    static var previews: some View {
        Languages()
    }
}
