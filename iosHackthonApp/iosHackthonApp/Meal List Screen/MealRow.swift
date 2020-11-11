//
//  MealRow.swift
//  iosHackthonApp
//
//  Created by Gareth Miller on 10/11/2020.
//  Copyright © 2020 orgName. All rights reserved.
//

import SwiftUI
import shared

struct MealRow: View {
    var viewModel: MealListView.ViewModel
    var meal: Meal

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(.white)
                .shadow(color: .gray, radius: 10)

            VStack {
                Spacer()
                HStack() {
                    Image(meal.hot ? "bowl" : "salad")
                        .padding()
                    VStack(alignment: .leading, spacing: 10.0) {
                        HStack {
                            Text(meal.name)
                                .font(.title)
                                .foregroundColor(.black)
                            Spacer()
                            Image(systemName: meal.hot ? "flame" : "snow")
                                .foregroundColor(meal.hot ? .red : .blue)
                                .padding(.trailing)
                        }
                        HStack {
                            Image(systemName: "info.circle")
                            Text(meal.info)
                        }
                        HStack {
                            Image(systemName: "mappin.and.ellipse")
                            Text("2.2km away")
                            // Use user location and meal location to get distance
                        }
                        HStack {
                            Image(systemName: "clock")
                            Text("Available: \(meal.availableFromDate)")
                        }
                        HStack {
                            Image(systemName: "hourglass")
                            Text(" Expires: \(meal.expiryDate)")
                        }

                        HStack {
                            Image(systemName: "number")
                            Text("\(meal.quantity) portions remaining")
                        }
                    }
                    .foregroundColor(.gray)

                    Spacer()
                }

                VStack {
                    HStack {
                        Button(action: {
                            viewModel.patchMeal(meal: meal)
                        }) {
                            HStack {
                                Spacer()
                                Text("Reserve a portion")
                                Spacer()
                            }
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                        }
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
        MealRow(viewModel: MealListView.ViewModel(sdk: MealsSDK()), meal: Meal(id: "1", name: "lasagne", quantity: 2, availableFromDate: "today", expiryDate: "tomorrow", info: "Italian", hot: true, locationLat: 12, locationLong: 12))
    }
}
