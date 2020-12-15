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
import Strings
import Components

struct TabAppView: View {
  
  private let mealListViewModel = MealListViewModel(sdk: MealsSDK(), locationManager: LocationManager())
  
  @State var selectedView: Int
  
  init(selectedView: Int) {
    UITabBar.appearance().barTintColor = UIColor(ColorManager.appPrimary)
    _selectedView = State(initialValue: selectedView)
  }
  
  var body: some View {
    TabView(selection: $selectedView, content: {
      TabNavigationItem(
        destination: AnyView(MealMapView(viewModel: mealListViewModel)),
        image: Strings.TabView.Images.find,
        title: Strings.TabView.findButtonText,
        tagNumber: 0)
      
      TabNavigationItem(
        destination: AnyView(SettingsView()),
        image: Strings.TabView.Images.settings,
        title: Strings.TabView.settings,
        tagNumber: 1)
    })
    .accentColor(.white)
  }
}

struct TabAppView_Previews: PreviewProvider {
  static var previews: some View {
    TabAppView(selectedView: 1)
  }
}
