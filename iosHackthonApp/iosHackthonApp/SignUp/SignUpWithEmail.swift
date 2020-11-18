//
//  SignUpWithEmail.swift
//  iosHackthonApp
//
//  Created by Raynelle Francisca on 18/11/2020.
//  Copyright © 2020 orgName. All rights reserved.
//

import SwiftUI
import Strings
import Components

struct SignUpWithEmail: View {
	@State private var email: String = ""
	
	var body: some View {
		VStack(alignment: .leading) {
			SignUpInfoView(title: Strings.SignUp.signUpWithEmailTitle, description: Strings.SignUp.signUpWithEmailInfo)

			Spacer().frame(maxHeight: .infinity)
			
			GeometryReader { geometry in
				SignUpUserEntryView(isSignupWithEmail: true,
									textFieldPlaceholder: Strings.SignUp.signUpWithEmailPlaceHolder, buttonTitle: Strings.SignUp.signUpWithEmailButtonTitle,
									width: geometry.size.width,
									destinationView: SignUpWithPassword(),
									entryField: $email)
			}
		}.padding()
	}
}

struct SignUpWithEmail_Previews: PreviewProvider {
    static var previews: some View {
        SignUpWithEmail()
    }
}
