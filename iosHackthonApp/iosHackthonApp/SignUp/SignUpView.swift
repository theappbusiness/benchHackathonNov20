//
//  SignUpView.swift
//  iosHackthonApp
//
//  Created by Raynelle Francisca on 17/11/2020.
//  Copyright © 2020 orgName. All rights reserved.
//

import SwiftUI
import Strings
import Theming
import Components

struct SignUpView: View {
	@State private var email: String = ""
	@State private var password: String = ""

	var body: some View {
		VStack(alignment: .leading) {
			Text(Strings.SignUp.welcomeScreenTitle)
				.fontWeight(.bold)
				.font(.title)
				.font(.system(size: 100))
			Spacer()
			Text(Strings.SignUp.welcomeScreenInfo)
			Spacer().frame(maxHeight: .infinity)

			GeometryReader { geometry in

				let height = geometry.frame(in: .local).height
				VStack {
					TextField(Strings.SignUp.registerWithEmailPlaceHolder, text: $email)
						.modifier(GreyTextFieldStyle())

					Button(action: {
					}) {
						Text(Strings.SignUp.welcomeButtonTitle)
							.modifier(AddButtonStyle(width: geometry.size.width,
													 backgroundColor:
														ColorManager.appPrimary))
					}
				}
				.offset(y: height - 100)
			}



		}.padding()
	}
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
