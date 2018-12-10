# React Native BKMExpress SDK

**React Native BKMExpress**, Bkm Express ödeme sağlayıcısı kullanmak için yaratılmış sdk'dır. BKM Express native sdk'ları baz alınarak geliştirilme yapılmıştır.

Bknz
**Android:**  [https://github.com/BKMExpress/BEXFlowSDKAndroid](https://github.com/BKMExpress/BEXFlowSDKAndroid)
**IOS:**  [https://github.com/BKMExpress/iOSBKMExpressFlowSDK](https://github.com/BKMExpress/iOSBKMExpressFlowSDK)


# Başlarken

Kurulum

    yarn add react-native-bkmexpress

veya

    npm install --save react-native-bkmexpress

## Android

Linkleme İşlemi

1. Open up `android/app/src/main/java/[...]/MainApplication.java`
  - Add `import com.reactlibrary.RNBkmexpressPackage;` to the imports at the top of the file
  - Add `new RNBkmexpressPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
    include ':react-native-bkmexpress'
    project(':react-native-bkmexpress').projectDir = new File(rootProject.projectDir, '../node_modules/react-native-bkmexpress/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-bkmexpress')
  	```
Ayrıca `android/build.gradle` altına kullanacağınız sdk versiyonunun adresini, kullanıcı adınızı ve parolanızı vermeniz gerekiyor:

```javascript
allprojects {
    repositories {
        ...
        maven {
            url 'sdkpath'
            credentials {
                username = "your_username"
                password = "your_password"
            }
        }
        ...
    }
}
```

##  iOS

Kütüphaneyi projene eklemek için react-native link kullanmalısın.

    react-native link react-native-bkmexpress

ve

Projene pod ile **BKMExpressFlowSDK** 'yı kurmalısın.

    pod 'BKMExpressFlowSDK', '1.0.6'

# Kullanım
```javascript

import RNBkmexpress from 'react-native-bkmexpress';

RNBkmexpress.kkBexStart(paymentIssueId, paymentIssuePath, paymentIssueToken, Environment, (error, result) => {
  // result -> 0 Başarılı || 1 İptal || 2 Başarısız
  // error -> SDK içerisinden dönen hata mesajı
  if (result === '0') {
    // Başarılı
  } else if (result === '2') {
    // Başarısız
  } else {
    // Kullanıcı iptali
  }
});
```

# Parametre Tablosu

| Değer Adı | Değer Tipi | Değerin Amacı |
| ------------- | ------------- | ------------- |
| paymentIssueId  | String  | Yapılacak olan ödemenin işlem numarası |
| paymentIssuePath | String | Yapılacak olan ödemenin işlem pathi |
| paymentIssueToken | style | Yapılacak olan ödemenin işlem tokenı |
| Environment | String | Çalıştırma ortamı - PREPORD ortamı için "PREPROD", PROD ortamı için "PROD" giriniz |
| error | String | Dönen hata mesajı |
| result | String | Dönen sonuç (0 Başarılı - 1 İptal - 2 Başarısız) |
