package com.mars.aihuishou.flutter.mvp.view

import com.mars.aihuishou.flutter.base.IView

interface HomeView : IView {

    override fun showDialog() {
    }

    override fun dismissDialog() {
    }

    fun getDataSuccess(movieJson: String)
    fun getDataFail(failMsg: String)

}