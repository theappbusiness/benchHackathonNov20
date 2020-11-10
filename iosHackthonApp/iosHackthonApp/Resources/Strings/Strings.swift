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
        static let heading = "Welcome!"
        static let subheading = "List a meal to help out someone in your local community or browse the meals that others have added"
        static let plusButtonText = "List a Meal"
        static let findButtonText = "Find a Meal"

        struct Images {
            static let plus = "plus.app"
            static let find = "magnifyingglass"
        }
    }

    struct AddMealScreen {
        struct CollectionAlert {
            static let message = "When someone arrives to collect this meal they will quote the above code"
        }
    }

    struct Common {
        struct ErrorAlert {
            static let message = "There was an error creating your meal.\n please try again"
        }
        static let ok = "Ok"
        static let sorry = "Sorry!"
    }
}


