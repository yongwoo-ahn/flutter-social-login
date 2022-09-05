package com.makestar.flutter_social_login

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** FlutterSocialLoginPlugin */
class FlutterSocialLoginPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_social_login")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else if (call.method == "signInWithApple") {
      val auth = FirebaseAuth.getInstance();
      val provider = OAuthProvider.newBuilder("apple.com")
      provider.setScopes(arrayOf("email", "name").toMutableList());
      val pending = auth.pendingAuthResult;
      if (pending != null) {
        pending.addOnSuccessListener { authResult ->
          Log.d(TAG, "checkPending:onSuccess:$authResult")
          val user = authResult.user;
          val resultMap =
                  mutableMapOf<String, Any?>("appleUid" to null, "appleEmail" to null);
          user?.let {
            for (profile in it.providerData) {
              val providerId = profile.providerId
              if (providerId != String("firebase".toCharArray())) {
                resultMap["appleUid"] = profile.uid;
                resultMap["appleEmail"] = profile.email;
                //Log.d(TAG, "${appleUid}")
                //Log.d(TAG, "${appleEmail}")
              }
            }
          }
          result.success(resultMap);
        }.addOnFailureListener { e ->
          Log.w(TAG, "checkPending:onFailure", e)
          result.error("checkPending:onFailure", e.toString(), e.toString());
        }
      } else {
        Log.d(TAG, "pending: null")
        auth.startActivityForSignInWithProvider(this, provider.build())
                .addOnSuccessListener { authResult ->
                  // Sign-in successful!
                  Log.d(TAG, "activitySignIn:onSuccess:${authResult.user}")
                  val user = authResult.user;
                  val resultMap = mutableMapOf<String, Any?>(
                          "appleUid" to null,
                          "appleEmail" to null
                  );
                  user?.let {
                    for (profile in it.providerData) {
                      val providerId = profile.providerId
                      if (providerId != String("firebase".toCharArray())) {
                        resultMap["appleUid"] = profile.uid;
                        resultMap["appleEmail"] = profile.email;
                      }
                    }
                  }
                  result.success(resultMap);
                }
                .addOnFailureListener { e ->
                  Log.w(TAG, "activitySignIn:onFailure", e)
                  result.error("activitySignIn:onFailure", e.toString(), e.toString());
                }
      }
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
