package com.ds.unity;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;

import androidx.annotation.Nullable;

import com.ds.unity.databinding.ActivityMainBinding;
import com.ds.unity.ui.MySplashView;
import com.igexin.base.api.GTSchedulerManager;
import com.tencent.smtt.utils.LogFileUtils;

import org.json.JSONObject;

import java.util.HashMap;

import io.dcloud.feature.sdk.DCUniMPSDK;
import io.dcloud.feature.sdk.Interface.IDCUniMPOnCapsuleMenuButtontCallBack;
import io.dcloud.feature.sdk.Interface.IMenuButtonClickCallBack;
import io.dcloud.feature.sdk.Interface.IOnUniMPEventCallBack;
import io.dcloud.feature.sdk.Interface.IUniMP;
import io.dcloud.feature.unimp.DCUniMPJSCallback;
import io.dcloud.feature.unimp.config.UniMPOpenConfiguration;

public class MainActivity extends Activity {
    private ActivityMainBinding mainBinding;
    private final String TAG = "unimp:";
    Context mContext;

    HashMap<String, IUniMP> mUniMPCaches = new HashMap<>();


    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        mContext = this;
        mainBinding = ActivityMainBinding.inflate(this.getLayoutInflater());
        setContentView(mainBinding.getRoot());
        Log.v(TAG,"on create");
        DCUniMPSDK.getInstance().setOnUniMPEventCallBack(new IOnUniMPEventCallBack() {
            @Override
            public void onUniMPEventReceive(String s, String s1, Object o, DCUniMPJSCallback dcUniMPJSCallback) {
                Log.i(TAG, "onUniMPEventReceive111: "+ s +"   11111=>"+ s1);
                Intent intent = new Intent("android.intent.action.UnityPlay");
                intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                DCUniMPSDK.getInstance().startActivityForUniMPTask(s, intent);

            }
        });

        DCUniMPSDK.getInstance().setDefMenuButtonClickCallBack(new IMenuButtonClickCallBack() {
            @Override
            public void onClick(String appid, String id) {
                Log.v("unimp:","on click ==>"+appid + "=====>"+id);
                switch (id) {
                    case "gy":{
                        Log.e("unimp:", "点击了关于" + appid);
                        //宿主主动触发事件
                        JSONObject data = new JSONObject();
                        try {
                            IUniMP uniMP = mUniMPCaches.get(appid);
                            if(uniMP != null) {
                                data.put("sj", "点击了关于");
                                uniMP.sendUniMPEvent("gy", data);
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                        break;
                    }
                    case "hqdqym" :{
                        IUniMP uniMP = mUniMPCaches.get(appid);
                        if(uniMP != null) {
                            Log.e("unimp:", "当前页面url=" + uniMP.getCurrentPageUrl());
                        } else {
                            Log.e("unimp:", "未找到相关小程序实例");
                        }
                        break;
                    }
                    case "gotoTestPage" :
                        Intent intent = new Intent("android.intent.action.UnityPlay");
                        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                        DCUniMPSDK.getInstance().startActivityForUniMPTask(appid, intent);
                        break;
                }
            }
        });
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                try {
                    UniMPOpenConfiguration uniMPOpenConfiguration = new UniMPOpenConfiguration();
                    uniMPOpenConfiguration.splashClass = MySplashView.class;
                    uniMPOpenConfiguration.extraData.put("darkmode", "light");
                    IUniMP uniMP = DCUniMPSDK.getInstance().openUniMP(mContext,"__UNI__B61D13B", uniMPOpenConfiguration);
                    mUniMPCaches.put(uniMP.getAppid(), uniMP);
                } catch (Exception e) {
                    throw new RuntimeException(e);
                }
            }
        });
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        mUniMPCaches.clear();
    }

}
