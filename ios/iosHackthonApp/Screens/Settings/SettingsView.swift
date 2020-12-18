//
//  SettingsView.swift
//  
//
//  Created by Gareth Miller on 24/11/2020.
//

import SwiftUI

struct SettingsView: View {
  @EnvironmentObject var appState: AppState
//  init() { }
  
  var body: some View {
    VStack {
           Text("Hello, World #3!")
           Button (action: {
            self.appState.moveToHome = true

           } ){
               Text("Pop to root")
           }
       }
  }
}

struct SwiftUIView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView()
  }
}
