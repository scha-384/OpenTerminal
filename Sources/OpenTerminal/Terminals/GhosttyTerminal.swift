//
//  AppleTerminal.swift
//  OpenTerminal
//
//  Created by Tomohiro Kumagai on 7/5/18.
//  Copyright © 2018 EasyStyle G.K. All rights reserved.
//

import Foundation

final class GhosttyTerminal : Terminal {
	func open(url: URL) throws {
		let task = Process()
		
		task.launchPath = "/usr/bin/open"
		
		let args: [String] = ["-a", "Ghostty", "--url", url.absoluteString]
		
		task.arguments = args
		
		let errorPipe = Pipe()
		task.standardError = errorPipe
		task.launch()
		task.waitUntilExit()
		
		let errorData = errorPipe.fileHandleForReading.readDataToEndOfFile()
		let error = String(decoding: errorData, as: UTF8.self)
		
		if !error.isEmpty {
			print("error: \(error)")
		}
	}
}
