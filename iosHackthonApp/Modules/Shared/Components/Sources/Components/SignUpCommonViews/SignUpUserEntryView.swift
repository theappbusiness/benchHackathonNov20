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

	var signUp : () -> ()
	
	private var isSignupWithEmail: Bool
	private var textFieldPlaceholder: String
	private var buttonTitle: String
	private var width: CGFloat
	private var destinationView: Content
	@Binding private var entryField: String
	@Binding private var movetonext: Bool
	@State var isLoading: Bool = false
	
	public init(isSignupWithEmail: Bool,
				textFieldPlaceholder: String,
				buttonTitle: String,
				width: CGFloat,
				destinationView: Content,
				entryField: Binding<String>,
				signUp : @escaping () -> (),
				movetonext: Binding<Bool>) {
		self.isSignupWithEmail = isSignupWithEmail
		self.textFieldPlaceholder = textFieldPlaceholder
		self.buttonTitle = buttonTitle
		self.width = width
		self.destinationView = destinationView
		_entryField = entryField
		self.signUp = signUp
		_movetonext = movetonext
	}
	
	public var body: some View {
		VStack(alignment: .trailing) {
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
//				NavigationLink(destination: destinationView) {
//					Text(buttonTitle)
//						.modifier(AddButtonStyle(width: width,
//												 backgroundColor: entryField.isEmpty ? ColorManager.gray: ColorManager.appPrimary))
//				}
//				.disabled(entryField.isEmpty)


				ZStack {
						if self.isLoading {
							ProgressView()
								.zIndex(1)
						}

						NavigationLink(destination: destinationView, isActive: $movetonext ) {
							Text("")
						}
						Button(action: {
							//login(email: email, password: password)

							//self.movetonext = true
							self.signUp()
						}) {
							Text(buttonTitle)
								.modifier(AddButtonStyle(width: width, backgroundColor: entryField.isEmpty ? ColorManager.gray: ColorManager.appPrimary))
						}
						.disabled(entryField.isEmpty)
						.zIndex(0)
					}
			}
		}
	}
}
