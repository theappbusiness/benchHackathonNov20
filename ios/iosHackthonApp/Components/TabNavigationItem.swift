//
//  TabNavigationItem.swift
//  
//
//  Created by Gareth Miller on 24/11/2020.
//

import SwiftUI

public struct TabNavigationItem: View {
  
  public init(destination: AnyView, image: String, title: String, tagNumber: Int) {
    self.destination = destination
    self.image = image
    self.title = title
    self.tagNumber = tagNumber
  }
  
  private var destination: AnyView
  private var image: String
  private var title: String
  private var tagNumber: Int
  
  public var body: some View {
    NavigationView {
      AnyView(destination)
    }
    .tabItem {
      Image(systemName: image)
      Text(title)
    }.tag(tagNumber)
    .accentColor(ColorManager.appPrimary)
    .navigationBarHidden(true)
  }
}
