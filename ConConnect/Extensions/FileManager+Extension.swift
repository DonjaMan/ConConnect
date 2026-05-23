//
//  FileManager+Extension.swift
//  ConConnect
//
//  Created by Donald Johnson on 5/23/26.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
