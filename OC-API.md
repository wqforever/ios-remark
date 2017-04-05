# ios-remark
for myself

第三方库介绍: http://www.cnblogs.com/kakadekafuka/p/4726459.html

1、
如果要统计ios开发代码，包括头文件的，终端命令进入项目目录下，命令如下
find . -name "*.m" -or -name "*.h" -or -name "*.xib" -or -name "*.c" |xargs wc -l  
列出每个文件的行数
find . -name "*.m" -or -name "*.h" -or -name "*.xib" -or -name "*.c" |xargs grep -v "^$"|wc -l  
列出代码行数总和
grep -v "^$"是去掉空行
注释也统计在代码量之内，毕竟也一个字一个字码出来的

http://ios.jobbole.com/85284/  富文本点击

http://blog.csdn.net/m372897500/article/details/51074597  touches began 不响应

http://www.cocoachina.com/industry/20130725/6677.html  iOS日志崩溃

2、
方法一：使用终端
[table=100%,#ffffff]只要打开终端（位于应用程序——实用工具），将以下代码复制进去然后回车
defaults write com.apple.finder AppleShowAllFiles -bool YES
Finder需要重启才能应用修改，在终端中接着输入
killall Finder
并回车
恢复隐藏不可见，在终端中输入以下代码并回车
defaults write com.apple.finder AppleShowAllFiles -bool NO
同样Finder需要重启
killall Finder

3、模糊效果：http://www.jianshu.com/p/6dd0eab888a6   （coreimage/accelerate/Gpuimage/系统自带毛玻璃）

4、Quartz2D: http://www.jianshu.com/p/0e785269dccc

5、获取UUID ：方法1.
```
CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);

CFStringRef cfstring = CFUUIDCreateString(kCFAllocatorDefault, uuid);

NSString * uuid = [NSString stringWithFormat:@"%@", uuidStr];
```
方法2:
```
[[[UIDevice currentDevice] identifierForVendor] UUIDString];
```
6、获取毫秒时间戳:UInt64 recordTime = [[NSDate date] timeIntervalSince1970]*1000;

7、强制横屏，
```
APPdelegate 加@property(nonatomic,assign)NSInteger allowRotation;


- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if (_allowRotation == 1) {
        return UIInterfaceOrientationMaskLandscapeRight;
    }
    else
    {
        return (UIInterfaceOrientationMaskPortrait);
    }
}

相应controller实现
AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.allowRotation = 1;
    [appDelegate application:[UIApplication sharedApplication] supportedInterfaceOrientationsForWindow:self.view.window];
    //强制翻转屏幕，Home键在右边。
    [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationLandscapeRight) forKey:@"orientation"];
    //刷新
    [UIViewController attemptRotationToDeviceOrientation];


```
8、设置锁屏
```
 NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

    //设置歌曲题目

    [dict setObject:@"题目" forKey:MPMediaItemPropertyTitle];

    //设置歌手名

    [dict setObject:@"歌手" forKey:MPMediaItemPropertyArtist];

    //设置专辑名

    [dict setObject:@"专辑" forKey:MPMediaItemPropertyAlbumTitle];

    //设置显示的图片

    UIImage *newImage = [UIImage imageNamed:@"43.png"];

    [dict setObject:[[MPMediaItemArtwork alloc] initWithImage:newImage]

             forKey:MPMediaItemPropertyArtwork];

    //设置歌曲时长

    [dict setObject:[NSNumber numberWithDouble:300] forKey:MPMediaItemPropertyPlaybackDuration];

    //设置已经播放时长

    [dict setObject:[NSNumber numberWithDouble:150] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime]; 

    //更新字典

    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dict];

//这是锁屏交互
在appDelegate中，我们需要先注册响应后台控制：
[[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
然后在appDelegate中我们实现如下函数处理后台传递给我们的信息：
-(void)remoteControlReceivedWithEvent:(UIEvent *)event{

    if (event.type==UIEventTypeRemoteControl) {

        NSLog(@"%ld",event.subtype);

    }

}

typedef NS_ENUM(NSInteger, UIEventSubtype) {

    // available in iPhone OS 3.0

    UIEventSubtypeNone                              = 0,

    // for UIEventTypeMotion, available in iPhone OS 3.0

    UIEventSubtypeMotionShake                       = 1,

    //这之后的是我们需要关注的枚举信息

    // for UIEventTypeRemoteControl, available in iOS 4.0

    //点击播放按钮或者耳机线控中间那个按钮

    UIEventSubtypeRemoteControlPlay                 = 100,

    //点击暂停按钮

    UIEventSubtypeRemoteControlPause                = 101,

    //点击停止按钮

    UIEventSubtypeRemoteControlStop                 = 102,

    //点击播放与暂停开关按钮(iphone抽屉中使用这个)

    UIEventSubtypeRemoteControlTogglePlayPause      = 103,

    //点击下一曲按钮或者耳机中间按钮两下

    UIEventSubtypeRemoteControlNextTrack            = 104,

    //点击上一曲按钮或者耳机中间按钮三下   

    UIEventSubtypeRemoteControlPreviousTrack        = 105,

    //快退开始 点击耳机中间按钮三下不放开

    UIEventSubtypeRemoteControlBeginSeekingBackward = 106,

    //快退结束 耳机快退控制松开后

    UIEventSubtypeRemoteControlEndSeekingBackward   = 107,

    //开始快进 耳机中间按钮两下不放开

    UIEventSubtypeRemoteControlBeginSeekingForward  = 108,

    //快进结束 耳机快进操作松开后

    UIEventSubtypeRemoteControlEndSeekingForward    = 109,

};
```

9、判断字符串是否整数，浮点数
//判断是否为整形：
```
- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScannerscannerWithString:string];
   int val;
   return[scan scanInt:&val] && [scanisAtEnd];
}
```
//判断是否为浮点形：
```
- (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScannerscannerWithString:string];
   float val;
   return[scan scanFloat:&val] && [scanisAtEnd];
}
```
10、剔除数组中重复数据
```
[array valueForKeyPath:@“@distinctUnionOfObjects.self"]
```
11、GNK转码：
```
NSStringEncoding  gbkEncoding = 	CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
NSString *stttt = [[NSString alloc]initWithData:responseObject   encoding:gbkEncoding];
```
12、IOS适配HTTPS：http://www.cocoachina.com/ios/20151021/13722.html

13、plist创建，读写数据http://blog.csdn.net/totogo2010/article/details/7634185

14、模板路径/Applications/Xcode.app/Contents/Developer/Platforms/iphoneOS.platform/Developer/Library/Xcode/Templates/File/Templates/source

15、隐藏/显示tabbar
@隐藏tabbar
```
- (void) hideTabBar:(UITabBarController *) tabbarcontroller {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    for(UIView *view in tabbarcontroller.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            [view setFrame:CGRectMake(view.frame.origin.x, MAIN_SCREEN_HEIGHT, view.frame.size.width, view.frame.size.height)];
        }
        else
        {
            
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, MAIN_SCREEN_HEIGHT)];
        }
    }
    [UIView commitAnimations];
}
```
//显示tabbar
```
- (void) showTabBar:(UITabBarController *) tabbarcontroller {
    
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    for(UIView *view in tabbarcontroller.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            [view setFrame:CGRectMake(view.frame.origin.x, MAIN_SCREEN_HEIGHT-view.frame.size.height, view.frame.size.width, view.frame.size.height)];
        }
        else
        {
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, MAIN_SCREEN_HEIGHT-49)];
        }
    }
    
    [UIView commitAnimations];
}
```
16、swift新特性：https://onevcat.com/2017/02/ownership/

17、真机打印不全的情况
```
#ifdef DEBUG
#define QYHLog(format, ...) printf("[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define QYHLog(format, ...)
#endif
```
18、富文本属性：
```
NSFontAttributeName                设置字体属性，默认值：字体：Helvetica(Neue) 字号：12
NSForegroundColorAttributeNam      设置字体颜色，取值为 UIColor对象，默认值为黑色
NSBackgroundColorAttributeName     设置字体所在区域背景颜色，取值为 UIColor对象，默认值为nil, 透明色
NSLigatureAttributeName            设置连体属性，取值为NSNumber 对象(整数)，0 表示没有连体字符，1 表示使用默认的连体字符
NSKernAttributeName                设定字符间距，取值为 NSNumber 对象（整数），正值间距加宽，负值间距变窄
NSStrikethroughStyleAttributeName  设置删除线，取值为 NSNumber 对象（整数）
NSStrikethroughColorAttributeName  设置删除线颜色，取值为 UIColor 对象，默认值为黑色
NSUnderlineStyleAttributeName      设置下划线，取值为 NSNumber 对象（整数），枚举常量 NSUnderlineStyle中的值，与删除线类似
NSUnderlineColorAttributeName      设置下划线颜色，取值为 UIColor 对象，默认值为黑色
NSStrokeWidthAttributeName         设置笔画宽度，取值为 NSNumber 对象（整数），负值填充效果，正值中空效果
NSStrokeColorAttributeName         填充部分颜色，不是字体颜色，取值为 UIColor 对象
NSShadowAttributeName              设置阴影属性，取值为 NSShadow 对象
NSTextEffectAttributeName          设置文本特殊效果，取值为 NSString 对象，目前只有图版印刷效果可用：
NSBaselineOffsetAttributeName      设置基线偏移值，取值为 NSNumber （float）,正值上偏，负值下偏
NSObliquenessAttributeName         设置字形倾斜度，取值为 NSNumber （float）,正值右倾，负值左倾
NSExpansionAttributeName           设置文本横向拉伸属性，取值为 NSNumber （float）,正值横向拉伸文本，负值横向压缩文本
NSWritingDirectionAttributeName    设置文字书写方向，从左向右书写或者从右向左书写
NSVerticalGlyphFormAttributeName   设置文字排版方向，取值为 NSNumber 对象(整数)，0 表示横排文本，1 表示竖排文本
NSLinkAttributeName                设置链接属性，点击后调用浏览器打开指定URL地址
NSAttachmentAttributeName          设置文本附件,取值为NSTextAttachment对象,常用于文字图片混排
NSParagraphStyleAttributeName      设置文本段落排版格式，取值为 NSParagraphStyle 对象
```
19、自定义转场动画http://blog.csdn.net/scubers/article/details/46974503

20、runtime：http://yulingtianxia.com/blog/2014/11/05/objective-c-runtime/

21、GCD：https://github.com/nixzhu/dev-blog/blob/master/2014-04-19-grand-central-dispatch-in-depth-part-1.md

22、xcassets无法识别jpg

23、高斯模糊，CI。vImage，GPUImage：http://www.jianshu.com/p/6dd0eab888a6

24、CoreImage:http://blog.csdn.net/qq_22981537/article/details/52487074

25、拒审原因：http://www.tuicool.com/articles/2MvEzmj
26、//返回父vc
```
- (UIViewController *)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    NSLog(@"父视图:%@",[self superview]);
    return nil;
}
```
27、 蓝牙：http://www.jianshu.com/p/84b5b834b942

28、【uibundle mainbundle】infoDictionary】

```
"BuglyAppVersionString " = "1.2.6";
    BuglyDebugEnable = 1;
    BuildMachineOSBuild = 16C67;
    CFBundleAllowMixedLocalizations = 1;
    CFBundleDevelopmentRegion = en;
    CFBundleDisplayName = "\U9752\U4e91\U6c47";
    CFBundleExecutable = FocusEntrance;
    CFBundleIcons =     {
        CFBundlePrimaryIcon =         {
            CFBundleIconFiles =             (
                "AppIcon-220x20",
                "AppIcon-229x29",
                "AppIcon-240x40",
                "AppIcon-260x60"
            );
        };
    };
    CFBundleIdentifier = "com.ifenduo.FocusEntrance";
    CFBundleInfoDictionaryVersion = "6.0";
    CFBundleName = FocusEntrance;
    CFBundleNumericVersion = 20414464;
    CFBundlePackageType = APPL;
    CFBundleShortVersionString = "1.6.0";
    CFBundleSignature = "????";
    CFBundleSupportedPlatforms =     (
        iPhoneOS
    );
    CFBundleURLTypes =     (
                {
            CFBundleTypeRole = Editor;
            CFBundleURLName = weixin;
            CFBundleURLSchemes =             (
                wxbe59499f76f71944
            );
        },
                {
            CFBundleTypeRole = Editor;
            CFBundleURLName = QQ;
            CFBundleURLSchemes =             (
                tencent1104655606
            );
        },
                {
            CFBundleTypeRole = Editor;
            CFBundleURLName = Q;
            CFBundleURLSchemes =             (
                QQ41D7B4F6
            );
        }
    );
    CFBundleVersion = "1.3.7";
    DTCompiler = "com.apple.compilers.llvm.clang.1_0";
    DTPlatformBuild = 14C89;
    DTPlatformName = iphoneos;
    DTPlatformVersion = "10.2";
    DTSDKBuild = 14C89;
    DTSDKName = "iphoneos10.2";
    DTXcode = 0821;
    DTXcodeBuild = 8C1002;
    "Information Property List" =     {
        "" = "";
        "Privacy - Camera Usage Description" = "\U8bbf\U95ee\U76f8\U673a";
        "Privacy - Microphone Usage Description" = "\U8bbf\U95ee\U9ea6\U514b\U98ce";
    };
    LSApplicationCategoryType =     {
    };
    LSApplicationQueriesSchemes =     (
        wechat,
        weixin,
        sinaweibohd,
        sinaweibo,
        sinaweibosso,
        weibosdk,
        "weibosdk2.5",
        mqqapi,
        mqq,
        mqqOpensdkSSoLogin,
        mqqconnect,
        mqqopensdkdataline,
        mqqopensdkgrouptribeshare,
        mqqopensdkfriend,
        mqqopensdkapi,
        mqqopensdkapiV2,
        mqqopensdkapiV3,
        mqzoneopensdk,
        wtloginmqq,
        wtloginmqq2,
        mqqwpa,
        mqzone,
        mqzonev2,
        mqzoneshare,
        wtloginqzone,
        mqzonewx,
        mqzoneopensdkapiV2,
        mqzoneopensdkapi19,
        mqzoneopensdkapi,
        mqqbrowser,
        mttbrowser
    );
    LSRequiresIPhoneOS = 1;
    MinimumOSVersion = "7.0";
    NSAppTransportSecurity =     {
        NSAllowsArbitraryLoads = 1;
        NSExceptionDomains =         {
            "jpush.cn" =             {
                NSExceptionAllowsInsecuresHTTPLoad = 1;
                NSIncludesSubdomains = 1;
            };
        };
    };
    NSCameraUsageDescription = "\U662f\U5426\U5141\U8bb8\U9752\U4e91\U6c47\U4f7f\U7528\U60a8\U7684\U7167\U76f8\U673a";
    NSContactsUsageDescription = "\U9752\U4e91\U6c47\U60f3\U8bbf\U95ee\U60a8\U7684\U901a\U8baf\U5f55";
    NSLocationWhenInUseUsageDescription = "\U662f\U5426\U5141\U8bb8\U9752\U4e91\U6c47\U83b7\U53d6\U60a8\U7684\U5730\U7406\U4f4d\U7f6e\U4fe1\U606f";
    NSMicrophoneUsageDescription = "\U662f\U5426\U5141\U8bb8\U9752\U4e91\U6c47\U4f7f\U7528\U60a8\U7684\U9ea6\U514b\U98ce";
    NSPhotoLibraryUsageDescription = "\U9752\U4e91\U6c47\U60f3\U8bbf\U95ee\U60a8\U7684\U76f8\U518c";
    UIDeviceFamily =     (
        1
    );
    UILaunchImages =     (
                {
            UILaunchImageMinimumOSVersion = "8.0";
            UILaunchImageName = "LaunchImage-1-800-Portrait-736h";
            UILaunchImageOrientation = Portrait;
            UILaunchImageSize = "{414, 736}";
        },
                {
            UILaunchImageMinimumOSVersion = "8.0";
            UILaunchImageName = "LaunchImage-1-800-667h";
            UILaunchImageOrientation = Portrait;
            UILaunchImageSize = "{375, 667}";
        },
                {
            UILaunchImageMinimumOSVersion = "7.0";
            UILaunchImageName = "LaunchImage-1-700";
            UILaunchImageOrientation = Portrait;
            UILaunchImageSize = "{320, 480}";
        },
                {
            UILaunchImageMinimumOSVersion = "7.0";
            UILaunchImageName = "LaunchImage-1-700-568h";
            UILaunchImageOrientation = Portrait;
            UILaunchImageSize = "{320, 568}";
        }
    );
    UILaunchStoryboardName = LaunchScreen;
    UIRequiredDeviceCapabilities =     (
        armv7
    );
    UISupportedInterfaceOrientations =     (
        UIInterfaceOrientationPortrait
    );
    UIViewControllerBasedStatusBarAppearance = 0;
}
```
29、 命令行openssl和md5加密
加密的结果为ascii码的加密与解密：
```
openssl enc -aes-128-cbc -e -a -in yygy/in.txt -out dj.txt -K c286696d887c9aa0611bbb3e2025a45a -iv 562e17996d093d28ddb3ba695a2e6f58
openssl enc -aes-128-cbc -d -a -in dj.txt -out dedj.txt -K c286696d887c9aa0611bbb3e2025a45a -iv 562e17996d093d28ddb3ba695a2e6f58
```
加密的结果为二进制文件的加密与解密：
```
openssl enc -aes-128-cbc -e  -in yygy/in.txt -out dj.txt -K c286696d887c9aa0611bbb3e2025a45a -iv 562e17996d093d28ddb3ba695a2e6f58
openssl enc -aes-128-cbc -d  -in dj.txt -out dedj.txt -K c286696d887c9aa0611bbb3e2025a45a -iv 562e17996d093d28ddb3ba695a2e6f58
```
md5:
```
openssl dgst -md5 dj.txt
```
30、动画
```
http://blog.csdn.net/gu_jin_xiao/article/details/50085675
http://www.open-open.com/lib/view/open1472564715676.html
http://www.cocoachina.com/ios/20160517/16290.html
```
31、 [[UIApplication sharedApplication]
```
http://blog.csdn.net/huifeidexin_1/article/details/7792371
```
32、iMessage
```
http://blog.csdn.net/gzgengzhen/article/details/53115136
```
