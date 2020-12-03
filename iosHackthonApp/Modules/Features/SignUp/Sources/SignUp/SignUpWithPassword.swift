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
import shared

struct SignUpWithPassword: View {

    @ObservedObject private var viewModel: SignUpWithPasswordViewModel

    public init(viewModel: SignUpWithPasswordViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(alignment: .leading) {
            SignUpInfoView(title: viewModel.signUpTitle, description: viewModel.signUpInfo)
            
            Spacer().frame(maxHeight: .infinity)

            GeometryReader { geometry in

                let viewModel = SignUpUserEntryViewModel(
                    isSignupWithEmail: false,
                    textFieldPlaceholder: self.viewModel.signUpPlaceHolder,
                    buttonTitle: self.viewModel.signUpButtonTitle,
                    width: geometry.size.width,
                    entryField: $viewModel.password,
                    signUp: self.signUp,
                    moveToNextScreen: $viewModel.moveToNextScreen,
                    isLoading: $viewModel.isLoading)

                SignUpUserEntryView(viewModel: viewModel, destinationView:TabAppView(selectedView: 0))
            }
        }.padding()
        .alert(isPresented: $viewModel.showingAlert) {
            return Alert(
                title: Text(self.viewModel.signUpFailedTitle),
                message: Text(self.viewModel.signUpFailedInfo),
                dismissButton: .default(Text(viewModel.ok)))
        }
    }
}

//MARK:- Functions
private extension SignUpWithPassword {
    func signUp() {
        viewModel.signUp(email: self.viewModel.email, password: self.viewModel.password)
    }
}
