//
//  Settings.swift
//  OpenTerminal
//
//  Created by Tomohiro Kumagai on 7/5/18.
//  Copyright © 2018 EasyStyle G.K. All rights reserved.
//

import Foundation

let settings = Settings()

final class Settings {
	
	private let targetTerminalBundleIdentifierKey = "ESTargetTerminalBundleIdentifier"
	
	enum TargetTerminalBundleIdentifier : String {
		case appleTerminal = "com.apple.Finder"
		case iTerm2 = "com.googlecode.iterm2"
		case ghostty = "com.mitchellh.ghostty"
	}
	
	fileprivate init() {
		UserDefaults.standard.register(defaults: [
			targetTerminalBundleIdentifierKey : TargetTerminalBundleIdentifier.appleTerminal.rawValue
		])
	}
	
	var targetTerminalBundleIdentifier: TargetTerminalBundleIdentifier? {
		return UserDefaults.standard
			.string(forKey: targetTerminalBundleIdentifierKey)
			.map(TargetTerminalBundleIdentifier.init(rawValue:)) ?? nil
	}
	
	var terminal: Terminal? {
		
		switch settings.targetTerminalBundleIdentifier {
		case .appleTerminal?: AppleTerminal()
		case .iTerm2?: ITerm2()
		case .ghostty?: GhosttyTerminal()
		case nil: nil
		}
	}
}
