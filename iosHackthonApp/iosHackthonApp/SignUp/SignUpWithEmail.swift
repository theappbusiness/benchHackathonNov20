//
//  SignUpWithEmail.swift
//  iosHackthonApp
//
//  Created by Raynelle Francisca on 18/11/2020.
//  Copyright © 2020 orgName. All rights reserved.
//

import SwiftUI
import Strings
import Theming
import Components

struct SignUpWithEmail: View {
	@State private var email: String = ""
	
	var body: some View {
		VStack(alignment: .leading) {
			SignUpInfoView(title: Strings.SignUp.signUpWithEmailTitle, description: Strings.SignUp.signUpWithEmailInfo)
			Spacer().frame(maxHeight: .infinity)

			GeometryReader { geometry in
				let height = geometry.frame(in: .local).height
				VStack {
					TextField(Strings.SignUp.signUpWithEmailPlaceHolder, text: $email)
						.modifier(GreyTextFieldStyle())
					NavigationLink(destination: SignUpWithPassword()) {
						Text(Strings.SignUp.signUpWithEmailButtonTitle)
							.modifier(AddButtonStyle(width: geometry.size.width,
													 backgroundColor: email.isEmpty ? ColorManager.gray: ColorManager.appPrimary))
					}
					.disabled(email.isEmpty)
				}
				.offset(y: height - 100)
			}
		}.padding()
	}
}

struct SignUpWithEmail_Previews: PreviewProvider {
    static var previews: some View {
        SignUpWithEmail()
    }
}
