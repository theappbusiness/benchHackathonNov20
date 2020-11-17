//
//  ViewModifiers.swift
//  iosHackthonApp
//
//  Created by Raynelle Francisca on 10/11/2020.
//  Copyright © 2020 orgName. All rights reserved.
//

import Foundation
import SwiftUI
import Theming

struct GreyTextFieldStyle: ViewModifier {
	func body(content: Content) -> some View {
		content
			.padding(.all)
			.background(ColorManager.textfieldGrey)
	}
}

struct AddButtonStyle: ViewModifier {
	var width: CGFloat
	var backgroundColor: Color
	
	init(width: CGFloat, backgroundColor: Color) {
		self.width = width
		self.backgroundColor = backgroundColor
	}
	
	func body(content: Content) -> some View {
		content
			.foregroundColor(.white)
			.padding(10)
			.frame(minWidth: width, maxWidth: .infinity)
			.background(backgroundColor)
			.cornerRadius(10)
	}
}

struct IconButtonImageStyle: ViewModifier {
	var color: Color
	
	init(color: Color) {
		self.color = color
	}
	func body(content: Content) -> some View {
		content
			.foregroundColor(color)
			.padding(10)
			.frame(minWidth: 0, maxWidth: 50)
			.background(Color.clear)
			.border(color, width: 2)
			.cornerRadius(5)
	}
}
