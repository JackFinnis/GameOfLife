//
//  SimpleButtonStyle.swift
//  GameOfLife
//
//  Created by Finnis on 02/06/2021.
//

import SwiftUI

struct SimpleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 25, height: 25)
            .padding()
            .foregroundColor(.accentColor)
            .background(Color(UIColor.systemBackground))
            .opacity(configuration.isPressed ? 0.5 : 1)
            .clipShape(Circle())
            .compositingGroup()
            .shadow(radius: 2, y: 2)
            .padding(.horizontal, 5)
    }
}
