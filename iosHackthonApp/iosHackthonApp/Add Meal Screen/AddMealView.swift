//
//  AddMealView.swift
//  iosHackthonApp
//
//  Created by Gareth Miller on 09/11/2020.
//  Copyright © 2020 orgName. All rights reserved.
//

import SwiftUI
import shared
import CoreLocation

struct AddMealView: View {

	@ObservedObject private(set) var viewModel: ViewModel
	@State var title: String = ""
	@State var additionalInfo: String = ""
	@State var quantity: String = ""
	@State var hot: Bool = false
	@State var availableFromDate = Date()
	@State var useByDate = Date()
	@State var address: String = ""

	var body: some View {

		ScrollView {
			VStack(alignment: .leading, spacing: 10) {

				Group {
					Text(Strings.AddMealScreen.title)
					TextField("", text: $title)
						.modifier(TextFieldModifier())
					Text(Strings.AddMealScreen.additionalInfo)
					TextField("", text: $additionalInfo)
						.modifier(TextFieldModifier())
					Text(Strings.AddMealScreen.quantity)
					TextField("", text: $quantity)
						.modifier(TextFieldModifier())
					Text(Strings.AddMealScreen.temperature)
					HStack {
						Button(Strings.AddMealScreen.hot, action: {
							hot = true
						})
						Button(Strings.AddMealScreen.cold, action: {
							hot = false
						})
					}
				}

				Spacer()
				Group {
					DatePicker(Strings.AddMealScreen.availableFrom, selection: $availableFromDate, in: Date()..., displayedComponents: .date)
					DatePicker(Strings.AddMealScreen.useBy, selection: $useByDate, in: Date()..., displayedComponents: .date)
				}


				Spacer()
				Group {
					Text(Strings.AddMealScreen.address)
					HStack {
						TextField("", text: $address)
							.keyboardType(.numberPad)
							.modifier(TextFieldModifier())
						Spacer()
						Spacer()
						Button(action: {
							print("location button tapped!")
						}) {
							Image(systemName: "location")
								.font(.title)
								.foregroundColor(.green)
						}
					}
				}

				Spacer()
				//TODO: Pass the actual values when UI is complete
				Button(Strings.AddMealScreen.addMeal) {
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
				.foregroundColor(.white)
				.padding(10)
				.frame(minWidth: 0, maxWidth: .infinity)
				.background(Color.red)
				.cornerRadius(10)

			}.padding()

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


