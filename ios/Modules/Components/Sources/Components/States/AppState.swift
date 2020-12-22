//
//  AppState.swift
//  iosHackthonApp
//
//  Created by Raynelle Francisca on 18/12/2020.
//  Copyright © 2020 orgName. All rights reserved.
//

import Foundation
import Combine

public class AppState: ObservableObject {
  public enum NavDestination{
    case home
  }
  @Published public var navDestination: NavDestination? = nil
  public init() {}
}
