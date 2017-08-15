# Safe
use method swizzling to lower APP crash

## What
1. use category for NSArray, NSDicttionary, by method swizzling, can avoid out of index or add nil object crash;
2. NSNumber and NSString often used in json data model, or in NSDictionary, maybe we don't know it's reall Class type, when we use NSNumber obj as NSString obj, unrecognize exception will happen, here we can use forwardingTargetForSelector to solve this problem

![屏幕快照 2017-08-15 下午10.50.25](media/15028086426666/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202017-08-15%20%E4%B8%8B%E5%8D%8810.50.25.png)

## Last
avoid APP crash or solve APP crash，here is a very small solution，more information，your can watch [漫谈iOS Crash收集框架](https://nianxi.net/ios/ios-crash-reporter.html) 

