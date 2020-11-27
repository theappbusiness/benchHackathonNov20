//
//  LoginView.swift
//  iosHackthonApp
//
//  Created by Raynelle Francisca on 16/11/2020.
//  Copyright © 2020 orgName. All rights reserved.
//

import SwiftUI
import shared
import Components
import Strings
import Theming
import TabBar
import SignUp

public struct LoginView: View {

	@ObservedObject private var loginViewModel: LoginViewModel

	public init(viewModel: LoginViewModel) {
		self.loginViewModel = viewModel
		UINavigationBar.appearance().standardAppearance = self.loginViewModel.coloredNavAppearance
		UINavigationBar.appearance().scrollEdgeAppearance = self.loginViewModel.coloredNavAppearance
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
						TextField(Strings.Login.emailPlaceholder, text: $loginViewModel.email)
							.modifier(GreyTextFieldStyle())
							.autocapitalization(.none)
							.disableAutocorrection(true)
						Text(Strings.Login.password)
						SecureField(Strings.Login.passwordPlaceholder, text: $loginViewModel.password)
							.modifier(GreyTextFieldStyle())
						Spacer()
						
						GeometryReader { geometry in
							ZStack {
								if loginViewModel.isLoading {
									ProgressView()
										.zIndex(1)
								}
								
								NavigationLink(destination: TabAppView(selectedView: 0), isActive: .constant(loginViewModel.authorizationStore.isAuthorised)) {
									Text("")
								}
								let isDisabled = loginViewModel.email.isEmpty || loginViewModel.password.isEmpty
								let backgroundColor = isDisabled ? ColorManager.gray: ColorManager.appPrimary
								Button(action: {
									loginViewModel.login(email: loginViewModel.email, password: loginViewModel.password)
								}) {
									Text(Strings.Login.loginButtonTitle)
										.modifier(AddButtonStyle(width: geometry.size.width, backgroundColor: backgroundColor))
								}
								.disabled(isDisabled)
								.zIndex(0)
							}
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
		.onAppear() {
			loginViewModel.authorizationStore.isUserAuthorized()
		}
		.accentColor(.white)
		.alert(isPresented: $loginViewModel.showingAlert) {
			return Alert(
				title: Text(Strings.Login.invalidLoginTitle),
				message: Text(Strings.Login.invalidLoginMessage),
				dismissButton: .default(Text(Strings.Common.ok)))
		}
	}
}

