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
    @Published var title: String = ""
    @Published var additionalInfo: String = ""
    @Published var quantity: Int = 0
    @Published var availableFromDate = Date()
    @Published var useByDate = Date()
    @Published var address: String = ""
    @Published var latitude: Float = 0
    @Published var longitude: Float = 0
    @Published var isHot: Bool = true

    var buttonIsDisabled: Bool {
        title.isEmpty || additionalInfo.isEmpty || address.isEmpty || quantity == 0
    }

    var hotFoodColor: Color {
        isHot ? ColorManager.red : ColorManager.gray
    }

    var coldFoodColor: Color {
        isHot ? ColorManager.gray : ColorManager.blue
    }

    var buttonColor: Color {
        buttonIsDisabled ? ColorManager.gray : ColorManager.appPrimary
    }
}

extension AddMealViewModel {

    func createMeal() -> Meal {

        Meal(id: "\(sdk.getUUID())",
            name: "\(title)",
            quantity: Int32(quantity),
            availableFromDate: "\(availableFromDate)",
            expiryDate: "\(useByDate)",
            info: "\(additionalInfo)",
            hot: isHot,
            locationLat: latitude,
            locationLong:  longitude)
    }

    func postMeal() {
        
        sdk.postMeal(meal: createMeal(), completionHandler: { meal, error in
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
