//
//  AddMealViewModel.swift
//  iosHackthonApp
//
//  Created by Gareth Miller on 10/11/2020.
//  Copyright © 2020 orgName. All rights reserved.
//

import shared

protocol AddMealViewModelProtocol {

	var code: String { get }
    var activeAlert: ActiveAlert { get }
	var showingAlert: Bool { get }
	var sdk: MealsSDK { get }
	var locationManager: LocationManager { get }
	func postMeal(meal: Meal)
}

final class AddMealViewModel: ObservableObject {

	@Published var code = ""
	@Published var showingAlert = false
    @Published var activeAlert: ActiveAlert = .collection
	
	let sdk: MealsSDK
	let locationManager: LocationManager
	
	init(sdk: MealsSDK, locationManager: LocationManager) {
		self.sdk = sdk
		self.locationManager = locationManager
	}
}

extension AddMealViewModel: AddMealViewModelProtocol {

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
