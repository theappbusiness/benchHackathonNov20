//
//  SignUpUserEntryViewModel.swift
//  
//
//  Created by Raynelle Francisca on 27/11/2020.
//

import Foundation
import SwiftUI
import Strings
import Theming


public final class SignUpUserEntryViewModel:  ObservableObject {
	
	var signUp : () -> ()
	var isSignupWithEmail: Bool
	var textFieldPlaceholder: String
	var buttonTitle: String
	var width: CGFloat
	@Binding  var entryField: String
	@Binding  var moveToNextScreen: Bool
	@State var isLoading: Bool = false

	public init(isSignupWithEmail: Bool,
				textFieldPlaceholder: String,
				buttonTitle: String,
				width: CGFloat,
				entryField: Binding<String>,
				signUp : @escaping () -> (),
				moveToNextScreen: Binding<Bool>) {
		self.isSignupWithEmail = isSignupWithEmail
		self.textFieldPlaceholder = textFieldPlaceholder
		self.buttonTitle = buttonTitle
		self.width = width
		_entryField = entryField
		self.signUp = signUp
		_moveToNextScreen = moveToNextScreen
	}
}