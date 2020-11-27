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
import Theming


public final class SignUpViewModel: ObservableObject {

	var email: String
	@Published var password: String = ""
	@Published var moveToNextScreen: Bool = false
	@Published var isLoading: Bool = false
	@Published var showingAlert = false
	@Published var firebase: FirebaseAuthenticationStore
	@ObservedObject var authorizationStore: AuthorizationStore

	public init(email: String, firebase: FirebaseAuthenticationStore, authorizationStore: AuthorizationStore) {
		self.email = email
		self.firebase = firebase
		self.authorizationStore = authorizationStore
	}

	func signUp(email: String, password: String) {
		//TODO: API key should be in the shared layer
		isLoading = true
		firebase.signIn(apiKey: "AIzaSyCXmrUtOgzc4kj8aimSkmjOcCV9PR438-o", email: email, password: password, returnSecureToken: true, completionHandler: { result, error in
			if (result?.idToken != nil) {
				self.authorizationStore.storeUserLoggedInStatus(true)
				self.moveToNextScreen = true
			} else {
				self.showingAlert.toggle()
			}
			self.isLoading = false
		})
	}
}
