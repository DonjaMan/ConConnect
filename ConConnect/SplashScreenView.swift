//
//  SplashScreenView.swift
//  ConConnect
//
//  Created by Donald Johnson on 5/14/26.
//

import SwiftUI

struct SplashScreenView: View {
    var dotRadius: CGFloat
    var body: some View {
        ZStack {
            Color.white
            RotatingDotRing(
                dotCount: 32,
                radius: dotRadius,
                dotSize: 15,
                dotColor: .gray) {
                    Image(.CC_3)
                        .resizable()
                        .frame(width: 250, height: 250)
                }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SplashScreenView(dotRadius: 185)
}
