//
//  AddMealView.swift
//  iosHackthonApp
//
//  Created by Gareth Miller on 09/11/2020.
//  Copyright © 2020 orgName. All rights reserved.
//

import SwiftUI
import shared

struct AddMealView: View {
	var body: some View {
		//TODO: Pass the actual values when UI is complete
		let sdk = PostMealApi()
		let meal = Meal(id: "\(sdk.getUUID())",
										name: "Pizza",
										quantity: 2,
										availableFromDate: "Tuesday",
										expiryDate: "Saturday",
										info: "Meat",
										hot: false,
										locationLat: 51.509865,
										locationLong:  -0.118092)
		Button("Add a meal") {
			sdk.postMeal(meal: meal, completionHandler: { response,test  in
				print("Response \(response)")

			})
		}
	}
}

struct AddMealView_Previews: PreviewProvider {
    static var previews: some View {
        AddMealView()
    }
}
