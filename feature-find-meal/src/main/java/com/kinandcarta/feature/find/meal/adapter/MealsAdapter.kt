package com.kinandcarta.feature.find.meal.adapter

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.core.content.ContextCompat
import androidx.core.view.isVisible
import androidx.recyclerview.widget.ListAdapter
import androidx.recyclerview.widget.RecyclerView
import com.kcc.kmmhackathon.shared.entity.Meal
import com.kcc.kmmhackathon.shared.utility.DistanceUnit
import com.kinandcarta.feature.find.meal.R
import com.kinandcarta.feature.find.meal.databinding.MealItemRowBinding
import com.kinandcarta.feature.find.meal.extension.getPortionsString

class MealsAdapter(
    private var distanceUnit: DistanceUnit = DistanceUnit.miles,
    private val clickListener: (String, Int) -> Unit
) : ListAdapter<Meal, MealsAdapter.MealsViewHolder>(MealDiffCallback()) {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): MealsViewHolder {
       val itemBinding = MealItemRowBinding.inflate(
           LayoutInflater.from(parent.context), parent, false)
        return MealsViewHolder(itemBinding)
    }

    override fun onBindViewHolder(holder: MealsViewHolder, position: Int) {
        val item = getItem(position)
        holder.bindData(item, position)
    }

    inner class MealsViewHolder(private val itemBinding: MealItemRowBinding): RecyclerView.ViewHolder(itemBinding.root) {

        fun bindData(meal: Meal, position: Int) {
            itemBinding.mealName.text = meal.name
            setupMealTemp(meal.hot)
            setupMealInfo(meal.info)
            itemBinding.mealDistance.text = "${meal.distance} ${distanceUnit}"
            itemBinding.mealAvailable.text = "Available: ${meal.availableFromDate}"
            itemBinding.mealExpiry.text = "Expires: ${meal.expiryDate}"
            itemBinding.mealPortions.text = "#    ${meal.quantity.getPortionsString()}"
            setupReserveButton(meal.quantity, meal.id, position)
        }

        private fun setupMealTemp(isHot: Boolean) {
            val tempString = if (isHot) "Hot" else "Cold"
            val tempColor = if (isHot) R.color.colorHot else R.color.colorCold
            itemBinding.mealTemp.text = tempString
            itemBinding.mealTemp.setTextColor(ContextCompat.getColor(itemBinding.root.context, tempColor))
        }

        private fun setupMealInfo(info: String?) {
            if (info.isNullOrEmpty()) {
                itemBinding.mealInfo.isVisible = false
            } else {
                itemBinding.mealInfo.text = "Info: ${info}"
            }
        }


        private fun setupReserveButton(quantity: Int, mealId: String, position: Int) {
            val hasPortions = quantity > 0
            val reserveButton = itemBinding.reserveButton

            reserveButton.text = if (hasPortions) "Reserve a portion" else "Unavailable"

            val reserveButtonColor = if (hasPortions) R.color.colorReserve else R.color.colorUnavailable
            reserveButton.setBackgroundColor(ContextCompat.getColor(itemBinding.root.context, reserveButtonColor))

            if (hasPortions) {
                reserveButton.setOnClickListener {
                    clickListener(mealId, position)
                }
            } else {
                reserveButton.setOnClickListener(null)
            }
        }
    }
}

