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

    typealias strings = Strings.MealListScreen
    typealias images = strings.Images

    // MARK:- Properties
    let spacing: CGFloat = 10.0
    let cornerRadius: CGFloat = 15.0
    let infoImage = images.info
    let locationImage = images.location
    let fromTimeImage = images.fromTime
    let expireTimeImage = images.expireTime
    let quantityImage = images.quantity

    var meal: Meal

    // MARK:- Init
    init(meal: Meal) {
        self.meal = meal
    }

    // MARK:- Computed properties
    var isButtonDisabled: Bool {
        meal.quantity < 1
    }

    var isOneMealLeft: Bool {
        meal.quantity == 1
    }

    var quantityText: String {
        let portionText = isOneMealLeft ? strings.portion: strings.portions
        return "\(meal.quantity) \(portionText)"
    }

    var mealImage: String {
        meal.hot
            ? isButtonDisabled ? images.hotFoodGrey : images.hotFood
            : isButtonDisabled ? images.coldFoodGrey : images.coldFood
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
        return distance >= 0 ? "\(distance) \(DistanceUnit.km)" : strings.Error.distanceError
    }

    var fromTimeText: String {
        "\(strings.available) \(meal.availableFromDate)"
    }

    var expiresAtText: String {
        "\(strings.expiresAt) \(meal.expiryDate)"
    }

    var buttonText: String {
        isButtonDisabled ? strings.Button.disabledText : strings.Button.enabledText
    }

    var viewShadowRadius: CGFloat {
        isButtonDisabled ? 0 : 10
    }

    var buttonShadowRadius: CGFloat {
        isButtonDisabled ? 0 : 2
    }
}
