//
//  AddMealViewModel.swift
//  iosHackthonApp
//
//  Created by Gareth Miller on 10/11/2020.
//  Copyright © 2020 orgName. All rights reserved.
//

import SwiftUI
import shared
import Components
import Location
import Extensions
import Theming

public final class AddMealViewModel: ObservableObject {

    let sdk: MealsSDK
    let locationManager: LocationManager

    public init(sdk: MealsSDK, locationManager: LocationManager) {
        self.sdk = sdk
        self.locationManager = locationManager
    }

    @Published var code = ""
    @Published var showingAlert = false
    @Published var activeAlert: ActiveAlert = .collection
}

extension AddMealViewModel {

    func postMeal(meal: Meal) {
        
        sdk.postMeal(meal: meal, completionHandler: { meal, error in
            guard
                let meal = meal,
                error == nil else {
                self.activeAlert = .error
                self.showingAlert.toggle()
                return
            }
            self.code = meal.id.last4Chars()
            self.activeAlert = .collection
            self.showingAlert.toggle()
        })
    }
}
