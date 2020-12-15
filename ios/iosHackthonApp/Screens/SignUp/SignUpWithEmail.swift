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
import shared

struct SignUpWithEmail: View {
  
  @ObservedObject private var viewModel: SignUpWithEmailViewModel
  
  init(viewModel: SignUpWithEmailViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    
    let signupViewModel = SignUpWithPasswordViewModel(email: self.viewModel.email, firebase: FirebaseAuthenticationStore(), authorizationStore: AuthorizationStore(cache: UserDefaults.standard))
    
    VStack(alignment: .leading) {
      SignUpInfoView(title: viewModel.signUpWithEmailTitle, description: viewModel.signUpWithEmailInfo)
      
      Spacer().frame(maxHeight: .infinity)
      
      GeometryReader { geometry in
        let viewModel = SignUpUserEntryViewModel(
          isSignupWithEmail: true,
          textFieldPlaceholder: self.viewModel.signUpWithEmailPlaceHolder,
          buttonTitle: self.viewModel.signUpWithEmailButtonTitle,
          width: geometry.size.width,
          entryField: $viewModel.email,
          signUp: self.signUp,
          moveToNextScreen: $viewModel.moveToNextScreen,
          isLoading: .constant(self.viewModel.isLoading))
        
        SignUpUserEntryView(viewModel: viewModel, destinationView: SignUpWithPassword(viewModel: signupViewModel))
      }
    }.padding()
  }
}

struct SignUpWithEmail_Previews: PreviewProvider {
  static var previews: some View {
    SignUpWithEmail(viewModel: SignUpWithEmailViewModel())
  }
}

// MARK: - Functions
private extension SignUpWithEmail {
  func signUp() {
    viewModel.moveToNextScreen = true
  }
}
