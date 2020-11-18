//
//  SignUpWithPassword.swift
//  iosHackthonApp
//
//  Created by Raynelle Francisca on 18/11/2020.
//  Copyright © 2020 orgName. All rights reserved.
//

import SwiftUI
import Strings
import Theming
import Components
import LandingScreen

struct SignUpWithPassword: View {
	@State private var password: String = ""
	
	var body: some View {
		VStack(alignment: .leading) {
			SignUpInfoView(title: Strings.SignUp.signUpWithPasswordTitle, description: Strings.SignUp.signUpWithPasswordInfo)
			Spacer().frame(maxHeight: .infinity)

			GeometryReader { geometry in
				let height = geometry.frame(in: .local).height
				VStack {
					SecureField(Strings.SignUp.signUpWithPasswordPlaceHolder, text: $password)
						.modifier(GreyTextFieldStyle())
					NavigationLink(destination: LandingView()) {
						Text(Strings.SignUp.signUpWithPasswordButtonTitle)
							.modifier(AddButtonStyle(width: geometry.size.width,
													 backgroundColor: password.isEmpty ? ColorManager.gray: ColorManager.appPrimary))
					}
					.disabled(password.isEmpty)
				}
				.offset(y: height - 100)
			}
		}.padding()
	}
}

struct SignUpWithPassword_Previews: PreviewProvider {
    static var previews: some View {
        SignUpWithPassword()
    }
}
