//
//  DotRingView.swift
//  ConConnect
//
//  Created by Donald Johnson on 5/14/26.
//

import SwiftUI

struct RotatingDotRing<Content: View>: View {
    let dotCount: Int
    let radius: CGFloat
    let dotSize: CGFloat
    let dotColor: Color
    let content: Content

    @State private var rotation: Double = 0

    init(
        dotCount: Int = 24,
        radius: CGFloat = 60,
        dotSize: CGFloat = 6,
        dotColor: Color = .blue,
        @ViewBuilder content: () -> Content
    ) {
        self.dotCount = dotCount
        self.radius = radius
        self.dotSize = dotSize
        self.dotColor = dotColor
        self.content = content()
    }

    var body: some View {
        ZStack {
            ZStack {
                ForEach(0..<dotCount, id: \.self) { index in
                    Circle()
                        .fill(dotColor)
                        .frame(width: dotSize, height: dotSize)
                        .offset(y: -radius)
                        .rotationEffect(.degrees(Double(index) / Double(dotCount) * 360))
                }
            }
            .rotationEffect(.degrees(rotation))
            .onAppear {
                withAnimation(.linear(duration: 10).repeatForever(autoreverses: false)) {
                    rotation = 360
                }
            }

            content
        }
    }
}


#Preview {
    TestView()
}

struct TestView: View {
    var body: some View {
        RotatingDotRing(
            dotCount: 32,
            radius: 185,
            dotSize: 15,
            dotColor: .gray) {
                Image(.CC_3)
                    .resizable()
                    .frame(width: 250, height: 250)
            }
    }
}
