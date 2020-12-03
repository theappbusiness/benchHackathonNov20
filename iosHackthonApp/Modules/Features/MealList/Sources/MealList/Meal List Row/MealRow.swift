//
//  MealRow.swift
//  iosHackthonApp
//
//  Created by Gareth Miller on 10/11/2020.
//  Copyright © 2020 orgName. All rights reserved.
//

import SwiftUI
import shared
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
                            Text(rowViewModel.meal.name)
                                .font(.title)
                                .foregroundColor(rowViewModel.textColor)
                            Spacer()
                            Image(systemName: rowViewModel.temperatureImage)
                                .foregroundColor(rowViewModel.temperatureImageColor)
                                .padding(.trailing)
                        }
                        HStack {
                            Image(systemName: rowViewModel.infoImage)
                            Text(rowViewModel.meal.info)
                        }
                        HStack {
                            Image(systemName: rowViewModel.locationImage)
                            Text(rowViewModel.locationText)
                        }
                        HStack {
                            Image(systemName: rowViewModel.fromTimeImage)
                            Text(rowViewModel.fromTimeText)
                        }
                        HStack {
                            Image(systemName: rowViewModel.expireTimeImage)
                            Text(rowViewModel.expiresAtText)
                        }
                        HStack {
                            Image(systemName: rowViewModel.quantityImage)
                            Text(rowViewModel.quantityText)
                        }
                    }
                    .foregroundColor(rowViewModel.textColor)

                    Spacer()
                }

                VStack {
                    HStack {
                        Button(action: {
                            listViewModel.patchMeal(meal: rowViewModel.meal)
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
        MealRow(listViewModel: MealListViewModel(sdk: MealsSDK(), locationManager: LocationManager()), rowViewModel: MealRowViewModel(meal: Meal(id: "1", name: "lasagne", quantity: 2, availableFromDate: "today", expiryDate: "tomorrow", info: "Italian", hot: true, locationLat: 12, locationLong: 12, distance: 12)))
    }
}
