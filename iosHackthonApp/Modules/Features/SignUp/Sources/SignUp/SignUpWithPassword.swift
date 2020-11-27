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
	@State private var movetonext: Bool = false
	
	var body: some View {
		VStack(alignment: .leading) {
			SignUpInfoView(title: Strings.SignUp.signUpWithPasswordTitle, description: Strings.SignUp.signUpWithPasswordInfo)

			Spacer().frame(maxHeight: .infinity)
			
			GeometryReader { geometry in
				SignUpUserEntryView(isSignupWithEmail: false,
									textFieldPlaceholder: Strings.SignUp.signUpWithPasswordPlaceHolder,
									buttonTitle: Strings.SignUp.signUpWithPasswordButtonTitle,
									width: geometry.size.width,
									destinationView: TabAppView(selectedView: 0),
									entryField: $password,
									signUp: self.signUp,
									movetonext: $movetonext)
			}
		}.padding()
	}

	func signUp() {
		  print("do something")
	  }
}

struct SignUpWithPassword_Previews: PreviewProvider {
    static var previews: some View {
        SignUpWithPassword()
    }
}
