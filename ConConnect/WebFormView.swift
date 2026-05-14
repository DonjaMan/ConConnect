//
//  WebFormView.swift
//  ConConnect
//
//  Created by Donald Johnson on 4/29/26.
//

import SwiftUI
import WebKit

struct WebFormView: View {
    let url: String
    @Environment(\.dismiss) private var dismiss
    @State private var isLoading = true
    @State private var loadError: String?
    
    var body: some View {
        NavigationStack {
            ZStack {
                WebView(urlString: url, isLoading: $isLoading, loadError: $loadError)
                    .ignoresSafeArea(edges: .bottom)
                
                if isLoading {
                    VStack(spacing: 20) {
                        ProgressView()
                            .scaleEffect(1.5)
                        Text("Loading form...")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.regularMaterial)
                }
                
                if let error = loadError {
                    VStack(spacing: 20) {
                        Image(systemName: "wifi.exclamationmark")
                            .font(.system(size: 60))
                            .foregroundStyle(.red)
                        
                        Text("Unable to Load Form")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text(error)
                            .font(.body)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        
                        Button("Try Again") {
                            loadError = nil
                            isLoading = true
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.regularMaterial)
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text(AppConfiguration.formTitle)
                        .font(.headline)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct WebView: UIViewRepresentable {
    let urlString: String
    @Binding var isLoading: Bool
    @Binding var loadError: String?
    
    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        // Only load if we haven't loaded before or if we're retrying after an error
        if webView.url == nil || loadError != nil {
            if let url = URL(string: urlString) {
                let request = URLRequest(url: url)
                webView.load(request)
            } else {
                loadError = "Invalid URL"
                isLoading = false
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(isLoading: $isLoading, loadError: $loadError)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        @Binding var isLoading: Bool
        @Binding var loadError: String?
        
        init(isLoading: Binding<Bool>, loadError: Binding<String?>) {
            _isLoading = isLoading
            _loadError = loadError
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            isLoading = true
            loadError = nil
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            isLoading = false
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            isLoading = false
            loadError = error.localizedDescription
        }
        
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            isLoading = false
            loadError = error.localizedDescription
        }
    }
}

#Preview {
    WebFormView(url: "https://docs.google.com/forms/d/e/1FAIpQLSdb7GSbQgXbAV11_5zpa8K-67-_-dQnScb9D4IDstRHBQTlfg/viewform")
}
