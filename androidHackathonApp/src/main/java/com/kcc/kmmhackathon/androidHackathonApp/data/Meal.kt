package com.kcc.kmmhackathon.androidHackathonApp.data

class Meal (val name: String, val id: String, val isHot: Boolean) {

        companion object {
            private var lastMealId = 0
            fun createMealList(numMeals: Int) : ArrayList<Meal> {
                val contacts = ArrayList<Meal>()
                for (i in 1..numMeals) {
                    contacts.add(Meal("Meal " + ++lastMealId, "${lastMealId}", i <= numMeals / 2))
                }
                return contacts
            }
        }
}