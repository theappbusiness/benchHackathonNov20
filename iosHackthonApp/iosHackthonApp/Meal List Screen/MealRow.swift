//
//  MealRow.swift
//  iosHackthonApp
//
//  Created by Gareth Miller on 10/11/2020.
//  Copyright © 2020 orgName. All rights reserved.
//

import SwiftUI
import shared
import CoreLocation

struct MealRow: View {
    var viewModel: MealListView.ViewModel
    var meal: Meal
    var locationManager = LocationManager()

    var buttonDisabled: Bool {
        meal.quantity < 1
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(.white)
                .shadow(color: .gray, radius: buttonDisabled ? 0 : 10)

            VStack {
                Spacer()
                HStack() {
                    Image(meal.hot ? "bowl" : "salad")
                        .padding()
                    VStack(alignment: .leading, spacing: 10.0) {
                        HStack {
                            Text(meal.name)
                                .font(.title)
                                .foregroundColor(buttonDisabled ? .gray : .black)
                            Spacer()
                            Image(systemName: meal.hot ? "flame" : "snow")
                                .foregroundColor(buttonDisabled ? .gray : meal.hot ? .red : .blue)
                                .padding(.trailing)
                        }
                        HStack {
                            Image(systemName: "info.circle")
                            Text(meal.info)
                        }
                        HStack {
                            Image(systemName: "mappin.and.ellipse")
                            Text(distanceFrom(meal.locationLat, meal.locationLong))
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
                    .foregroundColor(buttonDisabled ? .gray : .black)

                    Spacer()
                }

                VStack {
                    HStack {
                        Button(action: {
                            viewModel.patchMeal(meal: meal)
                        }) {
                            HStack {
                                Spacer()
                                Text(buttonDisabled ? "Unavailable" : "Reserve a portion")
                                Spacer()
                            }
                            .padding()
                            .background(buttonDisabled ? Color.gray : Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                        }
                        .disabled(buttonDisabled)
                        .shadow(radius: buttonDisabled ? 0 : 2)
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

    func distanceFrom(_ lat: Float, _ long: Float) -> String {
        let mealLocation = CLLocation(latitude: Double(lat), longitude: Double(long))
        let userLocation = CLLocation(latitude: 51.3, longitude: 0.0012)
        let distance = String(format: "%.2f", mealLocation.distance(from: userLocation)/1000)
        return "\(distance) km"
    }
}

struct MealRow_Previews: PreviewProvider {
    static var previews: some View {
        MealRow(viewModel: MealListView.ViewModel(sdk: MealsSDK()), meal: Meal(id: "1", name: "lasagne", quantity: 2, availableFromDate: "today", expiryDate: "tomorrow", info: "Italian", hot: true, locationLat: 12, locationLong: 12))
    }
}
