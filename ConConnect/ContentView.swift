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
    @State private var dotRadius: CGFloat = 185
    
    var body: some View {
        ZStack {
            WaitingScreenView()

            SplashScreenView(dotRadius: dotRadius)
                .opacity(splashOpacity)
                .allowsHitTesting(splashOpacity > 0)
        }
        .onAppear {
            Task {
                try? await Task.sleep(for: .seconds(3))
                withAnimation(.easeOut(duration: 1.0)) {
                    splashOpacity = 0
                    dotRadius = 600
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: ImageItem.self, inMemory: true)
}
