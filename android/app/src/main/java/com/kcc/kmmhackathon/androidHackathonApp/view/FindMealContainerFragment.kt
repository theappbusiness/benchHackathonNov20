package com.kcc.kmmhackathon.androidHackathonApp.view

import android.content.Intent
import android.os.Bundle
import android.view.*
import androidx.fragment.app.Fragment
import com.kcc.kmmhackathon.androidHackathonApp.R
import com.kinandcarta.lib.add.meal.view.AddMealFragment
import kotlinx.coroutines.Dispatchers.Main

class FindMealContainerFragment : Fragment() {

    companion object {
        fun newInstance() = FindMealContainerFragment()
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setHasOptionsMenu(true)
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val view = inflater.inflate(R.layout.find_meal_container_fragment, container, false)
        val fragment = com.kinandcarta.feature.find.meal.view.MapsFragment()
        childFragmentManager.beginTransaction().apply {
            add(R.id.child_fragment_container, fragment)
            commit()
        }
        return view
    }

    override fun onCreateOptionsMenu(menu: Menu, inflater: MenuInflater) {
        super.onCreateOptionsMenu(menu, inflater)

        inflater.inflate(R.menu.find_meal_container_menu, menu)
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        return when (item.itemId) {
            R.id.add_an_item -> {
                val intent = Intent(activity, AddMealActivity::class.java)
                startActivity(intent)
                true
            }
            else -> {
                super.onOptionsItemSelected(item)
            }
        }
    }

}