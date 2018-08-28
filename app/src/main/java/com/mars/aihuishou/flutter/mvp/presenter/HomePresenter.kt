package com.mars.aihuishou.flutter.mvp.presenter

import com.google.gson.Gson
import com.mars.aihuishou.flutter.base.BasePresenter
import com.mars.aihuishou.flutter.http.DataTransformer
import com.mars.aihuishou.flutter.mvp.model.HomeModel
import com.mars.aihuishou.flutter.mvp.view.HomeView

class HomePresenter(private val homeModel: HomeModel) : BasePresenter<HomeView>() {

    fun getMoviesData(page: Int) {
        homeModel.getMovies(page)?.compose(DataTransformer.switchSchdulers())?.subscribe({ sampleData ->
            rootView?.apply {
                getDataSuccess(Gson().toJson(sampleData))
            }
        }, { t ->
            rootView?.apply {
                getDataFail(t.message.toString())
            }
        })
    }
}