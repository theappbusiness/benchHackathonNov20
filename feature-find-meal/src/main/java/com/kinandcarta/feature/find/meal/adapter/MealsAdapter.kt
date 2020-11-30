package com.kinandcarta.feature.find.meal.adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.TextView
import androidx.core.content.ContextCompat
import androidx.core.view.isVisible
import androidx.recyclerview.widget.RecyclerView
import com.kcc.kmmhackathon.shared.entity.Meal
import com.kcc.kmmhackathon.shared.utility.DistanceUnit
import com.kcc.kmmhackathon.shared.utility.extensions.getPortionsString
import com.kinandcarta.feature.find.meal.R
import com.kinandcarta.feature.find.meal.viewmodel.Meals

class MealsAdapter(
    private var mealsList: List<Meal> = listOf(),
    private var distanceUnit: DistanceUnit = DistanceUnit.miles,
    private val clickListener: (String, Int) -> Unit
) :
    RecyclerView.Adapter<MealsAdapter.MealsViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int) =
        LayoutInflater.from(parent.context)
            .inflate(R.layout.meal_item_row, parent, false)
            .run(::MealsViewHolder)

    override fun getItemCount(): Int {
        return mealsList.size
    }

    override fun onBindViewHolder(holder: MealsViewHolder, position: Int) {
        holder.bindData(mealsList[position], position)
    }

    fun submit(meals: Meals, unit: DistanceUnit) {
        mealsList = meals
        distanceUnit = unit
        notifyDataSetChanged()
    }

    inner class MealsViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        private val nameView = itemView.findViewById<TextView>(R.id.mealName)
        private val tempView = itemView.findViewById<TextView>(R.id.mealTemp)
        private val infoView = itemView.findViewById<TextView>(R.id.mealInfo)
        private val distanceView = itemView.findViewById<TextView>(R.id.mealDistance)
        private val availableView = itemView.findViewById<TextView>(R.id.mealAvailable)
        private val expiryView = itemView.findViewById<TextView>(R.id.mealExpiry)
        private val portionsView = itemView.findViewById<TextView>(R.id.mealPortions)
        private val reserveButton = itemView.findViewById<Button>(R.id.reserveButton)

        fun bindData(meal: Meal, position: Int) {
            nameView.text = meal.name
            val tempString = if (meal.hot) "Hot" else "Cold"
            val tempColor = if (meal.hot) R.color.colorHot else R.color.colorCold
            tempView.text = tempString
            tempView.setTextColor(ContextCompat.getColor(itemView.context, tempColor))

            if (meal.info.isNullOrEmpty()) {
                infoView.isVisible = false
            } else {
                infoView.text = "Info: ${meal.info}"
            }

            distanceView.text = "${meal.distance} ${distanceUnit}"

            availableView.text = "Available: ${meal.availableFromDate}"
            expiryView.text = "Expires: ${meal.expiryDate}"

            portionsView.text = "#    ${meal.quantity.getPortionsString()}"

            val hasPortions = meal.quantity > 0
            val reserveButtonText = if (hasPortions) "Reserve a portion" else "Unavailable"
            val reserveButtonColor =
                if (hasPortions) R.color.colorReserve else R.color.colorUnavailable
            reserveButton.text = reserveButtonText
            reserveButton.setBackgroundColor(
                ContextCompat.getColor(
                    itemView.context,
                    reserveButtonColor
                )
            )

            if (hasPortions) {
                reserveButton.setOnClickListener {
                    clickListener(meal.id, position)
                }
            } else {
                reserveButton.setOnClickListener(null)
            }
        }
    }
}
