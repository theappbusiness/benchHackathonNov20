//
//  SignUpWithPassword.swift
//  iosHackthonApp
//
//  Created by Raynelle Francisca on 18/11/2020.
//  Copyright © 2020 orgName. All rights reserved.
//

import SwiftUI
import Strings
import Components
import TabBar
import shared

struct SignUpWithPassword: View {
	
	@ObservedObject private var signUpViewModel: SignUpViewModel

	public init(viewModel: SignUpViewModel) {
		self.signUpViewModel = viewModel
	}
	
	var body: some View {
		VStack(alignment: .leading) {
			SignUpInfoView(title: Strings.SignUp.signUpWithPasswordTitle, description: Strings.SignUp.signUpWithPasswordInfo)

			Spacer().frame(maxHeight: .infinity)
			
			GeometryReader { geometry in

				let viewModel = SignUpUserEntryViewModel(isSignupWithEmail: false,
														 textFieldPlaceholder: Strings.SignUp.signUpWithPasswordPlaceHolder,
														 buttonTitle: Strings.SignUp.signUpWithPasswordButtonTitle,
														 width: geometry.size.width,
														 entryField: $signUpViewModel.password,
														 signUp: self.signUp,
														 moveToNextScreen: $signUpViewModel.moveToNextScreen,
														 isLoading: $signUpViewModel.isLoading)

				SignUpUserEntryView(viewModel: viewModel, destinationView:TabAppView(selectedView: 0))
			}
		}.padding()
	}

	func signUp() {
		signUpViewModel.signUp(email: signUpViewModel.email, password: signUpViewModel.password)
	}
}
