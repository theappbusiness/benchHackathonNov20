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
  @Published public var moveToHome: Bool = false

  public init() {}
}
