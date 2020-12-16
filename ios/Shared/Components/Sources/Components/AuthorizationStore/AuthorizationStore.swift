//
//  AuthorizationStore.swift
//  
//
//  Created by Raynelle Francisca on 25/11/2020.
//

import Foundation
import SwiftUI

public final class AuthorizationStore: ObservableObject {
  
  @Published public var isAuthorised = false
  private let userLoggedInStatus = "userLoggedInStatus"
  private let cache: UserDefaults
  
  public init(cache: UserDefaults) {
    self.cache = cache
  }
  
  public func storeUserLoggedInStatus(_ isUserLoggedIn: Bool) {
    cache.set(isUserLoggedIn, forKey: userLoggedInStatus)
    isUserAuthorized()
  }
  
  public func isUserAuthorized() {
    if let cacheValue = cache.value(forKey: userLoggedInStatus) as? Bool {
      self.isAuthorised = cacheValue
    } else {
      self.isAuthorised = false
    }
  }
  
  public func clearCache() {
    cache.set(nil, forKey: userLoggedInStatus)
  }
}
