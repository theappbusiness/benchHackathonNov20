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
	
	@ObservedObject private(set) var viewModel: AddMealViewModel
	@State var title: String = ""
	@State var additionalInfo: String = ""
	@State var quantity: Int = 0
	@State var availableFromDate = Date()
	@State var useByDate = Date()
	@State var address: String = ""
	@State var latitude: Float = 0
	@State var longitude: Float = 0
	@State var isHot: Bool = true
	
	var body: some View {
		ZStack {
			ScrollView {
				VStack(alignment: .leading, spacing: 10) {
					Group {
						Text(Strings.AddMealScreen.title)
						TextField("", text: $title)
							.modifier(GrayTextFieldStyle())
						Text(Strings.AddMealScreen.additionalInfo)
						TextField("", text: $additionalInfo)
							.modifier(GrayTextFieldStyle())
						Text(Strings.AddMealScreen.quantity)
						TextField("", value: $quantity, formatter: NumberFormatter())
							.modifier(GrayTextFieldStyle())
						Text(Strings.AddMealScreen.temperature)
						
						HStack {
							Button(action: {
								isHot = true
							}) {
								let color = self.isHot ? ColorManager.red: ColorManager.gray
								Image(systemName: Strings.Common.Images.hotFood)
									.modifier(IconButtonImageStyle(color: color))
							}
							
							Button(action: {
								isHot = false
							}) {
								let color = self.isHot ? ColorManager.gray: ColorManager.blue
								Image(systemName: Strings.Common.Images.coldFood)
									.modifier(IconButtonImageStyle(color: color))
							}
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
								.modifier(GrayTextFieldStyle())
							Spacer(minLength: 10)
							Button(action: {
								self.address = "\(self.viewModel.locationManager.address)"
								self.latitude = Float(self.viewModel.locationManager.userLatitude)
								self.longitude = Float(self.viewModel.locationManager.userLongitude)
							}) {
								Image(systemName: Strings.Common.Images.location)
									.font(.title)
                                    .foregroundColor(ColorManager.appGreen)
							}
						}
					}
					
					Spacer()
					Button(Strings.AddMealScreen.addMeal) {
						let meal = Meal(
							id: "\(viewModel.sdk.getUUID())",
							name: "\(self.title)",
							quantity: Int32(self.quantity),
							availableFromDate: "\(self.availableFromDate)",
							expiryDate: "\(self.useByDate)",
							info: "\(self.additionalInfo)",
							hot: self.isHot,
							locationLat: self.latitude,
							locationLong:  self.longitude)
						self.viewModel.postMeal(meal: meal)
					}
					.modifier(AddButtonStyle())
				}.padding()
			}
			.navigationBarTitle(Strings.AddMealScreen.addMeal)
		}
        .alert(isPresented: $viewModel.showingAlert) {
            switch viewModel.activeAlert {
            case .collection:
                return Alert(
                    title: Text(viewModel.code),
                    message: Text(Strings.MealListScreen.CollectionAlert.message),
                    dismissButton: .default(Text(Strings.Common.ok)))
            default:
                return Alert(
                    title: Text(Strings.Common.sorry),
                    message: Text(Strings.Common.ErrorAlert.message),
                    dismissButton: .default(Text(Strings.Common.ok)))
            }
        }
	}
}

struct AddMealView_Previews: PreviewProvider {
	static var previews: some View {
		AddMealView(viewModel: AddMealViewModel(sdk: MealsSDK(), locationManager: LocationManager()))
	}
}


