package com.kcc.kmmhackathon.androidHackathonApp

import android.R.attr.button
import android.annotation.TargetApi
import android.content.Context
import android.text.Spannable
import android.text.SpannableString
import android.text.style.BackgroundColorSpan
import android.util.AttributeSet
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.TextView
import androidx.annotation.Nullable

class ActionButton : LinearLayout {
    constructor(context: Context) : super(context) {
        inflateLayout(context)
    }

    constructor(context: Context, @Nullable attrs: AttributeSet?) : super(
            context,
            attrs,
    ) {
        inflateLayout(context)
    }

    constructor(
            context: Context,
            @Nullable attrs: AttributeSet?,
            defStyleAttr: Int
    ) : super(context, attrs, defStyleAttr) {
        inflateLayout(context)
    }

    private fun inflateLayout(context: Context) {
        inflate(context, R.layout.action_button, this)
    }

    override fun onFinishInflate() {
        super.onFinishInflate()
        val textView = findViewById<TextView>(R.id.button_text)
        makeSpannable(textView)
    }

    private fun makeSpannable(textView: TextView) {
        val spannable: Spannable = SpannableString(textView.text)
        spannable.setSpan(
                BackgroundColorSpan(-0xffdf),
                0,
                textView.text.length,
                Spannable.SPAN_EXCLUSIVE_EXCLUSIVE
        )
        textView.text = spannable
        invalidate()
    }

    fun setIcon(resourceId: Int) {
       val iconView = findViewById<ImageView>(R.id.button_image)
        iconView.setImageResource(resourceId)
    }

    fun setText(textId: Int) {
        val textView = findViewById<TextView>(R.id.button_text)
        textView.setText(textId)
    }
}