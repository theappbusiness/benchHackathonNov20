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

struct SignUpWithPassword: View {
	@State private var password: String = ""
	@State private var moveToNextScreen: Bool = false
	@State private var isLoading: Bool = false
	
	var body: some View {
		VStack(alignment: .leading) {
			SignUpInfoView(title: Strings.SignUp.signUpWithPasswordTitle, description: Strings.SignUp.signUpWithPasswordInfo)

			Spacer().frame(maxHeight: .infinity)
			
			GeometryReader { geometry in

				let viewModel = SignUpUserEntryViewModel(isSignupWithEmail: false,
														 textFieldPlaceholder: Strings.SignUp.signUpWithPasswordPlaceHolder,
														 buttonTitle: Strings.SignUp.signUpWithPasswordButtonTitle,
														 width: geometry.size.width,
														 entryField: $password,
														 signUp: self.signUp,
														 moveToNextScreen: $moveToNextScreen,
														 isLoading: $isLoading)

				SignUpUserEntryView(viewModel: viewModel, destinationView:TabAppView(selectedView: 0))
			}
		}.padding()
	}

	func signUp() {
		//TODO: Add firebase sign up and update moveToNextScreen is call is successful
		// also update the loading state
	}
}

struct SignUpWithPassword_Previews: PreviewProvider {
    static var previews: some View {
        SignUpWithPassword()
    }
}
