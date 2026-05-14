//
//  SplashScreenView.swift
//  ConConnect
//
//  Created by Donald Johnson on 5/14/26.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        ZStack {
            Color.white
            Image("CC3")
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
            ProgressView {
                Text("Loading...")
            }
            .tint(.black)
            .offset(x: 15, y: 150)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SplashScreenView()
}
