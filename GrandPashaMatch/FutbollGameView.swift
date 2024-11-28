//
//  FutbollGameView.swift
//  GrandPashaMatch
//
//  Created by Nicolae Chivriga on 28/11/2024.
//

import SwiftUI

struct FutbollGameView: View {
    @Environment(\.dismiss) var dismiss
    @State var showGame: Bool = false
    @State var loadStart: Bool = false
    var body: some View {
        ZStack {
            Image("bgGame")
                .resizable()
                .ignoresSafeArea()
            
            
            Image("containerGame")
                .resizable()
//                .frame(width: 300, height: UIScreen.main.bounds.height * 0.78)
                .overlay {
                    WKWebViewRepresentable(url: URL(string: "https://plays.org/game/football-field/")!, onLoadCompletion: {
                        withAnimation {
                            showGame = true
                        }
                    })
                    .opacity(showGame ? 1 : 0)
                    .mask {
                        Rectangle()
                            .frame(width: UIScreen.main.bounds.height > 680 ? UIScreen.main.bounds.width : UIScreen.main.bounds.width * 0.90,height: UIScreen.main.bounds.height > 680 ?  UIScreen.main.bounds.height * 0.80 : UIScreen.main.bounds.height * 0.89)
                            
                    }
//                    .padding()
                    
                    Image("celik")
                        .scaleEffect(loadStart ? 0.8 : 0.6)
                        .opacity(!showGame ? 1 : 0)
                }
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: Image("bk")
            .resizable()
            .frame(width: 35, height: 35)
            .onTapGesture {
                dismiss()
            })
        .onAppear() {
            withAnimation(Animation.linear(duration: 2).repeatForever()) {
                loadStart = true 
            }
        }
    }
}
import WebKit
struct WKWebViewRepresentable: UIViewRepresentable {

   typealias UIViewType = WKWebView
   var url: URL
   var webView: WKWebView
   var onLoadCompletion: (() -> Void)?

   init(url: URL, webView: WKWebView = WKWebView(), onLoadCompletion: (() -> Void)? = nil) {
       self.url = url
       
       self.webView = webView
       self.webView.layer.opacity = 0
       self.onLoadCompletion = onLoadCompletion
   }

   func makeUIView(context: Context) -> WKWebView {
       webView.uiDelegate = context.coordinator
       webView.navigationDelegate = context.coordinator
       return webView
   }

   func updateUIView(_ uiView: UIViewType, context: Context) {
       let request = URLRequest(url: url)
       uiView.load(request)
       uiView.scrollView.isScrollEnabled = true
       uiView.scrollView.bounces = true
   }

   func makeCoordinator() -> Coordinator {
       Coordinator(self)
   }
}

extension WKWebViewRepresentable {

   final class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate {
       var parent: WKWebViewRepresentable
       private var webViews: [WKWebView]

       init(_ parent: WKWebViewRepresentable) {
           self.parent = parent
           
           self.webViews = []
       }

       func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
       
           if navigationAction.targetFrame == nil {
               let popupWebView = WKWebView(frame: .zero, configuration: configuration)
               popupWebView.navigationDelegate = self
               popupWebView.uiDelegate = self

               parent.webView.addSubview(popupWebView)
               popupWebView.translatesAutoresizingMaskIntoConstraints = false
               NSLayoutConstraint.activate([
                   popupWebView.topAnchor.constraint(equalTo: parent.webView.topAnchor),
                   popupWebView.bottomAnchor.constraint(equalTo: parent.webView.bottomAnchor),
                   popupWebView.leadingAnchor.constraint(equalTo: parent.webView.leadingAnchor),
                   popupWebView.trailingAnchor.constraint(equalTo: parent.webView.trailingAnchor)
               ])

               self.webViews.append(popupWebView)
               return popupWebView
           }
           return nil
       }

       func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
           // Notify when page loading has finished
           parent.onLoadCompletion?()
           webView.layer.opacity = 1
       }

       func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
           decisionHandler(.allow)
       }
   }

   func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
       return .all
   }
}
