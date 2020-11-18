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
import Components

public struct AddMealView: View {

    public init(viewModel: AddMealViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    @StateObject private var viewModel: AddMealViewModel

    public var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    createTextFields()
                    createTemperatureButtons()
                    Spacer()
                    createDatePickers()
                    Spacer()
                    createAddressFields()
                    Spacer()
                    GeometryReader { geometry in
                        Button(action: {
                            self.viewModel.postMeal()
                        }) {
                            Text(Strings.AddMealScreen.addMeal)
                                .modifier(AddButtonStyle(width: geometry.size.width,
                                                         backgroundColor: viewModel.buttonColor))
                        }
                        .disabled(viewModel.buttonIsDisabled)
                    }
                    Spacer()
                }.padding()
            }
            .navigationBarTitle(Strings.AddMealScreen.addMeal)
            .onAppear() {
                viewModel.address = "\(self.viewModel.locationManager.address)"
            }
        }
        .alert(isPresented: $viewModel.showingAlert) {
            switch viewModel.activeAlert {
            case .collection:
                return Alert(
                    title: Text(viewModel.code),
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

    func createTextFields() -> some View {
        Group {
            Text(Strings.AddMealScreen.title)
            TextField(Strings.AddMealScreen.titlePlaceholder, text: $viewModel.title)
                .modifier(GreyTextFieldStyle())

            Text(Strings.AddMealScreen.additionalInfo)
            TextField(Strings.AddMealScreen.additionalInfoPlaceholder, text: $viewModel.additionalInfo)
                .modifier(GreyTextFieldStyle())

            Text(Strings.AddMealScreen.quantity)
            TextField(Strings.AddMealScreen.quantity, value: $viewModel.quantity, formatter: NumberFormatter())
                .modifier(GreyTextFieldStyle())
        }
    }

    func createTemperatureButtons() -> some View {
        Group {
            Text(Strings.AddMealScreen.temperature)
            HStack {
                Button(action: {
                    viewModel.isHot.toggle()
                }) {
                    Image(systemName: Strings.Common.Images.hotFood)
                        .modifier(IconButtonImageStyle(color: viewModel.hotFoodColor))
                }

                Button(action: {
                    viewModel.isHot.toggle()
                }) {
                    Image(systemName: Strings.Common.Images.coldFood)
                        .modifier(IconButtonImageStyle(color: viewModel.coldFoodColor))
                }
            }
        }
    }

    func createDatePickers() -> some View {
        Group {
            // TODO: Not allow useBy date to be before available from
            DatePicker(Strings.AddMealScreen.availableFrom, selection: $viewModel.availableFromDate, in: Date()..., displayedComponents: .date)
            DatePicker(Strings.AddMealScreen.useBy, selection: $viewModel.useByDate, in: Date()..., displayedComponents: .date)
        }
    }

    func createAddressFields() -> some View {
        Group {
            Text(Strings.AddMealScreen.address)
            HStack {
                TextField("", text: $viewModel.address)
                    .modifier(GreyTextFieldStyle())
                    .disabled(true)

                Spacer(minLength: 10)
                Button(action: {
                    viewModel.address = "\(viewModel.locationManager.address)"
                    viewModel.latitude = Float(viewModel.locationManager.userLatitude)
                    viewModel.longitude = Float(viewModel.locationManager.userLongitude)
                }) {
                    Image(systemName: Strings.Common.Images.location)
                        .font(.title)
                        .foregroundColor(ColorManager.appPrimary)
                }
            }
        }
    }
}

struct AddMealView_Previews: PreviewProvider {
    static var previews: some View {
        AddMealView(viewModel: AddMealViewModel(sdk: MealsSDK(), locationManager: LocationManager()))
    }
}
