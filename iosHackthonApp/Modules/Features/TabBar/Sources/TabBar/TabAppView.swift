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
import Components

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
            TabNavigationItem(
                destination: AnyView(MealMapView(viewModel: .init(sdk: sdk, locationManager: locationManager))),
                image: Strings.TabView.Images.find,
                title: Strings.TabView.findButtonText,
                tagNumber: 0)

            TabNavigationItem(
                destination: AnyView(MealListView(viewModel: .init(sdk: sdk, locationManager: locationManager))),
                image: Strings.TabView.Images.listView,
                title: Strings.TabView.listViewText,
                tagNumber: 1)
            
            TabNavigationItem(
                destination: AnyView(SettingsView()),
                image: Strings.TabView.Images.settings,
                title: Strings.TabView.settings,
                tagNumber: 2)
        })
        .accentColor(.white)
    }
}

struct TabAppView_Previews: PreviewProvider {
    static var previews: some View {
        TabAppView(selectedView: 1)
    }
}
