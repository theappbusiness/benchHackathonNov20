//
//  AuthorizationStore.swift
//  
//
//  Created by Raynelle Francisca on 25/11/2020.
//

import Foundation

public protocol AuthorizationStoreType {

	func storeUserLoggedInStatus(_ isUserLoggedIn: Bool)
	func isUserAuthorized() -> Bool
	func clearCache()
}

public final class AuthorizationStore: AuthorizationStoreType {

	private let userLoggedInStatus = "userLoggedInStatus"

	let backingStore: UserDefaults

	public init(backingStore: UserDefaults) {
		self.backingStore = backingStore
	}

	public func storeUserLoggedInStatus(_ isUserLoggedIn: Bool) {
		backingStore.set(isUserLoggedIn, forKey: userLoggedInStatus)
	}

	public func isUserAuthorized() -> Bool {
		guard let isUserLoggedIn = backingStore.value(forKey: userLoggedInStatus) as? Bool else {
			return false
		}
		return isUserLoggedIn
	}

	public func clearCache() {
		backingStore.set(nil, forKey: userLoggedInStatus)
	}
}
