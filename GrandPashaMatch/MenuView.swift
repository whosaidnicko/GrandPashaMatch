//
//  MenuView.swift
//  GrandPashaMatch
//
//  Created by Nicolae Chivriga on 28/11/2024.
//

import SwiftUI


struct MenuView: View {
    var body: some View {
        ZStack {
            Image("bgfut")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Image("kislorod")
                
                VStack {
                    NavigationLink {
                        FutbollGameView()
                    } label: {
                        Image("playi")
                    }
                    
                    HStack(spacing: 40) {
                        NavigationLink {
                            InView()
                        } label: {
                            Image("inoepf")
                        }
                        
                        NavigationLink {
                            SettingsView()
                        } label: {
                            Image("setign")
                        }
                        
                        
                    }
                }
                .padding(.top, 70)
                Spacer()
                
               
            }
            .padding()
            
        }
        .navigationBarBackButtonHidden()
    }
}
