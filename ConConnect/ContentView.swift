//
//  ContentView.swift
//  ConConnect
//
//  Created by Donald Johnson on 4/29/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var splashOpacity: Double = 1.0

    var body: some View {
        ZStack {
            WaitingScreenView()

            SplashScreenView()
                .opacity(splashOpacity)
                .allowsHitTesting(splashOpacity > 0)
        }
        .onAppear {
            Task {
                try? await Task.sleep(for: .seconds(3))
                withAnimation(.easeOut(duration: 0.8)) {
                    splashOpacity = 0
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: ImageItem.self, inMemory: true)
}
