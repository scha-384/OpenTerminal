//
//  URL.swift
//  OpenTerminal
//
//  Created by Tomohiro Kumagai on 7/5/18.
//  Copyright © 2018 EasyStyle G.K. All rights reserved.
//

import Foundation

private let fileManager = FileManager()

extension URL {

	var pathForAppleScriptWithEscapedSpace: String {
		return "\(path.replacingOccurrences(of: " ", with: "\\\\ "))"
	}
	
	var truncatedToDirectoryName: URL {
		var isDirectory: ObjCBool = false
		var isFile: Bool { !isDirectory.boolValue }
		
		guard fileManager.fileExists(atPath: path, isDirectory: &isDirectory) else { return self }
		// Return self if the URL doesn't exist. This is an unexpected case.
		
		guard isFile else { return self }
		
		return deletingLastPathComponent()
	}
}

extension Sequence where Element == URL {
	var uniquelySet: Set<Element> { Set(self) }
}
