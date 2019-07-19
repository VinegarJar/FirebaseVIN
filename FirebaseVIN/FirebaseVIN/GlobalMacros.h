//
//  GlobalMacros.h
//  FirebaseVIN
//
//  Created by ryp-app01 on 2019/7/19.
//  Copyright © 2019年 深圳前海容易配. All rights reserved.
//

#ifndef GlobalMacros_h
#define GlobalMacros_h

#ifdef DEBUG
#define DEBUG_NSLog(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);

#else
#define DEBUG_NSLog(format, ...)

#endif


#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)



#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//RGB 转换 色值码
typedef NS_ENUM(UInt32, ColorRGBType) {
    UITitleColor             = 0x2D2D2D,
    UIBagRefColor        = 0xEFEFF4,

};


#endif /* GlobalMacros_h */
