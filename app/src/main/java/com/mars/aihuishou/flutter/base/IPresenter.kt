package com.mars.aihuishou.flutter.base

interface IPresenter<in V : IView> {

    //定义网络请求方法
    fun attachView(rootView: V) //绑定activity或者fragment和presenter

    fun detachView()

}