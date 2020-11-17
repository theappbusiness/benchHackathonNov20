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
				AddMealView(viewModel: .init(sdk: self.sdk, locationManager: self.locationManager))
			}
			.navigationBarHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
			.tabItem {
				Image(systemName: Strings.LandingScreen.Images.plus)
				Text(Strings.LandingScreen.plusButtonText)
			}.tag(0)
            .accentColor(ColorManager.appPrimary)

			NavigationView {
                MealListView(viewModel: .init(sdk: self.sdk, locationManager: locationManager))
			}
            .navigationViewStyle(StackNavigationViewStyle())
			.navigationBarHidden(true)
			.tabItem {
				Image(systemName: Strings.LandingScreen.Images.find)
				Text(Strings.LandingScreen.findButtonText)
			}.tag(1)
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
