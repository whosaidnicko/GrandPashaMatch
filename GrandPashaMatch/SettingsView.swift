//
//  SettingsView.swift
//  GrandPashaMatch
//
//  Created by Nicolae Chivriga on 28/11/2024.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.requestReview) var requestReview
    var body: some View {
        ZStack {
            Image("bgfut")
                .resizable()
                .ignoresSafeArea()
            VStack {
                Image("settingsb")
                    .resizable()
                    .scaledToFit()
                    .overlay {
                        VStack {
                            Button {
                                requestReview()
                            } label: {
                                Image("whiteb")
                                    .overlay {
                                        Text("Rate")
                                            .font(.custom(lucki, size: 18))
                                            .foregroundStyle(.black)
                                    }
                            }
                            
                            Button {
                                if let url = URL(string: "mailto:vjeannektihre20099@gmail.com") {
                                    if UIApplication.shared.canOpenURL(url) {
                                        UIApplication.shared.open(url)
                                    }
                                }
                            } label: {
                                Image("whiteb")
                                    .overlay {
                                        Text("Contact")
                                            .font(.custom(lucki, size: 18))
                                            .foregroundStyle(.black)
                                    }
                            }
                        }
                        .offset(y: -50)
                    }
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
