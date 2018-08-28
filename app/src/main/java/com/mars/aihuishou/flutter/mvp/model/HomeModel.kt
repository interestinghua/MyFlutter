package com.mars.aihuishou.flutter.mvp.model

import com.mars.aihuishou.flutter.api.HomeDataApi
import com.mars.aihuishou.flutter.bean.SampleData
import com.mars.aihuishou.flutter.http.RetrofitHelper
import io.reactivex.Observable

class HomeModel {

    private val dataApi by lazy {
        RetrofitHelper.createApi(HomeDataApi::class.java)
    }

    fun getMovies(page: Int): Observable<SampleData>? {
        return dataApi?.getFirstHomeData(page, 10)
    }

}