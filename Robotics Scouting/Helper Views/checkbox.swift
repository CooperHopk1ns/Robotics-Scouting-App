//
//  checkbox.swift
//  Robotics Scouting
//
//  Created by Cooper Hopkins on 3/15/23.
//

import SwiftUI

struct checkbox: View {
    
    @Binding var checked: Bool
    
    var body: some View {
            Image(systemName: checked ? "checkmark.square.fill" : "square")
                .foregroundColor(checked ? Color(UIColor.systemBlue) : Color.secondary)
                .onTapGesture {
                    self.checked.toggle()
                }
        }
}

struct checkbox_Previews: PreviewProvider {
    
    struct CheckboxViewHolder: View {
            @State var checked = false

            var body: some View {
                checkbox(checked: $checked)
            }
        }
    
    static var previews: some View {
        CheckboxViewHolder()
    }
}
