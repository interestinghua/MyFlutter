package com.mars.aihuishou.flutter.activity

import android.os.Bundle
import android.support.design.widget.TabLayout
import android.support.v7.app.AppCompatActivity
import com.mars.aihuishou.flutter.R
import com.mars.aihuishou.flutter.activity.adapter.FragmentAdapter
import com.mars.aihuishou.flutter.activity.fragment.DashboardFragment
import com.mars.aihuishou.flutter.activity.fragment.HomeFragment
import com.mars.aihuishou.flutter.activity.fragment.NotificationFragment
import kotlinx.android.synthetic.main.activity_demo.*

class DemoActivity : AppCompatActivity() {

    private val mTitles by lazy {
        arrayOf("Home", "Dashboard", "Notification")
    }

    private val mFragments by lazy {
        arrayListOf(
                HomeFragment.newInstance("app/home"),
                DashboardFragment.newInstance("app/dashboard"),
                NotificationFragment.newInstance("app/notification")
        )
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_demo)

        val adapter = FragmentAdapter(supportFragmentManager, this, mTitles, mFragments)

        viewPager.offscreenPageLimit = 3
        viewPager.adapter = adapter

        tabLayout.setupWithViewPager(viewPager)
        tabLayout.setTabsFromPagerAdapter(adapter)

        val listener = TabLayout.TabLayoutOnPageChangeListener(tabLayout)
        viewPager.addOnPageChangeListener(listener)
    }

}