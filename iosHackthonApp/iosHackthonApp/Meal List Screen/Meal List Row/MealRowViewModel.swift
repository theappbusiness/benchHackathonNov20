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

    var mealWithDistance: MealWithDistance

    // MARK:- Init
    init(mealWithDistance: MealWithDistance) {
        self.mealWithDistance = mealWithDistance
    }

    // MARK:- Computed properties
    var isButtonDisabled: Bool {
        mealWithDistance.meal.quantity < 1
    }

    var isOneMealLeft: Bool {
        mealWithDistance.meal.quantity == 1
    }

    var quantityText: String {
        let portionText = isOneMealLeft ? Strings.MealListScreen.portion: Strings.MealListScreen.portions
        return "\(mealWithDistance.meal.quantity) \(portionText)"
    }

    var mealImage: String {
        mealWithDistance.meal.hot
            ? isButtonDisabled ? Strings.MealListScreen.Images.hotFoodGrey : Strings.MealListScreen.Images.hotFood
            : isButtonDisabled ? Strings.MealListScreen.Images.coldFoodGrey : Strings.MealListScreen.Images.coldFood
    }

    var textColor: Color {
        isButtonDisabled ? .gray : .black
    }

    var temperatureImageColor: Color {
        isButtonDisabled
            ? .gray : mealWithDistance.meal.hot
            ? .red : .blue
    }

    var imageColor: Color {
        isButtonDisabled ? .gray : .black
    }

    var temperatureImage: String {
        mealWithDistance.meal.hot ? Strings.Common.Images.hotFood : Strings.Common.Images.coldFood
    }

    var buttonTextColor: Color {
        isButtonDisabled ? .gray : .black
    }

    var buttonBackgroundColor: Color {
        isButtonDisabled ? Color.gray : ColorManager.appPrimary
    }

    var locationText: String {
        String(format: Strings.Common.twoDecimal, mealWithDistance.distance) + Strings.Common.km
    }

    var fromTimeText: String {
        "\(Strings.MealListScreen.available) \(Date.readableDateString(from: mealWithDistance.meal.availableFromDate))"
    }

    var expiresAtText: String {
        "\(Strings.MealListScreen.expiresAt) \(Date.readableDateString(from: mealWithDistance.meal.expiryDate))"
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
