package com.kinandcarta.lib.add.meal

import androidx.lifecycle.viewModelScope
import com.kcc.kmmhackathon.shared.entity.Meal
import com.kinandcarta.lib.add.meal.network.MealSDKRepository
import com.kinandcarta.lib.add.meal.viewmodel.AddMealViewModel
import io.mockk.coEvery
import io.mockk.coVerify
import io.mockk.impl.annotations.RelaxedMockK
import io.mockk.mockk
import kotlinx.coroutines.*
import kotlinx.coroutines.test.*
import org.junit.After
import org.junit.Test
import org.junit.Assert.*
import org.junit.Before
import java.time.LocalDate
import java.time.Month

/**
 * Instrumented test, which will execute on an Android device.
 *
 * See [testing documentation](http://d.android.com/tools/testing).
 */

class AddMealViewModelTest {

    private val mainThreadSurrogate = newSingleThreadContext("UI thread")

    lateinit var subject: AddMealViewModel

    @RelaxedMockK
    lateinit var mealSDKRepository: MealSDKRepository

    @Before
    fun setUp() {
        Dispatchers.setMain(mainThreadSurrogate)
        mealSDKRepository = mockk<MealSDKRepository>()
        subject = AddMealViewModel(mealSDKRepository = mealSDKRepository)
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
        val expected = LocalDate.of(2020, Month.DECEMBER, 1)
        subject.onEditAvailableFrom(expected)

        assertEquals(expected, subject.meal.availableFrom)
        assertEquals(AddMealViewModel.State.Initial, subject.state)
    }

    @Test
    fun test_whenOnEditUseBy_then_updateUseBy() {
        val expected = LocalDate.of(2020, Month.DECEMBER, 1)
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

    @Test
    fun test_whenSubmit_and_returnsSuccess_then_updateStateToSuccess() {
        val expectedMeal = Meal(
            id = "id",
            name = "name",
            quantity = 4,
            availableFromDate = "From",
            expiryDate = "To",
            info = "info",
            hot = true,
            locationLat = 42.0f,
            locationLong = -42.0f,
        )
        subject.viewModelScope.launch {
            coEvery { mealSDKRepository.postMeal(expectedMeal) } returns expectedMeal
            assertEquals(AddMealViewModel.State.Initial, subject.state)
            subject.onSubmit()
            coVerify { mealSDKRepository.postMeal(expectedMeal) }
            assertEquals(AddMealViewModel.State.Success, subject.state)
        }
    }

    @Test
    fun test_whenSubmit_and_returnsFailed_then_updateStateToFailed() {
        val expectedMeal = Meal(
            id = "id",
            name = "name",
            quantity = 4,
            availableFromDate = "From",
            expiryDate = "To",
            info = "info",
            hot = true,
            locationLat = 42.0f,
            locationLong = -42.0f,
        )
        subject.viewModelScope.launch {
            coEvery { mealSDKRepository.postMeal(expectedMeal) } throws Exception("Test")
            assertEquals(AddMealViewModel.State.Initial, subject.state)
            subject.onSubmit()
            coVerify { mealSDKRepository.postMeal(expectedMeal) }
            assertEquals(AddMealViewModel.State.Failed, subject.state)
        }
    }

}