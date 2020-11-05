import SwiftUI
import shared

struct LandingView: View {

    private var viewModel = ViewModel()

    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack{
                    Spacer()
                    Text(Strings.LandingScreen.heading)
                        .font(.title)
                    Spacer()
                }

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

                Button(action: {
                    #warning("TODO: launch MealList Screen")
                })  {
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
}

extension LandingView {
    struct ViewModel {
        let cornerRadius: CGFloat = 16
        let paddingRatio: CGFloat = 0.12
        let imageFrameRatio: CGFloat = 0.25
        let shadowRadius: CGFloat = 5
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
