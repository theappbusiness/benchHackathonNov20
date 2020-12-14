//
//  CustomButton.swift
//  iosHackthonApp
//
//  Created by Gareth Miller on 09/11/2020.
//  Copyright © 2020 orgName. All rights reserved.
//

import SwiftUI

public struct CustomButton: View {
  
  private let cornerRadius: CGFloat = 16
  private let paddingRatio: CGFloat = 0.12
  private let imageFrameRatio: CGFloat = 0.25
  private let shadowRadius: CGFloat = 5
  
  private var width: CGFloat
  private var buttonColor: Color
  private var image: String
  private var text: String
  
  public init(width: CGFloat,
              buttonColor: Color,
              image: String,
              text: String) {
    self.width = width
    self.buttonColor = buttonColor
    self.image = image
    self.text = text
  }
  
  public var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: cornerRadius)
        .foregroundColor(buttonColor)
        .padding(width * paddingRatio)
        .shadow(radius: shadowRadius)
      
      VStack {
        Image(systemName: image)
          .resizable()
          .frame(width: width * imageFrameRatio, height: width * imageFrameRatio)
        Text(text)
      }
      .foregroundColor(.white)
    }
  }
}

struct CustomButton_Previews: PreviewProvider {
  static var previews: some View {
    CustomButton(width: 150, buttonColor: .green, image: "plus.app", text: "Placeholder")
  }
}
