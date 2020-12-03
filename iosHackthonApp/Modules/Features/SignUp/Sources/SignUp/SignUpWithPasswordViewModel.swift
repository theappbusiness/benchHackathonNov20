//
//  SignUpViewModel.swift
//  
//
//  Created by Raynelle Francisca on 27/11/2020.
//

import Foundation
import SwiftUI
import shared
import Components
import Strings

public final class SignUpWithPasswordViewModel: ObservableObject {

    var email: String
    @Published var firebase: FirebaseAuthenticationStore
    @ObservedObject var authorizationStore: AuthorizationStore

    let signUpTitle = Strings.SignUp.signUpWithPasswordTitle
    let signUpInfo = Strings.SignUp.signUpWithPasswordInfo
    let signUpPlaceHolder = Strings.SignUp.signUpWithPasswordPlaceHolder
    let signUpButtonTitle = Strings.SignUp.signUpWithPasswordButtonTitle
    let signUpFailedTitle = Strings.SignUp.signUpWithPasswordFailed
    let signUpFailedInfo = Strings.SignUp.signUpWithPasswordFailedInfo
    let ok = Strings.Common.ok
    
    public init(email: String, firebase: FirebaseAuthenticationStore, authorizationStore: AuthorizationStore) {
        self.email = email
        self.firebase = firebase
        self.authorizationStore = authorizationStore
    }

    @Published var password: String = ""
    @Published var moveToNextScreen: Bool = false
    @Published var isLoading: Bool = false
    @Published var showingAlert = false

    func signUp(email: String, password: String) {
        isLoading = true
        firebase.signUp(email: email, password: password, returnSecureToken: true, completionHandler: { result, error in
            if (result?.idToken != nil) {
                self.authorizationStore.storeUserLoggedInStatus(true)
                self.moveToNextScreen = true
            } else {
                self.showingAlert.toggle()
            }
            self.isLoading = false
        })
    }
}
