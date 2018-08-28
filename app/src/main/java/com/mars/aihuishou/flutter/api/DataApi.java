package com.mars.aihuishou.flutter.api;

import com.mars.aihuishou.flutter.bean.SampleData;

import io.reactivex.Observable;
import retrofit2.http.GET;
import retrofit2.http.Query;

public interface DataApi {

    @GET("/news/list")
    Observable<SampleData> getFirstHomeData(@Query("pageIndex") Integer pageIndex, @Query("pageSize") Integer pageSize);

}
