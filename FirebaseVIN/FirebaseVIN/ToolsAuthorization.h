//
//  ToolsAuthorization.h
//  FirebaseVIN
//
//  Created by ryp-app01 on 2019/7/19.
//  Copyright © 2019年 深圳前海容易配. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ToolsAuthCompletedBlock)(BOOL obj);

@interface ToolsAuthorization : NSObject<UIAlertViewDelegate>
/**
 @brief 单利初始化,sharedToolsInstance
 */
+(instancetype)sharedToolsInstance;

/**
 @brief 请求相机权限,
 */
-(void)requestAuthorizationCamera:(ToolsAuthCompletedBlock)completed ;

/**
 @brief 请求相册权限,
 */
-(void)requestAuthorizationAlbums:(ToolsAuthCompletedBlock)completed;
@end

NS_ASSUME_NONNULL_END
