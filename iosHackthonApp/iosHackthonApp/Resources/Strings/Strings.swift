//
//  Strings.swift
//  iosHackthonApp
//
//  Created by Gareth Miller on 04/11/2020.
//  Copyright © 2020 orgName. All rights reserved.
//

import Foundation

struct Strings {
    struct LandingScreen {
        static let heading = "CommunityKitchen"
        static let subheading = "List a meal to help out someone in your local community or browse the meals that others have added"
        static let plusButtonText = "List a Meal"
        static let findButtonText = "Find a Meal"

        struct Images {
            static let plus = "plus.app"
            static let find = "magnifyingglass"
        }
    }

    struct AddMealScreen {
        static let title = "Title"
        static let additionalInfo = "Additional Information"
        static let quantity = "Quantity"
        static let temperature = "Temperature"
        static let hot = "Hot"
        static let cold = "Cold"
        static let availableFrom = "Available From"
        static let useBy = "Use By"
        static let address = "Address"
        static let addMeal = "Add A Meal"
        static let titlePlaceholder = "Enter a Title"
        static let additionalInfoPlaceholder = "Enter Additional Information"
        static let quantityPlaceholder = "Enter Quantity"


        struct CollectionAlert {
            static let message = "When someone arrives to collect this meal they will quote the above code"
        }
    }

    struct MealListScreen {
        static let title = "Meals in your area"
        static let portion = "portion remaining"
        static let portions = "portions remaining"
        static let available = "Available: "
        static let expiresAt = " Expires: "

        struct SegmentControl {
            static let map = "Map"
            static let list = "List"
        }

        struct Map {
            static let missing = "Missing place information"
            static let reserved = "All meals reserved"
        }

        struct UnavailableAlert {
            static let message = "This meal is no longer available"
        }

        struct CollectionAlert {
            static let message = "When you go to collect this meal, you will be asked for the above code"
        }

        struct Button {
            static let disabledText = "Unavailable"
            static let enabledText = "Reserve a portion"
        }

        struct Images {
            static let hotFood = "bowl-black"
            static let coldFood = "salad-black"
            static let hotFoodGrey = "bowl-grey"
            static let coldFoodGrey = "salad-grey"
            static let info = "info.circle"
            static let location = "mappin.and.ellipse"
            static let fromTime = "clock"
            static let expireTime = "hourglass"
            static let quantity = "number"
            static let reload = "arrow.clockwise"
        }
    }

    struct Common {
        static let ok = "Ok"
        static let sorry = "Sorry!"
        static let km = "km"
        static let twoDecimal = "%.2f"
        static let unknown = "Unknown"

        struct ErrorAlert {
            static let message = "There was an error creating your meal.\n please try again"
        }

        struct Images {
            static let hotFood = "flame"
            static let coldFood = "snow"
            static let location = "location"
        }

        struct Date {
            static let americanFormat = "yyyy-MM-dd' 'HH:mm:ssZ"
            static let nameDayMonth = "E d MMM"
        }
    }
}
