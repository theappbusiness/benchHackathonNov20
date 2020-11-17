//
//  Strings.swift
//  iosHackthonApp
//
//  Created by Gareth Miller on 04/11/2020.
//  Copyright © 2020 orgName. All rights reserved.
//

import Foundation

public struct Strings { // TODO: these can all be public enums, plus public extensions will help reduce the need to add `public` everywhere
    public struct LandingScreen {
        public static let heading = "CommunityKitchen"
        public static let subheading = "Add a meal to help out someone in your local community or browse the meals that others have added"
        public static let plusButtonText = "Add a Meal"
        public static let findButtonText = "Find a Meal"
        public static let enableLocationText = "We will need access to your location in order to show you meals that are in your area.\n\nTo enable, tap the link below then navigate to:\n\nPrivacy\n↓\nLocation Services\n↓\nCommunityKitchen"
        public static let settingsLinkText = "Allow location"

        public struct Images {
            public static let plus = "plus.app"
            public static let find = "magnifyingglass"
            public static let exclamation = "exclamationmark.circle"
        }
    }

    public struct AddMealScreen {
        public static let title = "Title"
        public static let additionalInfo = "Additional Information"
        public static let quantity = "Quantity"
        public static let temperature = "Temperature"
        public static let hot = "Hot"
        public static let cold = "Cold"
        public static let availableFrom = "Available From"
        public static let useBy = "Use By"
        public static let address = "Address"
        public static let addMeal = "Add A Meal"
        public static let titlePlaceholder = "Enter a Title"
        public static let additionalInfoPlaceholder = "Enter Additional Information"
        public static let quantityPlaceholder = "Enter Quantity"


        public struct CollectionAlert {
            public static let message = "When someone arrives to collect this meal they will quote the above code"
        }
    }

    public struct MealListScreen {
        public static let title = "Meals in your area"
        public static let portion = "portion remaining"
        public static let portions = "portions remaining"
        public static let available = "Available: "
        public static let expiresAt = " Expires: "

        public struct SegmentControl {
            public static let map = "Map"
            public static let list = "List"
        }

        public struct Map {
            public static let missing = "Missing place information"
            public static let reserved = "All meals reserved"
        }

        public struct UnavailableAlert {
            public static let message = "This meal is no longer available"
        }

        public struct CollectionAlert {
            public static let message = "When you go to collect this meal, you will be asked for the above code"
        }

        public struct Button {
            public static let disabledText = "Unavailable"
            public static let enabledText = "Reserve a portion"
        }

        public struct Images {
            public static let hotFood = "bowl-black"
            public static let coldFood = "salad-black"
            public static let hotFoodGrey = "bowl-grey"
            public static let coldFoodGrey = "salad-grey"
            public static let info = "info.circle"
            public static let location = "mappin.and.ellipse"
            public static let fromTime = "clock"
            public static let expireTime = "hourglass"
            public static let quantity = "number"
            public static let reload = "arrow.clockwise"
        }
    }

    public struct Common {
        public static let ok = "Ok"
        public static let sorry = "Sorry!"
        public static let km = "km"
        public static let twoDecimal = "%.2f"
        public static let unknown = "Unknown"

        public struct ErrorAlert {
            public static let message = "There was an error creating your meal.\n please try again"
        }

        public struct Images {
            public static let hotFood = "flame"
            public static let coldFood = "snow"
            public static let location = "location"
        }

        public struct Date {
            public static let americanFormat = "yyyy-MM-dd' 'HH:mm:ssZ"
            public static let nameDayMonth = "E d MMM"
        }
    }
}
