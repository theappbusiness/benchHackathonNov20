import SwiftUI
import shared

struct LandingView: View {

    private var viewModel = Constants()
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

                    Button(action: {
                        #warning("TODO: launch AddMeal Screen")
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: viewModel.cornerRadius)
                                .foregroundColor(ColorManager.appPrimary)
                                .padding(geometry.size.width * viewModel.paddingRatio)
                                .shadow(radius: viewModel.shadowRadius)

                            VStack {

                                Image(systemName: Strings.LandingScreen.Images.plus)
                                    .resizable()
                                    .frame(width: geometry.size.width * viewModel.imageFrameRatio, height: geometry.size.width * viewModel.imageFrameRatio)
                                    .foregroundColor(.white)
                                Text(Strings.LandingScreen.plusButtonText)
                                    .foregroundColor(.white)
                            }
                        }
                    }

                    NavigationLink(destination: MealListView(viewModel: .init(sdk: sdk))) {
                        ZStack {
                            RoundedRectangle(cornerRadius: viewModel.cornerRadius)
                                .foregroundColor(ColorManager.appSecondary)
                                .padding(geometry.size.width * viewModel.paddingRatio)
                                .shadow(radius: viewModel.shadowRadius)
                            VStack {
                                Image(systemName: Strings.LandingScreen.Images.find)
                                    .resizable()
                                    .frame(width: geometry.size.width * viewModel.imageFrameRatio, height: geometry.size.width * viewModel.imageFrameRatio)
                                    .foregroundColor(.white)
                                Text(Strings.LandingScreen.findButtonText)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
            }
        }
        .navigationBarTitle(Text(Strings.LandingScreen.heading))
        .navigationBarBackButtonHidden(true)
    }
}

extension LandingView {
    struct Constants {
        let cornerRadius: CGFloat = 16
        let paddingRatio: CGFloat = 0.12
        let imageFrameRatio: CGFloat = 0.25
        let shadowRadius: CGFloat = 5
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
