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
        ZStack {}
        .alert(isPresented: $viewModel.showingCollectionCode) {
            Alert(
                title: Text("Collection Code"),
                message: Text("When someone arrives to collect this meal they will quote this code:\n \(viewModel.code)\nPlease make a note of it"),
                dismissButton: .default(Text("Ok")))
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
                title: Text("Sorry!"),
                message: Text("There was an error creating your meal.\n please try again"),
                dismissButton: .default(Text("Ok")))
        }
    }
}

extension AddMealView {
    class ViewModel: ObservableObject {

        @Published var code = ""
        @Published var showingCollectionCode = false
        @Published var showingError = false

        let sdk: MealsSDK

        init(sdk: MealsSDK) {
            self.sdk = sdk
        }

        func postMeal(meal: Meal) {
            sdk.postMeal(meal: meal, completionHandler: { response, error in
                if error == nil {
                    self.code = response?.id.suffix(4).uppercased() ?? ""
                    self.showingCollectionCode.toggle()
                } else {
                    self.showingError.toggle()
                }
            })
        }
    }
}

struct AddMealView_Previews: PreviewProvider {
    static var previews: some View {
        AddMealView(viewModel: AddMealView.ViewModel(sdk: MealsSDK()))
    }
}
