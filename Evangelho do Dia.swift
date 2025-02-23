//
//  Evangelho do Dia.swift
//  EvangelhodoDia
//
//  Created by Bianca Cordeiro on 14/01/25.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let htmlContent: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.loadHTMLString(htmlContent, baseURL: nil)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlContent, baseURL: nil)
    }
}

struct EvangelhoView: View { // Corrigido o nome da estrutura
    var body: some View {
        VStack(spacing: 20) {
            // Adicionando imagem ao layout

            // Texto de boas-vindas
            Text("Evangelho")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()

            // WebView com o iframe e links (API Evangelho)
            WebView(htmlContent: """
                <iframe frameborder='0' width='100%' height='100%' src='https://evangeli.net/evangelho/widget/web'></iframe>
            """)
            .frame(maxHeight: .infinity)
        }
        .padding()
    }
}
