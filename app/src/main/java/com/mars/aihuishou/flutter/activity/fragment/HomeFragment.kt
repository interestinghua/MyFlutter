package com.mars.aihuishou.flutter.activity.fragment

import android.app.ProgressDialog
import android.os.Bundle
import android.view.View
import android.widget.Toast
import com.mars.aihuishou.flutter.mvp.model.HomeModel
import com.mars.aihuishou.flutter.mvp.presenter.HomePresenter
import com.mars.aihuishou.flutter.mvp.view.HomeView
import io.flutter.facade.FlutterFragment
import io.flutter.plugin.common.MethodChannel
import io.flutter.view.FlutterView

class HomeFragment : FlutterFragment(), HomeView {

    private val dialog by lazy {
        ProgressDialog(activity)
    }

    private var dataJson = ""

    private val presenter by lazy {
        HomePresenter(HomeModel())
    }

    companion object {
        val PULL_CHANNEL = "sample.flutter.io/pull_home"

        fun newInstance(route: String): HomeFragment {
            val fragment = HomeFragment()
            val args = Bundle()
            args.putString(FlutterFragment.ARG_ROUTE, route)
            fragment.arguments = args
            return fragment
        }
    }

    fun getDataJson(): String {
        return dataJson
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        presenter.attachView(this)
        dialog.show()
        presenter.getMoviesData(1)

        MethodChannel(view as FlutterView, PULL_CHANNEL).setMethodCallHandler { methodCall, result ->
            run {
                if (methodCall.method.equals("getDataJson")) {
                    val json = getDataJson()
                    result.success(json)
                } else {
                    result.notImplemented()
                }
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }

    override fun getDataSuccess(movieJson: String) {
        dialog.dismiss()
        this.dataJson = movieJson
    }

    override fun getDataFail(failMsg: String) {
        dialog.dismiss()
        Toast.makeText(context, failMsg, Toast.LENGTH_LONG).show()
    }

}