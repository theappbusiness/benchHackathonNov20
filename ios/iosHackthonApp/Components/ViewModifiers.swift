//
//  ViewModifiers.swift
//  iosHackthonApp
//
//  Created by Raynelle Francisca on 10/11/2020.
//  Copyright © 2020 orgName. All rights reserved.
//

import Foundation
import SwiftUI

public struct GreyTextFieldStyle: ViewModifier {

  public init() {}

  public func body(content: Content) -> some View {
    content
      .padding(.all)
      .background(ColorManager.textfieldGrey)
      .accentColor(ColorManager.appPrimary)
  }
}

public struct AddButtonStyle: ViewModifier {

  private var width: CGFloat
  private var backgroundColor: Color

  public init(width: CGFloat, backgroundColor: Color) {
    self.width = width
    self.backgroundColor = backgroundColor
  }

  public func body(content: Content) -> some View {
    content
      .foregroundColor(.white)
      .padding(10)
      .frame(minWidth: width, maxWidth: .infinity)
      .background(backgroundColor)
      .cornerRadius(10)
  }
}

public struct IconButtonImageStyle: ViewModifier {

  private var color: Color

  public init(color: Color) {
    self.color = color
  }

  public func body(content: Content) -> some View {
    content
      .foregroundColor(color)
      .padding(10)
      .frame(minWidth: 0, maxWidth: 50)
      .background(Color.clear)
      .border(color, width: 2)
      .cornerRadius(5)
  }
}
