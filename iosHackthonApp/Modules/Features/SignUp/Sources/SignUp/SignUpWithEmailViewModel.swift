//
//  SignUpWithEmailViewModel.swift
//  
//
//  Created by Raynelle Francisca on 27/11/2020.
//

import Foundation
import Strings

public final class SignUpWithEmailViewModel: ObservableObject {

	@Published var email: String = ""
	@Published var moveToNextScreen: Bool = false

	let isLoading = false

	let signUpWithEmailTitle = Strings.SignUp.signUpWithEmailTitle
	let signUpWithEmailInfo = Strings.SignUp.signUpWithEmailInfo
	let signUpWithEmailPlaceHolder = Strings.SignUp.signUpWithEmailPlaceHolder
	let signUpWithEmailButtonTitle = Strings.SignUp.signUpWithEmailButtonTitle
}
