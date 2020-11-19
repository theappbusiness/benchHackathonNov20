package com.kinandcarta.lib.find.meal.adapter

import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.TextView
import androidx.core.content.ContextCompat
import androidx.core.view.isVisible
import androidx.recyclerview.widget.RecyclerView
import com.kcc.kmmhackathon.shared.entity.MealWithDistance
import com.kinandcarta.lib.find.meal.R
import com.kinandcarta.lib.find.meal.utility.DistanceUnit

class MealsAdapter(var mealsList: List<MealWithDistance>, var distanceUnit: DistanceUnit) :
    RecyclerView.Adapter<MealsAdapter.MealsViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int) =
        LayoutInflater.from(parent.context)
            .inflate(R.layout.meal_item_row, parent, false)
            .run(::MealsViewHolder)

    override fun getItemCount(): Int {
        return mealsList.size
    }

    override fun onBindViewHolder(holder: MealsViewHolder, position: Int) {
        holder.bindData(mealsList[position])
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

        fun bindData(item: MealWithDistance) {
            nameView.text = item.meal.name
            val tempString = if (item.meal.hot) "Hot" else "Cold"
            val tempColor = if (item.meal.hot) R.color.colorHot else R.color.colorCold
            tempView.text = tempString
            tempView.setTextColor(ContextCompat.getColor(itemView.context, tempColor))

            if (item.meal.info.isNullOrEmpty()) {
                infoView.isVisible = false
            } else {
                infoView.text = "Info: ${item.meal.info}"
            }

            distanceView.text = "${item.distance.toString()} ${distanceUnit}"

            availableView.text = "Available: ${parseDate(item.meal.availableFromDate)}"
            expiryView.text = "Expires: ${parseDate(item.meal.expiryDate)}"

            portionsView.text = getQuantityText(item.meal.quantity)

            val hasPortions = item.meal.quantity > 0
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
                    // TODO link up to sdk and adjust quantity and show user reservation code
                    val id = item.meal.id
                    val code = id.subSequence(id.length - 4, id.length)
                    Log.i("Reserve button tapped", "${item.meal.name} reservation code ${code}")
                }
            }
        }
    }

    fun parseDate(dateString: String): String {
        if (dateString.length > 8) {
            // TODO handle dates in kotlin
            val shortDate = dateString.slice(0..9)
            val dateArr = shortDate.split("-")
            return "${dateArr[2]} ${dateArr[1]} ${dateArr[0]}"
        }
        return dateString
    }

    fun getQuantityText(quantity: Int): String = when (quantity) {
        0 -> "#    Reserved"
        1 -> "#    $quantity portion remaining"
        else -> "#    $quantity portions remaining"
    }
}
