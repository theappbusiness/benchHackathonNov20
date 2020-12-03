//
//  LoginView.swift
//  iosHackthonApp
//
//  Created by Raynelle Francisca on 16/11/2020.
//  Copyright © 2020 orgName. All rights reserved.
//

import SwiftUI
import shared
import Components
import Theming
import TabBar
import SignUp

public struct LoginView: View {

    @ObservedObject private var viewModel: LoginViewModel

    public init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        UINavigationBar.appearance().standardAppearance = self.viewModel.coloredNavAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = self.viewModel.coloredNavAppearance
    }

    public var body: some View {

        NavigationView {
            ScrollView {
                VStack {
                    Image("") // TODO: Add proper logo
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150, alignment: .center)
                        .border(Color.gray, width: 2)
                        .cornerRadius(10)
                }
                .padding()

                VStack(alignment: .leading, spacing: 10) {
                    Group {
                        Text(viewModel.emailTitle)
                        TextField(viewModel.emailPlaceholder, text: $viewModel.email)
                            .modifier(viewModel.textFieldStyle)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                        Text(viewModel.passwordTitle)
                        SecureField(viewModel.passwordPlaceholder, text: $viewModel.password)
                            .modifier(viewModel.textFieldStyle)
                        Spacer()

                        GeometryReader { geometry in
                            ZStack {
                                if viewModel.isLoading {
                                    ProgressView()
                                        .zIndex(1)
                                }

                                NavigationLink(destination: TabAppView(selectedView: 0), isActive: .constant(viewModel.authorizationStore.isAuthorised)) {
                                    Text("")
                                }
                                Button(action: {
                                    viewModel.login(email: viewModel.email, password: viewModel.password)
                                }) {
                                    Text(viewModel.loginButtonTitle)
                                        .modifier(AddButtonStyle(width: geometry.size.width, backgroundColor: viewModel.backgroundColor))
                                }
                                .disabled(viewModel.loginButtonIsDisabled)
                                .zIndex(0)
                            }
                        }
                    }
                }
                .padding()
                Spacer()
                VStack {
                    Spacer(minLength: 20)
                    GeometryReader { geometry in
                        NavigationLink(destination: SignUpView()) {
                            Text(viewModel.signupButtonTitle)
                                .frame(width: geometry.size.width, alignment: .center)
                                .foregroundColor(ColorManager.appPrimary)
                        }
                    }
                }
            }
            .navigationBarTitle(viewModel.title)
        }
        .onAppear() {
            viewModel.authorizationStore.isUserAuthorized()
        }
        .accentColor(.white)
        .alert(isPresented: $viewModel.showingAlert) {
            return Alert(
                title: Text(viewModel.alertTitle),
                message: Text(viewModel.alertMessage),
                dismissButton: .default(Text(viewModel.alertButton))
            )
        }
    }
}
