import SwiftUI
import shared

struct LandingView: View {

    private let sdk = MealsSDK()

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

                    NavigationLink(destination: AddMealView(viewModel: .init(sdk: sdk))) {
                        CustomButton(
                            width: geometry.size.width,
                            foreGroundColor: ColorManager.appPrimary,
                            image: Strings.LandingScreen.Images.plus,
                            text: Strings.LandingScreen.plusButtonText)
                    }

                    NavigationLink(destination: MealListView(viewModel: .init(sdk: sdk))) {
                        CustomButton(
                            width: geometry.size.width,
                            foreGroundColor: ColorManager.appSecondary,
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
