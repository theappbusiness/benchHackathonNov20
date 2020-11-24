//
//  TabAppView.swift
//  iosHackthonApp
//
//  Created by Raynelle Francisca on 11/11/2020.
//  Copyright © 2020 orgName. All rights reserved.
//

import SwiftUI
import shared
import Location
import Theming
import MealList
import Strings
import AddMeal

public struct TabAppView: View {

    private let sdk = MealsSDK()
    private let locationManager = LocationManager()
    
    @State var selectedView: Int

    public init(selectedView: Int) {
        UITabBar.appearance().barTintColor = UIColor(ColorManager.appPrimary)
        _selectedView = State(initialValue: selectedView)
    }

    public var body: some View {
        TabView(selection: $selectedView, content: {
            NavigationView {
				MealMapView(viewModel: .init(sdk: sdk, locationManager: locationManager))
            }
            .navigationBarHidden(true)
            .tabItem {
                Image(systemName: Strings.LandingScreen.Images.find)
                Text(Strings.LandingScreen.findButtonText)
            }.tag(0)
            .accentColor(ColorManager.appPrimary)

			NavigationView {
				MealListView(viewModel: .init(sdk: sdk, locationManager: locationManager))
			}
			.navigationBarHidden(true)
			.tabItem {
				Image(systemName: Strings.LandingScreen.Images.listView)
				Text(Strings.LandingScreen.plusButtonText)
			}.tag(1)
			.accentColor(ColorManager.appPrimary)

			NavigationView {
				//TODO: Change this to the settings screen, once it is implemented.
				AddMealView(sdk: sdk, locationManager: locationManager)
			}
			.navigationBarHidden(true)
			.tabItem {
				Image(systemName: Strings.LandingScreen.Images.settings)
				Text(Strings.LandingScreen.settings)
			}.tag(2)
			.accentColor(ColorManager.appPrimary)
        })
        .accentColor(.white)
    }
}

struct TabAppView_Previews: PreviewProvider {
    static var previews: some View {
        TabAppView(selectedView: 1)
    }
}
