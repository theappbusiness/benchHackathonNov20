//
//  AddMealViewModel.swift
//  iosHackthonApp
//
//  Created by Gareth Miller on 10/11/2020.
//  Copyright © 2020 orgName. All rights reserved.
//

import shared
import Components
import Location
import Extensions

public protocol AddMealViewModelProtocol {

	var code: String { get }
    var activeAlert: ActiveAlert { get }
	var showingAlert: Bool { get }
	var sdk: MealsSDK { get }
	var locationManager: LocationManager { get }
	func postMeal(meal: Meal)
}

public final class AddMealViewModel: ObservableObject {

	@Published public var code = ""
	@Published public var showingAlert = false
    @Published public var activeAlert: ActiveAlert = .collection
	
    public let sdk: MealsSDK
    public let locationManager: LocationManager
	
	public init(sdk: MealsSDK, locationManager: LocationManager) {
		self.sdk = sdk
		self.locationManager = locationManager
	}
}

extension AddMealViewModel: AddMealViewModelProtocol {

    public func postMeal(meal: Meal) {
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
