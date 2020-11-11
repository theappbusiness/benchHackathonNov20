//
//  MealRowViewModel.swift
//  iosHackthonApp
//
//  Created by Gareth Miller on 11/11/2020.
//  Copyright © 2020 orgName. All rights reserved.
//

import SwiftUI
import shared

final class MealRowViewModel: ObservableObject {

    // MARK:- Properties
    let spacing: CGFloat = 10.0
    let cornerRadius: CGFloat = 15.0

    var mealDistanceTuple: (meal: Meal, distance: Double)

    // MARK:- Init
    init(mealDistanceTuple: (meal: Meal, distance: Double)) {
        self.mealDistanceTuple = mealDistanceTuple
    }

    // MARK:- Computed properties
    var buttonDisabled: Bool {
        mealDistanceTuple.meal.quantity < 1
    }

    var oneMealLeft: Bool {
        mealDistanceTuple.meal.quantity == 1
    }

    var quantityText: String {
        let portionText = oneMealLeft ? Strings.MealListScreen.portion: Strings.MealListScreen.portions
        return "\(mealDistanceTuple.meal.quantity) \(portionText)"
    }

    var mealImage: String {
        mealDistanceTuple.meal.hot
            ? Strings.MealListScreen.Images.hotFood
            : Strings.MealListScreen.Images.coldFood
    }

    var textColor: Color {
        buttonDisabled ? .gray : .black
    }

    var imageColor: Color {
        buttonDisabled
            ? .gray : mealDistanceTuple.meal.hot
            ? .red : .blue
    }

    var temperatureImage: String {
        mealDistanceTuple.meal.hot ? Strings.Common.Images.hotFood : Strings.Common.Images.coldFood
    }

    var buttonTextColor: Color {
        buttonDisabled ? .gray : .black
    }

    var buttonBackgroundColor: Color {
        buttonDisabled ? Color.gray : Color.red
    }

    var locationText: String {
        String(format: Strings.Common.twoDecimal, mealDistanceTuple.distance) + Strings.Common.km
    }

    var fromTimeText: String {
        "\(Strings.MealListScreen.available) \(mealDistanceTuple.meal.availableFromDate)"
    }

    var expiresAtText: String {
        "\(Strings.MealListScreen.expiresAt) \(mealDistanceTuple.meal.expiryDate)"
    }

    var buttonText: String {
        buttonDisabled ? Strings.MealListScreen.Button.disabledText : Strings.MealListScreen.Button.enabledText
    }

    var viewShadowRadius: CGFloat {
        buttonDisabled ? 0 : 10
    }

    var buttonShadowRadius: CGFloat {
        buttonDisabled ? 0 : 2
    }
}
