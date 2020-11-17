import SwiftUI
import shared
import Location
import Theming
import Strings
import Components
import TabBar

public struct LandingView: View {

    private let coloredNavAppearance = UINavigationBarAppearance()
    private let sdk = MealsSDK()

    public init() {
        coloredNavAppearance.configureWithOpaqueBackground()
        coloredNavAppearance.backgroundColor = UIColor(ColorManager.appPrimary)
        coloredNavAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredNavAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        UINavigationBar.appearance().standardAppearance = coloredNavAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredNavAppearance
    }

    @ObservedObject var locationManager = LocationManager()

    public var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    if locationManager.status == .authorizedWhenInUse || locationManager.status == .authorizedAlways {
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
                        LocationNeededMessageBox(width: geometry.size.width,
                                           buttonColor: ColorManager.appPrimary,
                                           image: Strings.LandingScreen.Images.exclamation,
                                           text: Strings.LandingScreen.enableLocationText)
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
