//
//  LoginView.swift
//  iosHackthonApp
//
//  Created by Raynelle Francisca on 16/11/2020.
//  Copyright © 2020 orgName. All rights reserved.
//

import SwiftUI
import Strings
import Theming
import Components
import LandingScreen
import SignUp

public struct LoginView: View {
	@State var email: String = ""
	@State var password: String = ""
	@State var loginSucessful: Bool = true
	let coloredNavAppearance = UINavigationBarAppearance()

	public init() {
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
							let isDisabled = email.isEmpty || password.isEmpty
							let backgroundColor = isDisabled ? ColorManager.gray: ColorManager.appPrimary
							NavigationLink(destination: LandingView()) {
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
            .navigationBarTitle(Text(Strings.LandingScreen.heading))
		}
		.accentColor(.white)
	}
}

struct LoginView_Previews: PreviewProvider {
	static var previews: some View {
		LoginView()
	}
}

