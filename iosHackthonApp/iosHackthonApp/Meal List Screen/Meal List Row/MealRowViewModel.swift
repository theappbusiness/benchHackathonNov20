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
    var buttonDisabled: Bool {
        mealWithDistance.meal.quantity < 1
    }

    var oneMealLeft: Bool {
        mealWithDistance.meal.quantity == 1
    }

    var quantityText: String {
        let portionText = oneMealLeft ? Strings.MealListScreen.portion: Strings.MealListScreen.portions
        return "\(mealWithDistance.meal.quantity) \(portionText)"
    }

    var mealImage: String {
        mealWithDistance.meal.hot
            ? buttonDisabled ? Strings.MealListScreen.Images.hotFoodGrey : Strings.MealListScreen.Images.hotFood
            : buttonDisabled ? Strings.MealListScreen.Images.coldFoodGrey : Strings.MealListScreen.Images.coldFood
    }

    var textColor: Color {
        buttonDisabled ? .gray : .black
    }

    var temperatureImageColor: Color {
        buttonDisabled
            ? .gray : mealWithDistance.meal.hot
            ? .red : .blue
    }

    var imageColor: Color {
        buttonDisabled ? .gray : .black
    }

    var temperatureImage: String {
        mealWithDistance.meal.hot ? Strings.Common.Images.hotFood : Strings.Common.Images.coldFood
    }

    var buttonTextColor: Color {
        buttonDisabled ? .gray : .black
    }

    var buttonBackgroundColor: Color {
        buttonDisabled ? Color.gray : Color.red
    }

    var locationText: String {
        String(format: Strings.Common.twoDecimal, mealWithDistance.distance) + Strings.Common.km
    }

    var fromTimeText: String {
        "\(Strings.MealListScreen.available) \(readableDate(from: mealWithDistance.meal.availableFromDate))"
    }

    var expiresAtText: String {
        "\(Strings.MealListScreen.expiresAt) \(readableDate(from: mealWithDistance.meal.expiryDate))"
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

    func readableDate(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Strings.Common.Date.americanFormat
        let date = dateFormatter.date(from: dateString)!

        let formatDate = DateFormatter()
        formatDate.dateFormat = Strings.Common.Date.nameDayMonth
        let drawDate = formatDate.string(from: date)
        return drawDate
    }
}
