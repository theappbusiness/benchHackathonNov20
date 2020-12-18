//
//  AppState.swift
//  iosHackthonApp
//
//  Created by Raynelle Francisca on 18/12/2020.
//  Copyright © 2020 orgName. All rights reserved.
//

import Foundation
import Combine

class AppState: ObservableObject {
  @Published var moveToHome: Bool = false
}
