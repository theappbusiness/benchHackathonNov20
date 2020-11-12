package com.kcc.kmmhackathon.androidHackathonApp

import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.kcc.kmmhackathon.shared.entity.Meal

class MealsAdapter (var mealsList: List<Meal>) : RecyclerView.Adapter<MealsAdapter.ViewHolder>() {

    inner class ViewHolder(listItemView: View) : RecyclerView.ViewHolder(listItemView) {
        val nameTextView = itemView.findViewById<TextView>(R.id.meal_name)
        val idTextView = itemView.findViewById<TextView>(R.id.meal_id)
        val tempTextView = itemView.findViewById<TextView>(R.id.meal_temperature)
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): MealsAdapter.ViewHolder {
        val inflater = LayoutInflater.from(parent.context)
        val mealItemView = inflater.inflate(R.layout.meal_item_row, parent, false)
        return ViewHolder(mealItemView)
    }

    override fun onBindViewHolder(viewHolder: MealsAdapter.ViewHolder, position: Int) {
        val meal: Meal = mealsList.get(position)
        val nameTextView = viewHolder.nameTextView
        val idTextView = viewHolder.idTextView
        val tempTextView = viewHolder.tempTextView

        val tempText = if (meal.hot) "Hot" else "Cold"

        nameTextView.setText(meal.name)
        idTextView.setText(meal.id)
        tempTextView.setText(tempText)
    }

    override fun getItemCount(): Int {
        Log.i("MealsAdapter: ", "${mealsList.toString()}")
        return mealsList.size
    }
}