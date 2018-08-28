package com.mars.aihuishou.flutter.activity

import com.mars.aihuishou.flutter.mvp.view.HomeView
import io.flutter.facade.FlutterFragment

class HomeFragment : FlutterFragment(), HomeView {

    override fun getDataSuccess(movieJson: String) {
    }

    override fun getDataFail(failMsg: String) {
    }

}