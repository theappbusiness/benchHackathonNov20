//
//  CustomButton.swift
//  iosHackthonApp
//
//  Created by Gareth Miller on 09/11/2020.
//  Copyright © 2020 orgName. All rights reserved.
//

import SwiftUI

struct CustomButton: View {

    let cornerRadius: CGFloat = 16
    let paddingRatio: CGFloat = 0.12
    let imageFrameRatio: CGFloat = 0.25
    let shadowRadius: CGFloat = 5

    var width: CGFloat
    var foreGroundColor: Color
    var image: String
    var text: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .foregroundColor(foreGroundColor)
                .padding(width * paddingRatio)
                .shadow(radius: shadowRadius)

            VStack {
                Image(systemName: image)
                    .resizable()
                    .frame(width: width * imageFrameRatio, height: width * imageFrameRatio)
                    .foregroundColor(.white)
                Text(text)
                    .foregroundColor(.white)
            }
        }
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(width: 150, foreGroundColor: .green, image: Strings.LandingScreen.Images.plus, text: "Placeholder")
    }
}
