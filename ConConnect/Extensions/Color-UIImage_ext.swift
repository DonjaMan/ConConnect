//
//  Color-UIImage_ext.swift
//  ConConnect
//
//  Created by Donald Johnson on 5/15/26.
//

// Source - https://stackoverflow.com/a/79741594
// Posted by DonMag, modified by community. See post 'Timeline' for change history
// Retrieved 2026-05-15, License - CC BY-SA 4.0

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins
import UIKit

extension UIImage {
    func averageColor(in rect: CGRect) -> UIColor? {
        guard let cgImage = self.cgImage else { return nil }
        guard let cropped = cgImage.cropping(to: rect) else { return nil }
        
        let ciImage = CIImage(cgImage: cropped)
        let context = CIContext(options: [.workingColorSpace: kCFNull!])
        
        let filter = CIFilter.areaAverage()
        filter.inputImage = ciImage
        filter.extent = ciImage.extent
        
        guard let outputImage = filter.outputImage else { return nil }
        
        var bitmap = [UInt8](repeating: 0, count: 4)
        context.render(outputImage,
                       toBitmap: &bitmap,
                       rowBytes: 4,
                       bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
                       format: .RGBA8,
                       colorSpace: nil)
        
        return UIColor(red: CGFloat(bitmap[0]) / 255.0,
                       green: CGFloat(bitmap[1]) / 255.0,
                       blue: CGFloat(bitmap[2]) / 255.0,
                       alpha: 1.0)
    }
}

extension UIColor {
    var isLight: Bool {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let luminance = 0.299*r + 0.587*g + 0.114*b
        return luminance > 0.7
    }
    
    var contrastingTextColor: Color {
        return isLight ? .black.opacity(0.7) : .white
    }
}
extension Image {
    func asUIImage(size: CGSize) -> UIImage {
        let controller = UIHostingController(rootView:
            self
                .resizable()
                .scaledToFit()
                .frame(width: size.width, height: size.height)
        )

        let view = controller.view
        view?.bounds = CGRect(origin: .zero, size: size)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            view?.drawHierarchy(in: view!.bounds, afterScreenUpdates: true)
        }
    }
}

extension Color {
    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double(rgb & 0xFF) / 255

        self.init(red: r, green: g, blue: b)
    }

    func toHex() -> String {
        let uiColor = UIColor(self)

        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0

        uiColor.getRed(&r, green: &g, blue: &b, alpha: &a)

        let rgb = (Int(r * 255) << 16) |
                  (Int(g * 255) << 8)  |
                   Int(b * 255)

        return String(format: "#%06X", rgb)
    }
}

extension Color {
    /// Returns true if the color is visually dark
    var isDark: Bool {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0

        UIColor(self).getRed(&r, green: &g, blue: &b, alpha: &a)

        // WCAG relative luminance
        let luminance = 0.2126 * r + 0.7152 * g + 0.0722 * b
        return luminance < 0.6
    }

    /// Returns either .white or .black depending on contrast
    var contrastingTextColor: Color {
        isDark ? .white : .black
    }
}




