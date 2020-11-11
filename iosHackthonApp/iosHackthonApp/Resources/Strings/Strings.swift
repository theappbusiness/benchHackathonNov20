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

		struct Images {
			static let hotFood = "flame"
			static let coldFood = "snow"
			static let location = "location"
		}

	}
}


