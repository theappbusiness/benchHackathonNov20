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
import Components

struct SignUpUserEntryView<Content: View>: View {

	var isSignupWithEmail: Bool
	var textFieldPlaceholder: String
	var buttonTitle: String
	var width: CGFloat
	var destinationView: Content
	@Binding var entryField: String

	var body: some View {
		VStack {
			if isSignupWithEmail {
				TextField(textFieldPlaceholder, text: $entryField)
					.modifier(GreyTextFieldStyle())
			} else {
				SecureField(textFieldPlaceholder, text: $entryField)
					.modifier(GreyTextFieldStyle())
			}

			NavigationLink(destination: destinationView) {
				Text(buttonTitle)
					.modifier(AddButtonStyle(width: width,
											 backgroundColor: entryField.isEmpty ? ColorManager.gray: ColorManager.appPrimary))
			}
			.disabled(entryField.isEmpty)
		}
	}
}
