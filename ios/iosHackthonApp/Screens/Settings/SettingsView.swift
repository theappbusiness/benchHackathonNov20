//
//  SettingsView.swift
//  
//
//  Created by Gareth Miller on 24/11/2020.
//

import SwiftUI
import Strings
import Components

struct SettingsView: View {
  @EnvironmentObject var appState: AppState
  
  var body: some View {
    List {
      Button (action: {
        self.appState.navDestination = .home
      } ){
        Text(Strings.Settings.signOutButtonTitle)
      }
      //TODO: Add more settings option when required here
    }
    .navigationBarTitle(Strings.Settings.title)
  }
}

struct SwiftUIView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView()
  }
}
