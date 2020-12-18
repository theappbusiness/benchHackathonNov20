//
//  SignUpViewModel.swift
//  
//
//  Created by Raynelle Francisca on 27/11/2020.
//

import Foundation
import SwiftUI
import shared
import Strings
import Components

final class SignUpWithPasswordViewModel: ObservableObject {
  
  var email: String
  @Published var password: String = ""
  @Published var moveToNextScreen: Bool = false
  @Published var isLoading: Bool = false
  @Published var showingAlert = false
  @Published var firebase: FirebaseAuthenticationStore
  @ObservedObject var authorizationStore: AuthorizationStore
  var signUpWithPasswordTitle: String = Strings.SignUp.signUpWithPasswordTitle
  var signUpWithPasswordInfo: String = Strings.SignUp.signUpWithPasswordInfo
  var signUpWithPasswordPlaceHolder: String = Strings.SignUp.signUpWithPasswordPlaceHolder
  var signUpWithPasswordButtonTitle: String = Strings.SignUp.signUpWithPasswordButtonTitle
  var signUpWithPasswordFailedTitle: String = Strings.SignUp.signUpWithPasswordFailed
  var signUpWithPasswordFailedInfo: String = Strings.SignUp.signUpWithPasswordFailedInfo
  
  init(email: String, firebase: FirebaseAuthenticationStore, authorizationStore: AuthorizationStore) {
    self.email = email
    self.firebase = firebase
    self.authorizationStore = authorizationStore
  }
  
  func signUp(email: String, password: String) {
    isLoading = true
    firebase.signUp(email: email, password: password, returnSecureToken: true, completionHandler: { result, _ in
      if result?.idToken != nil {
        self.authorizationStore.storeUserLoggedInStatus(true)
        self.moveToNextScreen = true
      } else {
        self.showingAlert.toggle()
      }
      self.isLoading = false
    })
  }
}
