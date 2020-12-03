//
//  MealListViewModel.swift
//  iosHackthonApp
//
//  Created by Gareth Miller on 11/11/2020.
//  Copyright © 2020 orgName. All rights reserved.
//

import shared
import MapKit
import Location
import Components
import Strings

public final class MealListViewModel: ObservableObject {

    typealias strings = Strings.MealListScreen
    typealias images = strings.Images

    let sdk: MealsSDK
    let locationManager: LocationManager

    public init(sdk: MealsSDK, locationManager: LocationManager) {
        self.sdk = sdk
        self.locationManager = locationManager
        self.loadMeals()
    }

    @Published var meals = [Meal]()
    @Published var code = ""
    @Published var showingAlert = false
    @Published var activeAlert: ActiveAlert = .unavailable
    @Published var locations = [MKPointAnnotation]()
    @Published var showMap = 0
    @Published var centerCoordinate = CLLocationCoordinate2D()
    @Published var selectedPlace: MKPointAnnotation?
    @Published var bottomSheetOpen: Bool = false
    @Published var isAddMealShowing = false

    let title = strings.title
    let bottomSheetLabel = strings.bottomSheetLabel
    let noMeals = strings.noMeals

    let sorry = Strings.Common.sorry
    let unavailableMessage = strings.UnavailableAlert.message
    let collectionMessage = strings.CollectionAlert.message
    let errorMessage = Strings.Common.ErrorAlert.loadingMessage
    let ok = Strings.Common.ok

    let reloadImage = images.reload
    let addImage = Strings.Common.Images.add

    private func getQuantityText(_ quantity: Int) -> String {
        if quantity > 1 {
            return "\(quantity) \(strings.portions)"
        } else if quantity == 1 {
            return "\(quantity) \(strings.portion)"
        }
        return "\(strings.Map.reserved)"
    }

    func loadMeals() {
        sdk.getSortedMeals(userLat: locationManager.userLatitude,
                           userLon: locationManager.userLongitude,
                           distanceUnit: DistanceUnit.km,
                           completionHandler: { meals, error in
            guard
                let meals = meals,
                error == nil else {
                self.activeAlert = .error
                self.showingAlert.toggle()
                return
            }
            self.meals = meals

            for meal in meals {
                let mapAnnotation = MKPointAnnotation()
                let location = CLLocationCoordinate2D(latitude: Double(meal.locationLat), longitude: Double(meal.locationLong))
                mapAnnotation.coordinate = location
                mapAnnotation.title = meal.name
                mapAnnotation.subtitle = self.getQuantityText(Int(meal.quantity))
                self.locations.append(mapAnnotation)
            }
        })
    }

    func patchMeal(meal: Meal) {
        sdk.getMeal(id: meal.id) { updatedMeal, error in

            guard
                let updatedMeal = updatedMeal,
                error == nil else {
                self.activeAlert = .error
                self.showingAlert.toggle()
                self.loadMeals()
                return
            }
            if updatedMeal.quantity > 0 {
                self.sdk.patchMeal(id: updatedMeal.id, quantity: updatedMeal.quantity - 1) { meal, error in
                    guard let meal = meal else {
                        self.activeAlert = .error
                        self.showingAlert.toggle()
                        self.loadMeals()
                        return
                    }
                    self.code = meal.id.last4Chars()
                    self.activeAlert = .collection
                    self.showingAlert.toggle()
                }
            } else {
                self.activeAlert = .unavailable
                self.showingAlert.toggle()
            }
            self.loadMeals()
        }
    }
}
