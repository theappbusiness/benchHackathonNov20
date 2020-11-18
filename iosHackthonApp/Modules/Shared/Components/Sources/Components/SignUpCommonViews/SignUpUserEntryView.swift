//
//  SignUpUserEntryView.swift
//  iosHackthonApp
//
//  Created by Raynelle Francisca on 18/11/2020.
//  Copyright © 2020 orgName. All rights reserved.
//

import SwiftUI
import Strings
import Theming

public struct SignUpUserEntryView<Content: View>: View {

	var isSignupWithEmail: Bool
	var textFieldPlaceholder: String
	var buttonTitle: String
	var width: CGFloat
	var destinationView: Content
	@Binding var entryField: String


	public init(isSignupWithEmail: Bool,
				textFieldPlaceholder: String,
				buttonTitle: String,
				width: CGFloat,
				destinationView: Content,
				entryField: Binding<String>) {
		self.isSignupWithEmail = isSignupWithEmail
		self.textFieldPlaceholder = textFieldPlaceholder
		self.buttonTitle = buttonTitle
		self.width = width
		self.destinationView = destinationView
		self._entryField = entryField
	}


	public var body: some View {
		VStack(alignment:.trailing) {
			Spacer()
			HStack {
				if isSignupWithEmail {
					TextField(textFieldPlaceholder, text: $entryField)
						.modifier(GreyTextFieldStyle())
				} else {
					SecureField(textFieldPlaceholder, text: $entryField)
						.modifier(GreyTextFieldStyle())
				}
			}
			HStack {
				NavigationLink(destination: destinationView) {
					Text(buttonTitle)
						.modifier(AddButtonStyle(width: width,
												 backgroundColor: entryField.isEmpty ? ColorManager.gray: ColorManager.appPrimary))
				}
				.disabled(entryField.isEmpty)
			}
		}
	}
}
