//
//  AddMealViewModel.swift
//  iosHackthonApp
//
//  Created by Gareth Miller on 10/11/2020.
//  Copyright © 2020 orgName. All rights reserved.
//

import Foundation
import shared

protocol AddMealViewModelProtocol {
    var code: String { get }
    var showingCollectionCode: Bool { get }
    var showingError: Bool { get }
    var sdk: MealsSDK { get }
    func postMeal(meal: Meal)
}

final class AddMealViewModel: ObservableObject {

    @Published var code = ""
    @Published var showingCollectionCode = false
    @Published var showingError = false

    let sdk: MealsSDK

    init(sdk: MealsSDK) {
        self.sdk = sdk
    }
}

extension AddMealViewModel: AddMealViewModelProtocol {

    func postMeal(meal: Meal) {
        sdk.postMeal(meal: meal, completionHandler: { response, error in
            if error == nil {
                if let code = response?.id.last4Chars() {
                    self.code = code
                }
                self.showingCollectionCode.toggle()
            } else {
                self.showingError.toggle()
            }
        })
    }
}
