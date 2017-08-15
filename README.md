# Safe
use method swizzling to lower APP crash

## What
1. use category for NSArray, NSDicttionary, by method swizzling, can avoid out of index or add nil object crash;
2. NSNumber and NSString often used in json data model, or in NSDictionary, maybe we don't know it's reall Class type, when we use NSNumber obj as NSString obj, unrecognize exception will happen, here we can use forwardingTargetForSelector to solve this problem

```OC
- (id)swizzle_forwardingTargetForSelector:(SEL)aSelector {
    // whether NSString respondsToSelector
    if ([__checkString respondsToSelector:aSelector]) {
        return [NSString stringWithFormat:@"%@", self];
    }
    // Returns the object to which unrecognized messages should first be directed
    return [super forwardingTargetForSelector:aSelector];
}
```

## Last
avoid APP crash or solve APP crash，here is a very small solution，more information，your can watch [漫谈iOS Crash收集框架](https://nianxi.net/ios/ios-crash-reporter.html) 

