import SwiftUI
import shared

struct LandingView: View {

	private let sdk = MealsSDK()
	private let locationManager = LocationManager()

	var body: some View {
		NavigationView {
			GeometryReader { geometry in
				VStack {
					HStack {
						Spacer()
						Text(Strings.LandingScreen.subheading)
							.font(.subheadline)
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
	}
}

struct LandingView_Previews: PreviewProvider {
	static var previews: some View {
		LandingView()
	}
}
