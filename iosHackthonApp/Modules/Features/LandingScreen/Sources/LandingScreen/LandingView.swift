import SwiftUI
import shared
import Location
import Theming
import Strings
import Components
import TabBar

public struct LandingView: View {

    private let sdk = MealsSDK()

    @ObservedObject private var locationManager = LocationManager()

    public init() {}

    public var body: some View {
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
                                             text: Strings.LandingScreen.enableLocationText,
                                             buttonText: Strings.LandingScreen.settingsLinkText)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle(Text(Strings.LandingScreen.heading))
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
