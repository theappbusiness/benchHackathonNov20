//
//  LocationNeededMessageBox.swift
//  
//
//  Created by Gareth Miller on 17/11/2020.
//

import SwiftUI
import Strings
import Theming

public struct LocationNeededMessageBox: View {

    private let widthRatio: CGFloat = 0.25
    private let cornerRadius: CGFloat = 16
    private let paddingRatio: CGFloat = 10

    var width: CGFloat
    var buttonColor: Color
    var image: String
    var text: String
    var paddingSize: CGFloat

    public init(width: CGFloat,
                buttonColor: Color,
                image: String,
                text: String) {
        self.width = width
        self.buttonColor = buttonColor
        self.image = image
        self.text = text
        paddingSize = width/paddingRatio
    }

    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .foregroundColor(ColorManager.appPrimary)
            VStack {
                Spacer()
                Image(systemName: Strings.LandingScreen.Images.exclamation)
                    .resizable()
                    .frame(width: width * widthRatio, height: width * widthRatio)
                Spacer()
                Text(Strings.LandingScreen.enableLocationText)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                Spacer()
                Button(Strings.LandingScreen.settingsLinkText) {
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        if UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        }
                    }
                }
                .foregroundColor(.blue)
            }
            .padding()
        }
        .foregroundColor(.white)
        .padding(.init(top: paddingSize/2, leading: paddingSize, bottom: paddingSize, trailing: paddingSize))
    }
}
