//
//  InView.swift
//  GrandPashaMatch
//
//  Created by Nicolae Chivriga on 28/11/2024.
//

import SwiftUI

struct InView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            Image("bgfut")
                .resizable()
                .ignoresSafeArea()
           
            Image("infoText")
                .scaleEffect(UIScreen.main.bounds.height > 680 ? 1 : 0.8)
                .overlay {
                    Text("Hold the finger to control your team and guide the player to hit the ball in the right direction. Use strategy and precision to outplay your opponent, defend your goal, and score in their net to secure victory!")
                        .font(.custom(lucki, size: 18))
                        .foregroundStyle(.black)
                        .offset(y: -43)
                        .padding(.horizontal, 78)
                        .multilineTextAlignment(.center)
                    
                }
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: Image("bk")
            .resizable()
            .frame(width: 35, height: 35)
            .onTapGesture {
                dismiss()
            })
    }
}

var lucki: String = "LuckiestGuy-Regular"
