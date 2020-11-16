import SwiftUI
import shared
import Location
import Theming
import Strings

struct LandingView: View {

    let coloredNavAppearance = UINavigationBarAppearance()

    init() {
        coloredNavAppearance.configureWithOpaqueBackground()
        coloredNavAppearance.backgroundColor = UIColor(ColorManager.appPrimary)
        coloredNavAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredNavAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        UINavigationBar.appearance().standardAppearance = coloredNavAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredNavAppearance
    }

    private let sdk = MealsSDK()
    private let locationManager = LocationManager()

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    HStack {
                        Spacer()
                        Text(Strings.LandingScreen.subheading)
                            .font(.headline)
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                    .padding()

                    NavigationLink(destination: TabAppView(selectedView: 0)) {
                        CustomButton(
                            width: geometry.size.width,
                            buttonColor: ColorManager.appPrimary,
                            image: Strings.LandingScreen.Images.plus,
                            text: Strings.LandingScreen.plusButtonText)
                    }

                    NavigationLink(destination: TabAppView(selectedView: 1)) {
                        CustomButton(
                            width: geometry.size.width,
                            buttonColor: ColorManager.appSecondary,
                            image: Strings.LandingScreen.Images.find,
                            text: Strings.LandingScreen.findButtonText)
                    }
                }
            }
            .navigationBarTitle(Text(Strings.LandingScreen.heading))
            .navigationBarBackButtonHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
