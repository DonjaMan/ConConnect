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
    @State private var retryID = UUID()
    
    var body: some View {
        NavigationStack {
            ZStack {
                WebView(urlString: url, isLoading: $isLoading, loadError: $loadError)
                    .id(retryID)
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
                    ErrorOverlay(error: error) {
                        loadError = nil
                        isLoading = true
                        retryID = UUID()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.regularMaterial)
                    .onAppear {
                        isLoading = false
                    }
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
    
    private func makeWebView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true

        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator
        webView.scrollView.contentInsetAdjustmentBehavior = .never

        return webView
    }
    
    func makeUIView(context: Context) -> WKWebView {
        // Load happens here on creation; updateUIView is intentionally empty
        let webView = makeWebView(context: context)
        let trimmed = urlString.trimmingCharacters(in: .whitespacesAndNewlines)
        if let url = URL(string: trimmed), !trimmed.isEmpty, url.scheme != nil {
            webView.load(URLRequest(url: url))
        } else {
            loadError = "Invalid URL"
            isLoading = false
        }
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
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

// MARK: - Error Overlay

private enum WebErrorKind {
    case tls
    case network
    case other
    case noURL

    init(from description: String) {
        let noURLPatterns = [
            "invalid url",
            "unsupported url",
            "NSURLErrorUnsupportedURL",
            "NSURLErrorBadURL",
            "-1002", "-1000"
        ]
        let tlsPatterns = [
            "certificate", "SSL", "TLS",
            "kCFStreamErrorDomainSSL",
            "NSURLErrorServerCertificateUntrusted",
            "NSURLErrorSecureConnectionFailed",
            "secure connection",
            "An SSL error has occurred",
            "-1200", "-1202", "-1203", "-1204", "-1205", "-1206"
        ]
        let networkPatterns = [
            "network connection was lost",
            "not connected to the Internet",
            "timed out",
            "Could not connect to the server",
            "hostname could not be found",
            "NSURLErrorNotConnectedToInternet",
            "NSURLErrorTimedOut",
            "NSURLErrorCannotFindHost",
            "NSURLErrorCannotConnectToHost",
            "-1001", "-1003", "-1004", "-1005", "-1009"
        ]

        let lowered = description.lowercased()
        if noURLPatterns.contains(where: { lowered.contains($0.lowercased()) }) {
            self = .noURL
        } else if tlsPatterns.contains(where: { lowered.contains($0.lowercased()) }) {
            self = .tls
        } else if networkPatterns.contains(where: { lowered.contains($0.lowercased()) }) {
            self = .network
        } else {
            self = .other
        }
    }

    var icon: String {
        switch self {
        case .tls: return "lock.trianglebadge.exclamationmark"
        case .network: return "wifi.exclamationmark"
        case .other: return "exclamationmark.triangle"
        case .noURL: return "link.badge.plus"
        }
    }

    var title: String {
        switch self {
        case .tls: return "Secure Connection Failed"
        case .network: return "No Internet Connection"
        case .other: return "Unable to Load Form"
        case .noURL: return "You have not entered a valid URL"
        }
    }
    
    var guidance: String {
        switch self {
        case .tls:
            return "This network may be blocking secure connections. Try connecting to a different WiFi network, or use your phone's hotspot."
        case .network:
            return "Check that you're connected to WiFi and the signal is strong enough to load web pages."
        case .noURL:
            return "Please go to 'Settings' to enter a valid URL in the address bar."
        case .other:
            return "Something went wrong while loading the form. Please try again in a moment."
        }
    }
}

private struct ErrorOverlay: View {
    let error: String
    let onRetry: () -> Void

    private var kind: WebErrorKind { WebErrorKind(from: error) }

    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: kind.icon)
                .font(.system(size: 56))
                .foregroundStyle(.red.opacity(0.8))

            VStack(spacing: 10) {
                Text(kind.title)
                    .font(.title2.bold())

                Text(kind.guidance)
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 400)
            }

            Button(action: onRetry) {
                Label("Try Again", systemImage: "arrow.clockwise")
                    .font(.headline)
                    .padding(.horizontal, 28)
                    .padding(.vertical, 14)
            }
            .buttonStyle(.borderedProminent)
            .tint(.blue)
        }
        .padding(40)
    }
}

#Preview {
    WebFormView(url: "" /*"https://docs.google.com/forms/d/e/1FAIpQLSdb7GSbQgXbAV11_5zpa8K-67-_-dQnScb9D4IDstRHBQTlfg/viewform"*/
    )
}
