import SwiftUI
import shared
import Location
import Theming
import Strings

struct LandingView: View {

    private let coloredNavAppearance = UINavigationBarAppearance()
    private let sdk = MealsSDK()

    init() {
        coloredNavAppearance.configureWithOpaqueBackground()
        coloredNavAppearance.backgroundColor = UIColor(ColorManager.appPrimary)
        coloredNavAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredNavAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        UINavigationBar.appearance().standardAppearance = coloredNavAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredNavAppearance
    }

    @ObservedObject var locationManager = LocationManager()

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                VStack {
                    HStack {
                        Spacer()
                        Text(Strings.LandingScreen.subheading)
                            .font(.headline)
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                    .padding()

                    if locationManager.status == .authorizedWhenInUse || locationManager.status == .authorizedAlways {
                        NavigationLink(destination: TabAppView(selectedView: 0)) {
                            CustomButton(
                                width: geometry.size.width,
                                buttonColor: ColorManager.appPrimary,
                                image: Strings.LandingScreen.Images.plus,
                                text: Strings.LandingScreen.plusButtonText
                            )
                        }

                        NavigationLink(destination: TabAppView(selectedView: 1)) {
                            CustomButton(
                                width: geometry.size.width,
                                buttonColor: ColorManager.appSecondary,
                                image: Strings.LandingScreen.Images.find,
                                text: Strings.LandingScreen.findButtonText
                            )
                        }
                    } else {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15) // move the radius
                                .foregroundColor(ColorManager.appPrimary)
                            VStack {
                                Spacer()
                                Image(systemName: Strings.LandingScreen.Images.exclamation)
                                    .resizable()
                                    .frame(width: geometry.size.width * 0.25, height: geometry.size.width * 0.25)
                                Spacer()
                                Text(Strings.LandingScreen.enableLocationText)
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                                Spacer()
                                Button(Strings.LandingScreen.settingsLinkText) {
                                    if let url = URL(string: UIApplication.openSettingsURLString) {
                                        if UIApplication.shared.canOpenURL(url) {
                                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                        }
                                    }
                                }
                                .foregroundColor(.blue)
                            }
                            .padding()
                        }
                        .foregroundColor(.white)
                        .padding(.init(top: padding(geometry.size.width)/2, leading: padding(geometry.size.width), bottom: padding(geometry.size.width), trailing: padding(geometry.size.width)))
                    }
                    }
                }
            }
            .navigationBarTitle(Text(Strings.LandingScreen.heading))
            .navigationBarBackButtonHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    func padding(_ width: CGFloat) -> CGFloat {
        width/10
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
