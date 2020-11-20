package com.kcc.kmmhackathon.shared.utility

expect class DateKMM {
    constructor()

    constructor(time: Long)

    /**
     * Compare this instance with the other instance.
     *
     * @param other: Another date instance.
     * @return 0 if the other is equal to this instance; a value less than 0 if this instance is before the other;
     *          and a value greater than 0 if this instance is after the other.
     */
    fun compareTo(other: DateKMM): Int

    fun getTime(): Long
}