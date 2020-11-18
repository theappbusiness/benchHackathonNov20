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
			SignUpInfoView(title: Strings.SignUp.welcomeScreenTitle, description: Strings.SignUp.welcomeScreenInfo)
			Spacer().frame(maxHeight: .infinity)

			GeometryReader { geometry in
				let height = geometry.frame(in: .local).height
				VStack {
					NavigationLink(destination: SignUpWithEmail()) {
						Text(Strings.SignUp.welcomeButtonTitle)
							.modifier(AddButtonStyle(width: geometry.size.width,
													 backgroundColor:ColorManager.appPrimary))
					}
				}
				.offset(y: height - 30)
			}
		}.padding()
	}
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
