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
	@State var quantity: Int = 0
	@State var hot: Bool = false
	@State var availableFromDate = Date()
	@State var useByDate = Date()
	@State var address: String = ""
	@State var latitude: Float = 0
	@State var longitude: Float = 0

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
					TextField("", value: $quantity, formatter: NumberFormatter())
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
							self.address = "\(self.viewModel.locationManager.address)"
							self.latitude = Float(self.viewModel.locationManager.userLatitude)
							self.longitude = Float(self.viewModel.locationManager.userLongitude)
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
						name: "\(self.title)",
						quantity: Int32(self.quantity),
						availableFromDate: "\(self.availableFromDate)",
						expiryDate: "\(self.useByDate)",
						info: "\(self.additionalInfo)",
						hot: self.hot,
						locationLat: self.latitude,
						locationLong:  self.longitude)
					self.viewModel.postMeal(meal: meal)
				}
				.modifier(ButtonViewModifier())

			}.padding()

		}
		.navigationBarTitle(Strings.AddMealScreen.addMeal)
	}
}

extension AddMealView {
	class ViewModel: ObservableObject {

		let sdk: MealsSDK
		let locationManager : LocationManager

		init(sdk: MealsSDK, locationManager: LocationManager) {
			self.sdk = sdk
			self.locationManager = locationManager
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
		AddMealView(viewModel: AddMealView.ViewModel(sdk: MealsSDK(), locationManager: LocationManager()))
	}
}


