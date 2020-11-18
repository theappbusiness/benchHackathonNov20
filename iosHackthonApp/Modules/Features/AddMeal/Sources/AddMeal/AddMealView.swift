//
//  AddMealView.swift
//  iosHackthonApp
//
//  Created by Gareth Miller on 09/11/2020.
//  Copyright © 2020 orgName. All rights reserved.
//

import SwiftUI
import shared
import Strings
import Theming
import Location
import Extensions
import Components

public struct AddMealView: View {

    private let sdk: MealsSDK
    private let locationManager: LocationManager

    public init(sdk: MealsSDK, locationManager: LocationManager) {
        self.sdk = sdk
        self.locationManager = locationManager
    }

    @State private var code = ""
    @State private var showingAlert = false
    @State private var activeAlert: ActiveAlert = .collection
    @State private var title: String = ""
    @State private var additionalInfo: String = ""
    @State private var quantity: Int = 0
    @State private var availableFromDate = Date()
    @State private var useByDate = Date()
    @State private var address: String = ""
    @State private var latitude: Float = 0
    @State private var longitude: Float = 0
    @State private var isHot: Bool = true

    var buttonIsDisabled: Bool {
        title.isEmpty || additionalInfo.isEmpty || address.isEmpty || quantity == 0
    }

    var buttonColor: Color {
        buttonIsDisabled ? ColorManager.gray : ColorManager.appPrimary
    }

    public var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    infoTextFieldsGroup(title: $title, info: $additionalInfo, quantity: $quantity)
                    TemperatureButtonsGroup(isHot: $isHot)
                    Spacer()
                    DatePickers(availableFromDate: $availableFromDate, useByDate: $useByDate)
                    Spacer()
                    AddressTextField(locationManager: locationManager, address: $address, latitude: $latitude, longitude: $longitude)
                    Spacer()
                    GeometryReader { geometry in
                        Button(action: {
                            postMeal(meal: createMeal())
                        }) {
                            Text(Strings.AddMealScreen.addMeal)
                                .modifier(AddButtonStyle(width: geometry.size.width,
                                                         backgroundColor: buttonColor))
                        }
                        .disabled(buttonIsDisabled)
                    }
                    Spacer()
                }.padding()
            }
            .navigationBarTitle(Strings.AddMealScreen.addMeal)
            .onAppear() {
                address = "\(locationManager.address)"
            }
        }
        .alert(isPresented: $showingAlert) {
            switch activeAlert {
            case .collection:
                return Alert(
                    title: Text(code),
                    message: Text(Strings.AddMealScreen.CollectionAlert.message),
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

// MARK:- Views
extension AddMealView {

    private struct infoTextFieldsGroup: View {

        @Binding var title: String
        @Binding var info: String
        @Binding var quantity: Int

        var body: some View {
            Group {
                Text(Strings.AddMealScreen.title)
                TextField(Strings.AddMealScreen.titlePlaceholder, text: $title)
                    .modifier(GreyTextFieldStyle())

                Text(Strings.AddMealScreen.additionalInfo)
                TextField(Strings.AddMealScreen.additionalInfoPlaceholder, text: $info)
                    .modifier(GreyTextFieldStyle())

                Text(Strings.AddMealScreen.quantity)
                TextField(Strings.AddMealScreen.quantity, value: $quantity, formatter: NumberFormatter())
                    .modifier(GreyTextFieldStyle())
            }
        }
    }

    private struct TemperatureButtonsGroup: View {

        @Binding var isHot: Bool

        var hotFoodColor: Color {
            isHot ? ColorManager.red : ColorManager.gray
        }

        var coldFoodColor: Color {
            isHot ? ColorManager.gray : ColorManager.blue
        }

        var body: some View {
            Group {
                Text(Strings.AddMealScreen.temperature)
                HStack {
                    Button(action: {
                    isHot.toggle()
                    }) {
                        Image(systemName: Strings.Common.Images.hotFood)
                            .modifier(IconButtonImageStyle(color: hotFoodColor))
                    }

                    Button(action: {
                        isHot.toggle()
                    }) {
                        Image(systemName: Strings.Common.Images.coldFood)
                            .modifier(IconButtonImageStyle(color: coldFoodColor))
                    }
                }
            }
        }
    }

    private struct DatePickers: View {

        @Binding var availableFromDate: Date
        @Binding var useByDate: Date

        var body: some View {
            Group {
                DatePicker(Strings.AddMealScreen.availableFrom, selection: $availableFromDate, in: Date()..., displayedComponents: .date)
                DatePicker(Strings.AddMealScreen.useBy, selection: $useByDate, in: availableFromDate..., displayedComponents: .date)
            }
        }
    }

    private struct AddressTextField: View {

        let locationManager: LocationManager
        @Binding var address: String
        @Binding var latitude: Float
        @Binding var longitude: Float

        var body: some View {
            Group {
                Text(Strings.AddMealScreen.address)
                HStack {
                    TextField("", text: $address)
                        .modifier(GreyTextFieldStyle())
                        .disabled(true)

                    Spacer(minLength: 10)
                    Button(action: {
                        address = "\(locationManager.address)"
                        latitude = Float(locationManager.userLatitude)
                        longitude = Float(locationManager.userLongitude)
                    }) {
                        Image(systemName: Strings.Common.Images.location)
                            .font(.title)
                            .foregroundColor(ColorManager.appPrimary)
                    }
                }
            }
        }
    }
}

//MARK:- Functions
extension AddMealView {
    private func createMeal() -> Meal {

        Meal(id: "\(sdk.getUUID())",
             name: "\(title)",
             quantity: Int32(quantity),
             availableFromDate: "\(availableFromDate)",
             expiryDate: "\(useByDate)",
             info: "\(additionalInfo)",
             hot: isHot,
             locationLat: latitude,
             locationLong:  longitude)
    }

    private func postMeal(meal: Meal) {

        sdk.postMeal(meal: meal, completionHandler: { meal, error in
            guard
                let meal = meal,
                error == nil else {
                self.activeAlert = .error
                self.showingAlert.toggle()
                return
            }
            self.code = meal.id.last4Chars()
            self.activeAlert = .collection
            self.showingAlert.toggle()
        })
    }
}

struct AddMealView_Previews: PreviewProvider {
    static var previews: some View {
        AddMealView(sdk: MealsSDK(), locationManager: LocationManager())
    }
}
