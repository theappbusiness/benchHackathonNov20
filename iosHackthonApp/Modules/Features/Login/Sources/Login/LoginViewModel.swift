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
		//TODO: API key should be in the shared layer
		isLoading = true
		firebase.signIn(apiKey: "AIzaSyCXmrUtOgzc4kj8aimSkmjOcCV9PR438-o", email: email, password: password, returnSecureToken: true, completionHandler: { result, error in
			if (result?.idToken != nil) {
				self.authorizationStore.storeUserLoggedInStatus(true)
			} else {
				self.showingAlert.toggle()
			}
			self.isLoading = false
		})
	}
}
