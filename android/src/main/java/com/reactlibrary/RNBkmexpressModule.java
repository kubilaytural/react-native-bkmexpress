
package com.reactlibrary;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;
import javax.annotation.Nullable;
import android.app.Activity;
import android.content.Context;

import android.util.Log;

import com.bkm.mobil.bexflowsdk.base.BEXPaymentListener;
import com.bkm.mobil.bexflowsdk.base.BEXStarter;
import com.bkm.mobil.bexflowsdk.en.Environment;

public class RNBkmexpressModule extends ReactContextBaseJavaModule {

  private final ReactApplicationContext reactContext;
  public String resultType = "0";
  public Callback globCall;
  public Environment env;

  public RNBkmexpressModule(ReactApplicationContext reactContext) {
    super(reactContext);
    this.reactContext = reactContext;
  }

  @Override
  public String getName() {
    return "RNBkmexpress";
  }

  @ReactMethod
  public void onFailure() {

  }

  @ReactMethod
  public void kkBexStart(String id, String path, String token, String environment, Callback callback) {
    globCall = callback;

    final Activity currentActivity = getCurrentActivity();
    if (isNotEmpty(token)) {
      if (environment.equals("PREPROD")) {
        env = Environment.PREPROD;
      } else {
        env = Environment.PROD;
      }
      BEXStarter.startBexFlow(currentActivity, env, id, path, token, new BEXPaymentListener(){
        public void onSuccess() {
            globCall.invoke("", "0");
        }

        public void onCanceled() {
            globCall.invoke("", "1");
        }

        public void onFailure(String errorId, String error) {
            globCall.invoke(error, "2");
        }
      });
    }
  }

  private boolean isNotEmpty(String test) {
    return test != null && !test.equals("");
  }
}