package com.mars.aihuishou.flutter.activity.adapter

import android.content.Context
import android.support.v4.app.Fragment
import android.support.v4.app.FragmentManager
import android.support.v4.app.FragmentPagerAdapter
import android.view.ViewGroup
import io.flutter.facade.FlutterFragment

class FragmentAdapter(manager: FragmentManager, context: Context,
                      titles: Array<String>, fragments: ArrayList<FlutterFragment>) : FragmentPagerAdapter(manager) {

    private var context: Context? = null
    private var titles = arrayOf<String>()
    private var fragments = arrayListOf<FlutterFragment>()

    init {
        this.context = context
        this.titles = titles
        this.fragments = fragments
    }

    override fun getItem(position: Int): Fragment = fragments[position]

    override fun getCount(): Int = titles.size

    override fun getPageTitle(position: Int): CharSequence = titles[position]

    override fun instantiateItem(container: ViewGroup, position: Int): Any {
//        return super.instantiateItem(container, position)
        val fragment = super.instantiateItem(container, position)
        return fragment
    }

}