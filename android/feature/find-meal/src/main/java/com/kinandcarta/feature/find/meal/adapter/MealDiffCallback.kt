package com.kinandcarta.feature.find.meal.adapter

import androidx.recyclerview.widget.DiffUtil
import com.kcc.kmmhackathon.shared.entity.Meal

class MealDiffCallback : DiffUtil.ItemCallback<Meal>() {
    override fun areItemsTheSame(oldItem: Meal, newItem: Meal): Boolean {
        return oldItem.id == newItem.id
    }

    override fun areContentsTheSame(oldItem: Meal, newItem: Meal): Boolean {
        return oldItem == newItem
    }
}