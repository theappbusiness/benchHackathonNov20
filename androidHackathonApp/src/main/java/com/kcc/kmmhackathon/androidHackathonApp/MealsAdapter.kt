package com.kcc.kmmhackathon.androidHackathonApp

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.kcc.kmmhackathon.androidHackathonApp.data.Meal

class MealsAdapter (private val mealsList: List<Meal>) : RecyclerView.Adapter<MealsAdapter.ViewHolder>() {

    inner class ViewHolder(listItemView: View) : RecyclerView.ViewHolder(listItemView) {
        val nameTextView = itemView.findViewById<TextView>(R.id.meal_name)
        val idTextView = itemView.findViewById<TextView>(R.id.meal_id)
        val tempTextView = itemView.findViewById<TextView>(R.id.meal_temperature)
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): MealsAdapter.ViewHolder {
        val context = parent.context
        val inflater = LayoutInflater.from(context)
        val contactView = inflater.inflate(R.layout.meal_item_row, parent, false)
        return ViewHolder(contactView)
    }

    override fun onBindViewHolder(viewHolder: MealsAdapter.ViewHolder, position: Int) {
        val meal: Meal = mealsList.get(position)
        val nameTextView = viewHolder.nameTextView
        val idTextView = viewHolder.idTextView
        val tempTextView = viewHolder.tempTextView

        val tempText = if (meal.isHot) "Hot" else "Cold"

        nameTextView.setText(meal.name)
        idTextView.setText(meal.id)
        tempTextView.setText(tempText)
    }

    override fun getItemCount(): Int {
        return mealsList.size
    }
}