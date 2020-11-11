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

    @ObservedObject private(set) var viewModel: AddMealViewModel

    var body: some View {
        ZStack {}
        .alert(isPresented: $viewModel.showingCollectionCode) {
            Alert(
                title: Text(viewModel.code),
                message: Text(Strings.AddMealScreen.CollectionAlert.message),
                dismissButton: .default(Text(Strings.Common.ok)))
        }
        ZStack {
            VStack {
            //TODO: Pass the actual values when UI is complete
                Button("Add a meal") {
                    let meal = Meal(
                        id: "\(viewModel.sdk.getUUID())",
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
        .alert(isPresented: $viewModel.showingError) {
            Alert(
                title: Text(Strings.Common.sorry),
                message: Text(Strings.Common.ErrorAlert.message),
                dismissButton: .default(Text(Strings.Common.ok)))
        }
    }
}

struct AddMealView_Previews: PreviewProvider {
    static var previews: some View {
        AddMealView(viewModel: AddMealViewModel(sdk: MealsSDK()))
    }
}
