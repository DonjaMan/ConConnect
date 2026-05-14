//
//  ImageItem.swift
//  ConConnect
//
//  Created by Donald Johnson on 4/29/26.
//

import Foundation
import SwiftData

/// SwiftData model for storing user-added images
@Model
final class ImageItem {
    var id: UUID
    var imageData: Data
    var dateAdded: Date
    var orderIndex: Int
    
    init(imageData: Data, orderIndex: Int = 0) {
        self.id = UUID()
        self.imageData = imageData
        self.dateAdded = Date()
        self.orderIndex = orderIndex
    }
}
