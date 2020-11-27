//
//  SignUpViewModel.swift
//  
//
//  Created by Raynelle Francisca on 27/11/2020.
//

import Foundation
import SwiftUI
import shared
import Components
import Strings

public final class SignUpWithPasswordViewModel: ObservableObject {

	var email: String
	@Published var password: String = ""
	@Published var moveToNextScreen: Bool = false
	@Published var isLoading: Bool = false
	@Published var firebase: FirebaseAuthenticationStore
	@ObservedObject var authorizationStore: AuthorizationStore
	var signUpWithPasswordTitle: String = Strings.SignUp.signUpWithPasswordTitle
	var signUpWithPasswordInfo: String = Strings.SignUp.signUpWithPasswordInfo
	var signUpWithPasswordPlaceHolder: String = Strings.SignUp.signUpWithPasswordPlaceHolder
	var signUpWithPasswordButtonTitle: String = Strings.SignUp.signUpWithPasswordButtonTitle

	public init(email: String, firebase: FirebaseAuthenticationStore, authorizationStore: AuthorizationStore) {
		self.email = email
		self.firebase = firebase
		self.authorizationStore = authorizationStore
	}

	func signUp(email: String, password: String) {
		//TODO: API key to be handled in shared layer
		// To run the project for now, add the api key and run
		isLoading = true
		firebase.signUp(apiKey: "", email: email, password: password, returnSecureToken: true, completionHandler: { result, error in
			if (result?.idToken != nil) {
				self.authorizationStore.storeUserLoggedInStatus(true)
				self.moveToNextScreen = true
			} 
			self.isLoading = false
		})
	}
}
