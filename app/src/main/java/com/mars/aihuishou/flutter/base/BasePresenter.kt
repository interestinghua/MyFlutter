package com.mars.aihuishou.flutter.base

import io.reactivex.disposables.CompositeDisposable
import io.reactivex.disposables.Disposable

open class BasePresenter<V : IView> : IPresenter<V> {

    var rootView: V? = null
        private set

    private var disposables = CompositeDisposable()

    override fun attachView(rootView: V) {
        this.rootView = rootView
    }

    override fun detachView() {
        rootView = null
        if (disposables.isDisposed) {
            disposables.clear()
        }
    }

    fun addSubscription(disposable: Disposable) {
        disposables.add(disposable)
    }
}