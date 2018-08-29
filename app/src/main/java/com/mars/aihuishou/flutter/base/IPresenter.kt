package com.mars.aihuishou.flutter.base

interface IPresenter<in V : IView> {

    fun attachView(rootView: V) //绑定activity或者fragment和presenter
    fun detachView()

}