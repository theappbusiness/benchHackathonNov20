//
//  MealRow.swift
//  iosHackthonApp
//
//  Created by Gareth Miller on 10/11/2020.
//  Copyright © 2020 orgName. All rights reserved.
//

import SwiftUI
import shared
import Strings
import Location

struct MealRow: View {
    var listViewModel: MealListViewModel
    var rowViewModel: MealRowViewModel

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: rowViewModel.cornerRadius)
                .foregroundColor(.white)
                .shadow(color: .gray, radius: rowViewModel.viewShadowRadius)

            VStack {
                Spacer()
                HStack() {
                    Image(rowViewModel.mealImage)
                        .padding()
                    VStack(alignment: .leading, spacing: rowViewModel.spacing) {
                        HStack {
                            Text(rowViewModel.mealWithDistance.meal.name)
                                .font(.title)
                                .foregroundColor(rowViewModel.textColor)
                            Spacer()
                            Image(systemName: rowViewModel.temperatureImage)
                                .foregroundColor(rowViewModel.temperatureImageColor)
                                .padding(.trailing)
                        }
                        HStack {
                            Image(systemName: Strings.MealListScreen.Images.info)
                            Text(rowViewModel.mealWithDistance.meal.info)
                        }
                        HStack {
                            Image(systemName: Strings.MealListScreen.Images.location)
                            Text(rowViewModel.locationText)
                        }
                        HStack {
                            Image(systemName: Strings.MealListScreen.Images.fromTime)
                            Text(rowViewModel.fromTimeText)
                        }
                        HStack {
                            Image(systemName: Strings.MealListScreen.Images.expireTime)
                            Text(rowViewModel.expiresAtText)
                        }
                        HStack {
                            Image(systemName: Strings.MealListScreen.Images.quantity)
                            Text(rowViewModel.quantityText)
                        }
                    }
                    .foregroundColor(rowViewModel.textColor)

                    Spacer()
                }

                VStack {
                    HStack {
                        Button(action: {
                            listViewModel.patchMeal(meal: rowViewModel.mealWithDistance.meal)
                        }) {
                            HStack {
                                Spacer()
                                Text(rowViewModel.buttonText)
                                Spacer()
                            }
                            .padding()
                            .background(rowViewModel.buttonBackgroundColor)
                            .foregroundColor(.white)
                            .cornerRadius(rowViewModel.cornerRadius)
                        }
                        .disabled(rowViewModel.isButtonDisabled)
                        .shadow(radius: rowViewModel.buttonShadowRadius)
                    }
                    .padding(.leading)
                    .padding(.trailing)
                }
                .padding(.top)
            }
            .padding(.bottom)
            .padding(.top)
            Spacer()
        }
    }
}

struct MealRow_Previews: PreviewProvider {
    static var previews: some View {
        MealRow(listViewModel: MealListViewModel(sdk: MealsSDK(), locationManager: LocationManager()), rowViewModel: MealRowViewModel(mealWithDistance: MealWithDistance(meal: Meal(id: "1", name: "lasagne", quantity: 2, availableFromDate: "today", expiryDate: "tomorrow", info: "Italian", hot: true, locationLat: 12, locationLong: 12), distance: 12)))
    }
}
