package com.example.flutter_text

/**
 * Handle remote input and dispatch android gesture
 *
 * Inspired by [droidVNC-NG] https://github.com/bk138/droidVNC-NG
 */

import android.accessibilityservice.AccessibilityService
import android.accessibilityservice.AccessibilityServiceInfo
import android.accessibilityservice.GestureDescription
import android.graphics.Path
import android.os.Build
import android.util.Log
import android.view.accessibility.AccessibilityEvent
import androidx.annotation.RequiresApi
import kotlin.math.max


const val LIFT_DOWN = 9
const val LIFT_MOVE = 8
const val LIFT_UP = 10
const val RIGHT_UP = 18
const val WHEEL_BUTTON_DOWN = 33
const val WHEEL_BUTTON_UP = 34
const val WHEEL_DOWN = 523331
const val WHEEL_UP = 963

const val TOUCH_SCALE_START = 1
const val TOUCH_SCALE = 2
const val TOUCH_SCALE_END = 3
const val TOUCH_PAN_START = 4
const val TOUCH_PAN_UPDATE = 5
const val TOUCH_PAN_END = 6

const val WHEEL_STEP = 120
const val WHEEL_DURATION = 50L
const val LONG_TAP_DELAY = 200L

val SCREEN_INFO = Info(0, 0, 1, 200)

data class Info(
        var width: Int, var height: Int, var scale: Int, var dpi: Int
)

class InputService : AccessibilityService() {

    companion object {
        var ctx: InputService? = null
        val isOpen: Boolean
            get() = ctx != null
    }

    private val logTag = "input service"
    private var touchPath = Path()
    private var lastTouchGestureStartTime = 0L

    @RequiresApi(Build.VERSION_CODES.N)
    fun onTouchInput(mask: Int, _x: Int, _y: Int) {
        when (mask) {
            TOUCH_PAN_UPDATE -> {
                continueGesture(_x, _y)
            }
            TOUCH_PAN_START -> {
                startGesture(_x, _y)
            }
            TOUCH_PAN_END -> {
                endGesture(_x, _y)
            }
            else -> {}
        }
    }

    private fun startGesture(x: Int, y: Int) {
        touchPath = Path()
        touchPath.moveTo(x.toFloat(), y.toFloat()) // moveTo起点
        lastTouchGestureStartTime = System.currentTimeMillis()
    }

    private fun continueGesture(x: Int, y: Int) {
        touchPath.lineTo(x.toFloat(), y.toFloat())
    }

    @RequiresApi(Build.VERSION_CODES.N)
    private fun endGesture(x: Int, y: Int) {
        Log.d(logTag, "endGesture x:$x y:$y")
        try {
            touchPath.lineTo(x.toFloat(), y.toFloat()) // lineTo终点
            var duration = System.currentTimeMillis() - lastTouchGestureStartTime
            if (duration <= 0) {
                duration = 100
            }
            val stroke = GestureDescription.StrokeDescription(
                    touchPath,
                    0,
                    duration
            )
            val builder = GestureDescription.Builder()
            builder.addStroke(stroke)
            dispatchGesture(builder.build(), null, null)
            Log.d(logTag, "end gesture x:$x y:$y time:$duration")
        } catch (e: Exception) {
            Log.e(logTag, "endGesture error:$e")
        }
    }

    fun physicGesture(action:Int) {
        try {
            performGlobalAction(action);
        } catch (err:Exception) {
            Log.e(logTag, "physicGesture error: $err")
        }
    }


    override fun onDestroy() {
        ctx = null
        super.onDestroy()
    }

    override fun onAccessibilityEvent(event: AccessibilityEvent) {
        Log.d(logTag, "$event")
    }

    override fun onServiceConnected() {
        super.onServiceConnected()
        ctx = this;
        val info = AccessibilityServiceInfo()
        if (Build.VERSION.SDK_INT >= 33) {
            info.flags = AccessibilityServiceInfo.FLAG_INPUT_METHOD_EDITOR or AccessibilityServiceInfo.FLAG_RETRIEVE_INTERACTIVE_WINDOWS
        } else {
            info.flags = AccessibilityServiceInfo.FLAG_RETRIEVE_INTERACTIVE_WINDOWS
        }
        setServiceInfo(info)
        Log.d(logTag, "fakeEditTextForTextStateCalculation layout:$ctx")
        Log.d(logTag, "onServiceConnected!")
    }

    override fun onInterrupt() {}
}
