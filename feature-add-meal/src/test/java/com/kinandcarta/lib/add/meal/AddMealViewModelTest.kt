package com.kinandcarta.lib.add.meal

import com.kinandcarta.lib.add.meal.viewmodel.AddMealViewModel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.newSingleThreadContext
import kotlinx.coroutines.runBlocking
import kotlinx.coroutines.test.resetMain
import kotlinx.coroutines.test.setMain
import org.junit.After
import org.junit.Test
import org.junit.Assert.*
import org.junit.Before
import java.time.LocalDateTime
import java.time.Month

/**
 * Instrumented test, which will execute on an Android device.
 *
 * See [testing documentation](http://d.android.com/tools/testing).
 */

class AddMealViewModelTest {

    private val mainThreadSurrogate = newSingleThreadContext("UI thread")

    var subject: AddMealViewModel = AddMealViewModel()

    @Before
    fun setUp() {
        Dispatchers.setMain(mainThreadSurrogate)
    }

    @After
    fun tearDown() {
        Dispatchers.resetMain() // reset main dispatcher to the original Main dispatcher
        mainThreadSurrogate.close()
    }

    @Test
    fun test_whenEditTitle_then_updateMealFormTitle() {
        val expected = "New Title"
        subject.onEditTitle(expected)

        assertEquals(expected, subject.meal.title)
        assertEquals(AddMealViewModel.State.Initial, subject.state)
    }


    @Test
    fun test_whenEditAdditionalInformation_then_updateMealFormAadditionalInformation() {
        val expected = "New Additional Information"
        subject.onEditAdditionalInformation(expected)

        assertEquals(expected, subject.meal.additionalInformation)
        assertEquals(AddMealViewModel.State.Initial, subject.state)
    }

    @Test
    fun test_whenEditQuantity_then_updateQuantity() {
        val expected = "42"
        subject.onEditQuantity(expected)

        assertEquals(expected, subject.meal.quantity)
        assertEquals(AddMealViewModel.State.Initial, subject.state)
    }

    @Test
    fun test_whenEditTemperature_then_updateTemperature() {
        val expected = false
        subject.onEditTemperature(false)

        assertEquals(expected, subject.meal.isHot)
        assertEquals(AddMealViewModel.State.Initial, subject.state)
    }

    @Test
    fun test_whenEditAddress_then_updateAddress() {
        val expected = "K+C Create Europe, 71 Collier Street, London N1 9BE"
        subject.onEditAddress(expected)

        assertEquals(expected, subject.meal.address)
        assertEquals(AddMealViewModel.State.Initial, subject.state)
    }

    @Test
    fun test_whenOnEditAvailableFrom_then_updateAvailableFrom() {
        val expected = LocalDateTime.of(2020, Month.DECEMBER, 1, 9, 42)
        subject.onEditAvailableFrom(expected)

        assertEquals(expected, subject.meal.availableFrom)
        assertEquals(AddMealViewModel.State.Initial, subject.state)
    }

    @Test
    fun test_whenOnEditUseBy_then_updateUseBy() {
        val expected = LocalDateTime.of(2020, Month.DECEMBER, 1, 9, 42)
        subject.onEditUseBy(expected)

        assertEquals(expected, subject.meal.useBy)
        assertEquals(AddMealViewModel.State.Initial, subject.state)
    }

    @Test
    fun test_whenSubmit_then_updateStateToLoading() {
        runBlocking {
            launch(Dispatchers.Main) {
                assertEquals(AddMealViewModel.State.Initial, subject.state)
                subject.onSubmit()
                assertEquals(AddMealViewModel.State.Loading, subject.state)
            }
        }
    }
}