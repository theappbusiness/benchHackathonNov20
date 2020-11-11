//
//  ViewModifiers.swift
//  iosHackthonApp
//
//  Created by Raynelle Francisca on 10/11/2020.
//  Copyright © 2020 orgName. All rights reserved.
//

import Foundation
import SwiftUI

struct GrayTextFieldStyle: ViewModifier {
		func body(content: Content) -> some View {
				content
					.padding(.all)
					.background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
		}
}


struct AddButtonStyle: ViewModifier {
		func body(content: Content) -> some View {
				content
					.foregroundColor(.white)
					.padding(10)
					.frame(minWidth: 0, maxWidth: .infinity)
					.background(Color.red)
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


