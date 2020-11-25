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
	let cache: UserDefaults

	public init(cache: UserDefaults) {
		self.cache = cache
	}

	public func storeUserLoggedInStatus(_ isUserLoggedIn: Bool) {
		cache.set(isUserLoggedIn, forKey: userLoggedInStatus)
	}

	public func isUserAuthorized() -> Bool {
		guard let isUserLoggedIn = cache.value(forKey: userLoggedInStatus) as? Bool else {
			return false
		}
		return isUserLoggedIn
	}

	public func clearCache() {
		cache.set(nil, forKey: userLoggedInStatus)
	}
}
