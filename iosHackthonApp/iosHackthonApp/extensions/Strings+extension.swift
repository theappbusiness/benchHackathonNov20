//
//  Strings+extension.swift
//  iosHackthonApp
//
//  Created by Gareth Miller on 10/11/2020.
//  Copyright © 2020 orgName. All rights reserved.
//

import Foundation

extension String {

    func last4Chars() -> Self {
        return self.suffix(4).uppercased()
    }
}
