//
//  LoginViewModel.swift
//  
//
//  Created by Raynelle Francisca on 26/11/2020.
//

import Foundation
import SwiftUI
import shared
import Components
import Theming
import Strings

public final class LoginViewModel: ObservableObject {

    typealias strings = Strings.Login

    @Published var firebase: FirebaseAuthenticationStore
    @ObservedObject var authorizationStore: AuthorizationStore

    public init(firebase: FirebaseAuthenticationStore, authorizationStore: AuthorizationStore) {
        self.firebase = firebase
        self.authorizationStore = authorizationStore
        coloredNavAppearance.configureWithOpaqueBackground()
        coloredNavAppearance.backgroundColor = UIColor(ColorManager.appPrimary)
        coloredNavAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredNavAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }

    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showingAlert = false
    @Published var isLoading: Bool = false
    @Published var coloredNavAppearance = UINavigationBarAppearance()

    let title = strings.heading
    let emailTitle = strings.email
    let emailPlaceholder = strings.emailPlaceholder
    let passwordTitle = strings.password
    let passwordPlaceholder = strings.passwordPlaceholder
    let loginButtonTitle = strings.loginButtonTitle
    let signupButtonTitle = strings.signupButtonTitle

    let alertTitle = strings.invalidLoginTitle
    let alertMessage = strings.invalidLoginMessage
    let alertButton = Strings.Common.ok

    let textFieldStyle = GreyTextFieldStyle()

    var loginButtonIsDisabled: Bool {
        email.isEmpty || password.isEmpty
    }

    var backgroundColor: Color {
        loginButtonIsDisabled ? ColorManager.gray: ColorManager.appPrimary
    }
}

// MARK:- Functions
extension LoginViewModel {
    func login(email: String, password: String) {
        isLoading = true
        firebase.signIn(email: email, password: password, returnSecureToken: true, completionHandler: { result, error in
            if (result?.idToken != nil) {
                self.authorizationStore.storeUserLoggedInStatus(true)
            } else {
                self.showingAlert.toggle()
            }
            self.isLoading = false
        })
    }
}
