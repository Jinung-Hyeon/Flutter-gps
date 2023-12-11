# gps

A new Flutter project.

## Getting Started

- AndroidManifest.xml 내용추가 
```xml
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
<uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION"/>
```

- pubspec.yaml 내용추가
    - dependencies
        - location: ^5.0.0


```yaml
dependencies:
    location: ^5.0.0
