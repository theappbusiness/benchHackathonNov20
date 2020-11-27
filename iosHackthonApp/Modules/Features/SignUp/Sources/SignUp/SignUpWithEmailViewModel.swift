//
//  SignUpWithEmailViewModel.swift
//  
//
//  Created by Raynelle Francisca on 27/11/2020.
//

import Foundation
import Strings

public final class SignUpWithEmailViewModel: ObservableObject {
	@Published  var email: String = ""
	@Published  var moveToNextScreen: Bool = false
	var signUpWithEmailTitle: String = Strings.SignUp.signUpWithEmailTitle
	var signUpWithEmailInfo: String = Strings.SignUp.signUpWithEmailInfo
	var signUpWithEmailPlaceHolder: String = Strings.SignUp.signUpWithEmailPlaceHolder
	var signUpWithEmailButtonTitle: String = Strings.SignUp.signUpWithEmailButtonTitle
}
