package com.mars.aihuishou.flutter.mvp.view

import com.mars.aihuishou.flutter.base.IView

interface HomeView : IView {

    fun getDataSuccess(movieJson: String)
    fun getDataFail(failMsg: String)

}