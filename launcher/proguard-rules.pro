# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile

# 代码混淆压缩比，在0~7之间，默认为5，一般不做修改
-optimizationpasses 5

# 关闭优化
-dontoptimize

# 混合时不使用大小写混合，混合后的类名为小写
-dontusemixedcaseclassnames

# 这句话能够使我们的项目混淆后产生映射文件
# 包含有类名->混淆后类名的映射关系
-verbose

# 指定不去忽略非公共库的类成员
-dontskipnonpubliclibraryclassmembers

# 不做预校验，preverify是proguard的四个步骤之一，Android不需要preverify，去掉这一步能够加快混淆速度。
-dontpreverify

# 保留Annotation不混淆
-keepattributes *Annotation*
#-keepattributes *Annotation*,InnerClasses

# 避免混淆泛型
-keepattributes Signature

# 抛出异常时保留代码行号
-keepattributes SourceFile,LineNumberTable

# 指定混淆是采用的算法，后面的参数是一个过滤器
# 这个过滤器是谷歌推荐的算法，一般不做更改
-optimizations !code/simplification/cast,!field/*,!class/merging/*

# 保持 native 方法不被混淆
-keepclasseswithmembernames class * {
    native <methods>;
}

# 保留序列化的类不被混淆
-keepnames class * implements android.os.Parcelable {
   public static final ** CREATOR;
}

# 不混淆Serializable接口的子类中指定的某些成员变量和方法
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    !static !transient <fields>;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}

#去除所有system.out.print
-assumenosideeffects class java.io.PrintStream {
    public *** println(...);
    public *** print(...);
}

#############################################
#
# OkHttp3
#
#############################################
# JSR 305 annotations are for embedding nullability information.
-dontwarn javax.annotation.**

# A resource is loaded with a relative path so the package of this class must be preserved.
-keepnames class okhttp3.internal.fpublicsuffix.PublicSuffixDatabase

# Animal Sniffer compileOnly dependency to ensure APIs are compatible with older versions of Java.
-dontwarn org.codehaus.mojo.animal_sniffer.*

# OkHttp platform used only on JVM and when Conscrypt dependency is available.
-dontwarn okhttp3.internal.platform.ConscryptPlatform

#############################################
#
# Gson
#
#############################################

##---------------Begin: proguard configuration for Gson  ----------
# Gson uses generic type information stored in a class file when working with fields. Proguard
# removes such information by default, so configure it to keep all of it.
-keepattributes Signature

# For using GSON @Expose annotation
-keepattributes *Annotation*

# Gson specific classes
-dontwarn sun.misc.**
#-keep class com.google.gson.stream.** { *; }

# Application classes that will be serialized/deserialized over Gson
-keep class com.google.gson.examples.android.model.** { <fields>; }

# Prevent proguard from stripping interface information from TypeAdapter, TypeAdapterFactory,
# JsonSerializer, JsonDeserializer instances (so they can be used in @JsonAdapter)
-keep class * extends com.google.gson.TypeAdapter
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer

# Prevent R8 from leaving Data object members always null
-keepclassmembers,allowobfuscation class * {
  @com.google.gson.annotations.SerializedName <fields>;
}

##---------------End: proguard configuration for Gson  ----------


#############################################
#
# Fresco
#
#############################################

# Keep our interfaces so they can be used by other ProGuard rules.
# See http://sourceforge.net/p/proguard/bugs/466/
-keep,allowobfuscation @interface com.facebook.common.internal.DoNotStrip
-keep,allowobfuscation @interface com.facebook.soloader.DoNotOptimize

# Do not strip any method/class that is annotated with @DoNotStrip
-keep @com.facebook.common.internal.DoNotStrip class *
-keepclassmembers class * {
    @com.facebook.common.internal.DoNotStrip *;
}

# Do not strip any method/class that is annotated with @DoNotOptimize
-keep @com.facebook.soloader.DoNotOptimize class *
-keepclassmembers class * {
    @com.facebook.soloader.DoNotOptimize *;
}

# Works around a bug in the animated GIF module which will be fixed in 0.12.0
-keep class com.facebook.imagepipeline.animated.factory.AnimatedFactoryImpl {
    public AnimatedFactoryImpl(com.facebook.imagepipeline.bitmaps.PlatformBitmapFactory,com.facebook.imagepipeline.core.ExecutorSupplier);
}

-keep class com.facebook.** {*;}
-dontwarn com.facebook.**

#############################################
#
# Google
#
#############################################
# For Google Play Services
-keep public class com.google.android.gms.ads.**{
   public *;
}

# For old ads classes
-keep public class com.google.ads.**{
   public *;
}

# Other required classes for Google Play Services
# Read more at http://developer.android.com/google/play-services/setup.html
-keep class * extends java.util.ListResourceBundle {
   protected java.lang.Object[][] getContents();
}

# 保留Google原生服务需要的类
-keep public class com.google.vending.licensing.ILicensingService
-keep public class com.android.vending.licensing.ILicensingService



# xlog混淆设置
-keep class com.elvishew.xlog.** { *; }




-dontwarn
-optimizationpasses 5
-dontusemixedcaseclassnames
-dontskipnonpubliclibraryclasses
-dontskipnonpubliclibraryclassmembers
-dontpreverify
-verbose

#-optimizations !code/simplification/arithmetic,!field/*,!class/merging/*
-dontoptimize

-keep public class * extends android.app.Activity
-keep public class * extends android.app.Application
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider
-keep public class * extends android.app.backup.BackupAgentHelper
-keep public class * extends android.preference.Preference
-keep public class * extends io.dcloud.common.DHInterface.IPlugin
-keep public class * extends io.dcloud.common.DHInterface.IFeature
-keep public class * extends io.dcloud.common.DHInterface.IBoot
-keep public class * extends io.dcloud.common.DHInterface.IReflectAble

-keep class io.dcloud.** {*;}
-dontwarn io.dcloud.**


-keep class vi.com.gdi.** {*;}
-keep class android.support.v4.** {*;}

-keepclasseswithmembers class io.dcloud.appstream.StreamAppManager {
    public protected <methods>;
}

-keep public class * extends io.dcloud.common.DHInterface.IReflectAble{
  public protected <methods>;
  public protected *;
}
-keep class **.R
-keep class **.R$* {
    public static <fields>;
}
-keep public class * extends io.dcloud.common.DHInterface.IJsInterface{
  public protected <methods>;
  public protected *;
}

-keepclasseswithmembers class io.dcloud.EntryProxy {
    <methods>;
}

-keep class * implements android.os.IInterface {
  <methods>;
}

-keepclasseswithmembers class *{
  public static java.lang.String getJsContent();
}

-keepclasseswithmembers class *{
  public static io.dcloud.share.AbsWebviewClient getWebviewClient(io.dcloud.share.ShareAuthorizeView);
}

-keepattributes Exceptions,InnerClasses,Signature,Deprecated, SourceFile,LineNumberTable,*Annotation*,EnclosingMethod

-keepclasseswithmembers class * {
    public <init>(android.content.Context, android.util.AttributeSet);
}

-keepclasseswithmembers class * {
    public <init>(android.content.Context, android.util.AttributeSet, int);
}

-keep public class * extends android.app.Application{
  public static <methods>;
  public *;
}

-keepclassmembers class * extends android.app.Activity {
   public void *(android.view.View);
   public static <methods>;
}

-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

-keep class * implements android.os.Parcelable {
  public static final android.os.Parcelable$Creator *;
}

-keep class dc.** {*;}
-keep class okio.**{*;}
-keep class org.apache.** {*;}
-keep class org.json.** {*;}
-keep class net.ossrs.** {*;}
-keep class android.** {*;}
-keep class com.facebook.**{*;}
-keep class com.bumptech.glide.**{*;}
-keep class com.alibaba.fastjson.**{*;}
-keep class com.sina.**{*;}
-keep class com.weibo.ssosdk.**{*;}
-keep class com.asus.**{*;}
-keep class com.bun.**{*;}
-keep class com.heytap.**{*;}
-keep class com.huawei.**{*;}
-keep class com.netease.**{*;}
-keep class com.meizu.**{*;}
-keep class com.samsung.**{*;}
-keep class com.zui.**{*;}
-keep class com.amap.**{*;}
-keep class com.autonavi.**{*;}
-keep class pl.droidsonroids.gif.**{*;}
-keep class com.tencent.**{*;}
-keep class com.baidu.**{*;}
-keep class com.iflytek.**{*;}
-keep class com.umeng.**{*;}
-keep class tv.**{*;}
-keep class master.**{*;}
-keep class uk.co.**{*;}
-keep class com.dmcbig.**{*;}
-keep class org.mozilla.**{*;}
-keep class androidtranscoder.**{*;}
-keep class XI.**{*;}


-dontwarn android.**
-dontwarn com.tencent.**

-keep class * implements com.taobao.weex.IWXObject{*;}
-keep public class * extends com.taobao.weex.common.WXModule{*;}


-keepattributes Signature

-dontwarn org.codehaus.mojo.**
-dontwarn org.apache.commons.**
-dontwarn com.amap.**
-dontwarn com.sina.weibo.sdk.**
-dontwarn com.alipay.**
-dontwarn com.lucan.ajtools.**
-dontwarn pl.droidsonroids.gif.**

-keep class com.taobao.weex.** { *; }
-keep class com.taobao.gcanvas.**{*;}
-dontwarn com.taobao.weex.**
-dontwarn com.taobao.gcanvas.**

#个推
-dontwarn com.igexin.**
-keep class com.igexin.** { *; }
-keep class org.json.** { *; }
-dontwarn com.getui.**
-keep class com.getui.** { *; }

-keep class android.support.v4.app.NotificationCompat { *; }
-keep class android.support.v4.app.NotificationCompat$Builder { *; }
#魅族
-keep class com.meizu.** { *; }
-dontwarn com.meizu.**
#小米
-keep class com.xiaomi.** { *; }
-dontwarn com.xiaomi.push.**
-keep class org.apache.thrift.** { *; }
#华为
-dontwarn com.huawei.hms.**
-keep class com.huawei.hms.** { *; }

-keep class com.huawei.android.** { *; }
-dontwarn com.huawei.android.**

-keep class com.hianalytics.android.** { *; }
-dontwarn com.hianalytics.android.**

-keep class com.huawei.updatesdk.** { *; }
-dontwarn com.huawei.updatesdk.**
#OPPO
-keep class com.coloros.mcssdk.** { *; }
-dontwarn com.coloros.mcssdk.**

#360聚合广告核心包
-keep class com.ak.** {*;}
-dontwarn com.ak.**
-keep class android.support.v4.** {
public *;
}

#广点通SDK
-keep class com.qq.e.** {
public protected *;
}
-keep class android.support.v7.**{
public *;
}

#穿山甲SDK
-keep class com.bytedance.sdk.openadsdk.** { *; }
-dontwarn com.bytedance.sdk.openadsdk.**
-keep class com.androidquery.callback.** {*;}
-keep public interface com.bytedance.sdk.openadsdk.downloadnew.** {*;}
-keep class com.ss.sys.ces.* {*;}

#快手
-keep class org.chromium.** {*;}
-keep class org.chromium.** {*;}
-keep class aegon.chrome.** {*;}
-keep class com.kwai.**{*;}
-keep class com.kwad.**{*;}
-keepclasseswithmembernames class * {
 native <methods>;
}
-dontwarn com.kwai.**
-dontwarn com.kwad.**
-dontwarn com.ksad.**
-dontwarn aegon.chrome.**

#一键登录
-dontwarn com.g.gysdk.**
-keep class com.g.gysdk.**{*;}
-dontwarn com.g.elogin.**
-keep class com.g.elogin.**{*;}
-dontwarn com.cmic.sso.sdk.**
-keep class com.cmic.sso.sdk.** {*;}
-dontwarn com.geetest.onelogin.**
-keep class com.geetest.onelogin.** {*;}
-dontwarn com.geetest.onepassv2.**
-keep class com.geetest.onepassv2.** {*;}
-dontwarn com.unicom.xiaowo.login.**
-keep class com.unicom.xiaowo.login.** {*;}
-dontwarn cn.com.chinatelecom.account.api.**
-keep class cn.com.chinatelecom.account.api.** {*;}



#腾讯X5--------------start-----------------------
-dontwarn dalvik.**
-dontwarn com.tencent.smtt.**
#-overloadaggressively
# ------------------ Keep LineNumbers and properties ---------------- #
-keepattributes Exceptions,InnerClasses,Signature,Deprecated,SourceFile,LineNumberTable,*Annotation*,EnclosingMethod
# --------------------------------------------------------------------------
# Addidional for x5.sdk classes for apps
-keep class com.tencent.smtt.export.external.**{*;}
-keep class com.tencent.tbs.video.interfaces.IUserStateChangedListener {*;}
-keep class com.tencent.smtt.sdk.CacheManager {public *;}
-keep class com.tencent.smtt.sdk.CookieManager {public *;}
-keep class com.tencent.smtt.sdk.WebHistoryItem {public *;}
-keep class com.tencent.smtt.sdk.WebViewDatabase {public *;}
-keep class com.tencent.smtt.sdk.WebBackForwardList {public *;}
-keep public class com.tencent.smtt.sdk.WebView {public <fields>;public <methods>;}
-keep public class com.tencent.smtt.sdk.WebView$HitTestResult {public static final <fields>;public java.lang.String getExtra();public int getType();}
-keep public class com.tencent.smtt.sdk.WebView$WebViewTransport {public <methods>;}
-keep public class com.tencent.smtt.sdk.WebView$PictureListener {public <fields>;public <methods>;}
-keepattributes InnerClasses
-keep public enum com.tencent.smtt.sdk.WebSettings$** {*;}
-keep public enum com.tencent.smtt.sdk.QbSdk$** {*;}
-keep public class com.tencent.smtt.sdk.WebSettings {public *;}

-keepattributes Signature
-keep public class com.tencent.smtt.sdk.ValueCallback {public <fields>;public <methods>;}
-keep public class com.tencent.smtt.sdk.WebViewClient {public <fields>;public <methods>;}
-keep public class com.tencent.smtt.sdk.DownloadListener {public <fields>;public <methods>;}
-keep public class com.tencent.smtt.sdk.WebChromeClient {public <fields>;public <methods>;}
-keep public class com.tencent.smtt.sdk.WebChromeClient$FileChooserParams {public <fields>;public <methods>;}
-keep class com.tencent.smtt.sdk.SystemWebChromeClient{public *;}
# 1. extension interfaces should be apparent
-keep public class com.tencent.smtt.export.external.extension.interfaces.* {public protected *;}

# 2. interfaces should be apparent
-keep public class com.tencent.smtt.export.external.interfaces.* {public protected *;}
-keep public class com.tencent.smtt.sdk.WebViewCallbackClient {public protected *;}
-keep public class com.tencent.smtt.sdk.WebStorage$QuotaUpdater {public <fields>;public <methods>;}
-keep public class com.tencent.smtt.sdk.WebIconDatabase {public <fields>;public <methods>;}
-keep public class com.tencent.smtt.sdk.WebStorage {public <fields>;public <methods>;}
-keep public class com.tencent.smtt.sdk.DownloadListener {public <fields>;public <methods>;}
-keep public class com.tencent.smtt.sdk.QbSdk {public <fields>;public <methods>;}
-keep public class com.tencent.smtt.sdk.QbSdk$PreInitCallback {public <fields>;public <methods>;}
-keep public class com.tencent.smtt.sdk.CookieSyncManager {public <fields>;public <methods>;}
-keep public class com.tencent.smtt.sdk.Tbs* {public <fields>;public <methods>;}
-keep public class com.tencent.smtt.utils.LogFileUtils {public <fields>;public <methods>;}
-keep public class com.tencent.smtt.utils.TbsLog {public <fields>;public <methods>;}
-keep public class com.tencent.smtt.utils.TbsLogClient {public <fields>;public <methods>;}
-keep public class com.tencent.smtt.sdk.CookieSyncManager {public <fields>;public <methods>;}
# Added for game demos
-keep public class com.tencent.smtt.sdk.TBSGamePlayer {public <fields>;public <methods>;}
-keep public class com.tencent.smtt.sdk.TBSGamePlayerClient* {public <fields>;public <methods>;}
-keep public class com.tencent.smtt.sdk.TBSGamePlayerClientExtension {public <fields>;public <methods>;}
-keep public class com.tencent.smtt.sdk.TBSGamePlayerService* {public <fields>;public <methods>;}
-keep public class com.tencent.smtt.utils.Apn {public <fields>;public <methods>;}
-keep class com.tencent.smtt.** {*;}
# end
-keep public class com.tencent.smtt.export.external.extension.proxy.ProxyWebViewClientExtension {public <fields>;public <methods>;}
-keep class MTT.ThirdAppInfoNew {*;}
-keep class com.tencent.mtt.MttTraceEvent {*;}
# Game related
-keep public class com.tencent.smtt.gamesdk.* {public protected *;}
-keep public class com.tencent.smtt.sdk.TBSGameBooter {public <fields>;public <methods>;}
-keep public class com.tencent.smtt.sdk.TBSGameBaseActivity {public protected *;}
-keep public class com.tencent.smtt.sdk.TBSGameBaseActivityProxy {public protected *;}
-keep public class com.tencent.smtt.gamesdk.internal.TBSGameServiceClient {public *;}
#腾讯X5--------------end-----------------------

