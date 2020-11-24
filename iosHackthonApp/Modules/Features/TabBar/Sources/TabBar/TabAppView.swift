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
import Settings

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
			.tabItem {
				Image(systemName: Strings.TabView.Images.find)
				Text(Strings.TabView.findButtonText)
			}.tag(0)
			.accentColor(ColorManager.appPrimary)
            .navigationBarHidden(true)
			
			NavigationView {
				MealListView(viewModel: .init(sdk: sdk, locationManager: locationManager))
			}
			.tabItem {
				Image(systemName: Strings.TabView.Images.listView)
				Text(Strings.TabView.listViewText)
			}.tag(1)
			.accentColor(ColorManager.appPrimary)
            .navigationBarHidden(true)
			
			NavigationView {
                SettingsView()
			}
			.tabItem {
				Image(systemName: Strings.TabView.Images.settings)
				Text(Strings.TabView.settings)
			}.tag(2)
            .navigationBarHidden(true)
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
