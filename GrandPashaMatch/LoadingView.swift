//
//  LoadingView.swift
//  GrandPashaMatch
//
//  Created by Nicolae Chivriga on 28/11/2024.
//

import SwiftUI


struct LoadingView: View {
    @State var loadingStart: Bool = false
    @State var goToMenu: Bool = false
    var body: some View {
        ZStack {
            Image("bgfut")
                .resizable()
                .ignoresSafeArea()
            
            NavigationLink("", destination: MenuView(), isActive: $goToMenu)
            VStack {
                Image("kislorod")
                
                VStack(spacing: 0) {
                    Image("celik")
                    
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .overlay(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.init(hex: "#1BFF13"))
                                .frame(width: 270 * (loadingStart ? 1 : 0),height: 8)
                                .padding(.horizontal)
                        }
                        .frame(width: 305, height: 15)
                }
            }
            .padding()
        }
        .onAppear() {
            withAnimation(Animation.linear(duration: 2.5)) {
                loadingStart = true 
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                goToMenu = true 
            }
        }
    }
}
