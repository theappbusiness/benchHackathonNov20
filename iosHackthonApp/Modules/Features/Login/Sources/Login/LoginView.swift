//
//  LoginView.swift
//  iosHackthonApp
//
//  Created by Raynelle Francisca on 16/11/2020.
//  Copyright © 2020 orgName. All rights reserved.
//

import SwiftUI
import shared
import Strings
import Theming
import Components
import TabBar
import SignUp


public struct LoginView: View {
	@State private var email: String = ""
	@State private var password: String = ""
	@State private var loginSucessful: Bool = false
	@State private var isUserLoggedIn = UserDefaults.standard.bool(forKey: "UserLoggedIn")
	let coloredNavAppearance = UINavigationBarAppearance()
	private var firebase: FirebaseAuthenticationStore

	public init(firebase: FirebaseAuthenticationStore) {
		self.firebase = firebase
		coloredNavAppearance.configureWithOpaqueBackground()
		coloredNavAppearance.backgroundColor = UIColor(ColorManager.appPrimary)
		coloredNavAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
		coloredNavAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
		UINavigationBar.appearance().standardAppearance = coloredNavAppearance
		UINavigationBar.appearance().scrollEdgeAppearance = coloredNavAppearance
	}

	public var body: some View {
		NavigationView {
			ScrollView {
				VStack {
					Image("") // TODO: Add proper logo
						.resizable()
						.scaledToFit()
						.frame(width: 150, height: 150, alignment: .center)
						.border(Color.gray, width: 2)
						.cornerRadius(10)
				}
				.padding()

				VStack(alignment: .leading, spacing: 10) {
					Group {
						Text(Strings.Login.email)
						TextField(Strings.Login.emailPlaceholder, text: $email)
							.modifier(GreyTextFieldStyle())
						Text(Strings.Login.password)
						SecureField(Strings.Login.passwordPlaceholder, text: $password)
							.modifier(GreyTextFieldStyle())
						Spacer()

						GeometryReader { geometry in
							NavigationLink(destination: TabAppView(selectedView: 0), isActive: $loginSucessful) {
								Text("")
							}

							let isDisabled = email.isEmpty || password.isEmpty
							let backgroundColor = isDisabled ? ColorManager.gray: ColorManager.appPrimary
							Button(action: {
								login(email: email, password: password)
							}) {
								Text(Strings.Login.loginButtonTitle)
									.modifier(AddButtonStyle(width: geometry.size.width, backgroundColor: backgroundColor))
							}
							.disabled(isDisabled)
						}
					}
				}
				.padding()
				Spacer()
				VStack {
					Spacer(minLength: 20)
					GeometryReader { geometry in
						NavigationLink(destination: SignUpView()) {
							Text(Strings.Login.signupButtonTitle)
								.frame(width: geometry.size.width, alignment: .center)
								.foregroundColor(ColorManager.appPrimary)
						}
					}
				}
			}
			.navigationBarTitle(Text(Strings.Login.heading))
		}
		.accentColor(.white)
		.onAppear() {
			if isUserLoggedIn {
				loginSucessful = true
			}

		}
	}
}

extension LoginView {
	func login(email: String, password: String) {
		//TODO: store this key somewhere else
		firebase.signIn(apiKey: "AIzaSyCXmrUtOgzc4kj8aimSkmjOcCV9PR438-o", email: email, password: password, returnSecureToken: true, completionHandler: { result, error in
			if (result != nil) {
				self.loginSucessful = true
				UserDefaults.standard.set(self.loginSucessful, forKey: "UserLoggedIn")
			} else {
				print("error")
			}

		})
	}
}

struct LoginView_Previews: PreviewProvider {
	static var previews: some View {
		LoginView(firebase: FirebaseAuthenticationStore())
	}
}

