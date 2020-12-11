package com.kinandcarta.lib.add.meal.view

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.compose.ui.platform.setContent
import androidx.fragment.app.Fragment
import androidx.fragment.app.viewModels
import com.kinandcarta.lib.add.meal.R
import com.kinandcarta.lib.add.meal.ui.*
import com.kinandcarta.lib.add.meal.viewmodel.AddMealViewModel


class AddMealFragment : Fragment() {

    companion object {
        fun newInstance() = AddMealFragment()
    }

    private val viewModel: AddMealViewModel by viewModels()

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val fragmentView =  inflater.inflate(R.layout.add_meal_fragment, container, false)

        (fragmentView as ViewGroup).setContent {
            CommunityKitchenTheme {
                AddMealScreen(
                    addMealViewModel = viewModel,
                    context = fragmentView.context
                )
            }
        }

        return fragmentView
    }

}
