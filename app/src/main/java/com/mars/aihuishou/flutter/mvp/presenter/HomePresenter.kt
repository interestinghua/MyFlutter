package com.mars.aihuishou.flutter.mvp.presenter

import com.google.gson.Gson
import com.mars.aihuishou.flutter.base.BasePresenter
import com.mars.aihuishou.flutter.http.DataTransformer
import com.mars.aihuishou.flutter.mvp.model.HomeModel
import com.mars.aihuishou.flutter.mvp.view.HomeView

//负责View和Model之间的交互 即HomeView和HomeModel之间的交互
class HomePresenter(private val homeModel: HomeModel) : BasePresenter<HomeView>() {

    fun getMoviesData(page: Int) {
        homeModel.getMovies(page)?.compose(DataTransformer.switchSchdulers())?.subscribe({ response ->
            rootView?.apply {
                getDataSuccess(Gson().toJson(response))
            }
        }, { error ->
            rootView?.apply {
                getDataFail(error.message.toString())
            }
        })
    }
}