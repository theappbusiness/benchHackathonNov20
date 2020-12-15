//
//  MealRowViewModel.swift
//  iosHackthonApp
//
//  Created by Gareth Miller on 11/11/2020.
//  Copyright © 2020 orgName. All rights reserved.
//

import SwiftUI
import shared
import Strings
import Theming
import Extensions

final class MealRowViewModel: ObservableObject {

    // MARK: - Properties
    let spacing: CGFloat = 10.0
    let cornerRadius: CGFloat = 15.0

    var meal: Meal

    // MARK: - Init
    init(meal: Meal) {
        self.meal = meal
    }

    // MARK: - Computed properties
    var isButtonDisabled: Bool {
        meal.quantity < 1
    }

    var isOneMealLeft: Bool {
        meal.quantity == 1
    }

    var quantityText: String {
        let portionText = isOneMealLeft ? Strings.MealListScreen.portion: Strings.MealListScreen.portions
        return "\(meal.quantity) \(portionText)"
    }

    var mealImage: String {
        meal.hot
            ? isButtonDisabled ? Strings.MealListScreen.Images.hotFoodGrey : Strings.MealListScreen.Images.hotFood
            : isButtonDisabled ? Strings.MealListScreen.Images.coldFoodGrey : Strings.MealListScreen.Images.coldFood
    }

    var textColor: Color {
        isButtonDisabled ? .gray : .black
    }

    var temperatureImageColor: Color {
        isButtonDisabled
            ? .gray : meal.hot
            ? .red : .blue
    }

    var imageColor: Color {
        isButtonDisabled ? .gray : .black
    }

    var temperatureImage: String {
        meal.hot ? Strings.Common.Images.hotFood : Strings.Common.Images.coldFood
    }

    var buttonTextColor: Color {
        isButtonDisabled ? .gray : .black
    }

    var buttonBackgroundColor: Color {
        isButtonDisabled ? Color.gray : ColorManager.appPrimary
    }

    var locationText: String {
        let distance = Double(meal.distance ?? -1)
        return distance >= 0 ? "\(distance) \(DistanceUnit.km)" : Strings.MealListScreen.Error.distanceError
    }

    var fromTimeText: String {
        "\(Strings.MealListScreen.available) \(meal.availableFromDate)"
    }

    var expiresAtText: String {
        "\(Strings.MealListScreen.expiresAt) \(meal.expiryDate)"
    }

    var buttonText: String {
        isButtonDisabled ? Strings.MealListScreen.Button.disabledText : Strings.MealListScreen.Button.enabledText
    }

    var viewShadowRadius: CGFloat {
        isButtonDisabled ? 0 : 10
    }

    var buttonShadowRadius: CGFloat {
        isButtonDisabled ? 0 : 2
    }
}
