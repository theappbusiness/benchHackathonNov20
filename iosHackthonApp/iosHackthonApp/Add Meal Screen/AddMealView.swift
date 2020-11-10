//
//  AddMealView.swift
//  iosHackthonApp
//
//  Created by Gareth Miller on 09/11/2020.
//  Copyright © 2020 orgName. All rights reserved.
//

import SwiftUI
import shared

struct AddMealView: View {

    @ObservedObject private(set) var viewModel: ViewModel

    var body: some View {
        //TODO: Pass the actual values when UI is complete
        Button("Add a meal") {
            let meal = Meal(
                id: "\(self.viewModel.sdk.getUUID())",
                name: "Pizza",
                quantity: 2,
                availableFromDate: "Tuesday",
                expiryDate: "Saturday",
                info: "Meat",
                hot: false,
                locationLat: 51.509865,
                locationLong:  -0.118092)
            self.viewModel.postMeal(meal: meal)
        }
    }
}

extension AddMealView {
    class ViewModel: ObservableObject {

        let sdk: MealsSDK

        init(sdk: MealsSDK) {
            self.sdk = sdk
        }

        func postMeal(meal: Meal) {
            sdk.postMeal(meal: meal, completionHandler: { response, test in
                print("Response \(response)")
            })
        }
    }
}

struct AddMealView_Previews: PreviewProvider {
    static var previews: some View {
        AddMealView(viewModel: AddMealView.ViewModel(sdk: MealsSDK()))
    }
}
