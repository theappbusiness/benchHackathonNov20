//
//  LoginViewModel.swift
//  
//
//  Created by Raynelle Francisca on 26/11/2020.
//

import Foundation
import SwiftUI
import shared
import Components
import Theming

public final class LoginViewModel: ObservableObject {

	@Published var email: String = ""
	@Published var password: String = ""
	@Published var showingAlert = false
	@Published var isLoading: Bool = false
	@Published var coloredNavAppearance = UINavigationBarAppearance()
	@Published var firebase: FirebaseAuthenticationStore
	@ObservedObject var authorizationStore: AuthorizationStore

	public init(firebase: FirebaseAuthenticationStore, authorizationStore: AuthorizationStore) {
		self.firebase = firebase
		self.authorizationStore = authorizationStore
		coloredNavAppearance.configureWithOpaqueBackground()
		coloredNavAppearance.backgroundColor = UIColor(ColorManager.appPrimary)
		coloredNavAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
		coloredNavAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
	}

	func login(email: String, password: String) {
		//TODO: API key to be handled in shared layer. remove the apikey parameter once implemented
		// To run the project for now, add the api key and run
		isLoading = true
		firebase.signIn(apiKey: "", email: email, password: password, returnSecureToken: true, completionHandler: { result, _ in
			if result?.idToken != nil {
				self.authorizationStore.storeUserLoggedInStatus(true)
			} else {
				self.showingAlert.toggle()
			}
			self.isLoading = false
		})
	}
}
