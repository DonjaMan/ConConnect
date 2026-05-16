//
//  BorderBeamEffect.swift
//  DJBorderBeam
//
//  Created by Donald Johnson on 5/4/26.
//

import SwiftUI
import SwiftData

extension View {
    @ViewBuilder
    func borderBeam(
        border: Color,
        hideFadeBorder: Bool = true,
        beam: [Color],
        beamBlur: CGFloat,
        cornerRadius: CGFloat,
        isEnabled: Bool = true
    ) -> some View {
        self
            .modifier(
                BorderBeamEffect(
                    border: border,
                    hideFadeBorder: hideFadeBorder,
                    beam: beam,
                    beamBlur: beamBlur,
                    cornerRadius: cornerRadius,
                    isEnabled: isEnabled
                )
            )
    }
}

struct BorderBeamEffect: ViewModifier {
    var border:Color
    var hideFadeBorder: Bool
    var beam: [Color]
    var beamBlur: CGFloat
    var cornerRadius: CGFloat
    var isEnabled: Bool
    func body(content: Content) -> some View {
        content
            .background {
                if isEnabled {
                    borderBeamView()
                }
            }
    }
    
    @ViewBuilder
    private func borderBeamView() -> some View {
        ZStack {
            /// Optional Faded Border
            if !hideFadeBorder {
                Capsule()
//                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(border, lineWidth: 0.5)
            }
            
            KeyframeAnimator(initialValue: 0.0, repeating: true) { value in
                let rotation = value * 360
                let borderGradient = AngularGradient(
                    colors: [.clear, border, .clear],
                    center: .center,
                    startAngle: .degrees(140 + rotation),
                    endAngle: .degrees(270 + rotation)
                )
                
                /// BEAM GRADIENT
                let beamGRadient = LinearGradient(
                    colors: beam,
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                Capsule()
//                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(beamGRadient)
                    .mask {
                        Capsule()
                            .overlay {
                                Capsule()
                                    .blur(radius: beamBlur)
                                    .blendMode(.destinationOut)
//                                RoundedRectangle(cornerRadius: cornerRadius)
//                                    .blur(radius: beamBlur)
//                                    .blendMode(.destinationOut)
                            }
                    }
                    .mask {
                        Capsule()
                            .fill(borderGradient)
//                        RoundedRectangle(cornerRadius: cornerRadius)
//                            .fill(borderGradient)
                    }
                
                /// BORDER GRADIENT
                Capsule()
                    .stroke( borderGradient,lineWidth: 1.5)
                    .blur(radius: beamBlur)
                    .padding(-beamBlur * 3)
//                RoundedRectangle(cornerRadius: cornerRadius)
//                    .stroke(borderGradient, lineWidth: 1.0)
//                    .blur(radius: beamBlur)
//                    .padding(-beamBlur * 3)
                
            } keyframes: { _ in
                LinearKeyframe(1, duration: 4.0)
            }
           
        }
        .padding(0.8)
    }
}

#Preview {
    WaitingScreenView()
        .modelContainer(for: ImageItem.self, inMemory: true)
}
