//
//  ToolsAuthorization.m
//  FirebaseVIN
//
//  Created by ryp-app01 on 2019/7/19.
//  Copyright © 2019年 深圳前海容易配. All rights reserved.
//

#import "ToolsAuthorization.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/PHPhotoLibrary.h>


static ToolsAuthorization *_authorization = nil;

@interface  ToolsAuthorization ()

@end


@implementation ToolsAuthorization


- (id)copyWithZone:(NSZone *)zone {
    return [[ToolsAuthorization allocWithZone:zone] init];
}
+ (id)allocWithZone:(NSZone *)zone{
    return [self sharedToolsInstance];
}

+(instancetype)sharedToolsInstance{
    static dispatch_once_t dispatch;
    dispatch_once(&dispatch , ^{
        _authorization = [[super allocWithZone:NULL] init];
    });
    return _authorization;
}


-(void)requestAuthorizationCamera:(ToolsAuthCompletedBlock)completed{
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        
        AVAuthorizationStatus authStatus =  [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        switch (authStatus) {
            case AVAuthorizationStatusNotDetermined:{
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                    if (granted) {//第一次允许的操作
                        completed(true);
                    }else{
                        completed(false);
                        [self getCamera];
                    }
                }];
            }
                
                break;
            case AVAuthorizationStatusRestricted:{//允许权限之后的操作
                completed(true);
            }
                
                break;
            case AVAuthorizationStatusDenied:{//不允许权限之后的操作
                completed(false);
                [self getCamera];
            }
                
                break;
            case AVAuthorizationStatusAuthorized:{//系统受限制之后的操作
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                    if (granted) {//第一次允许的操作
                        completed(true);
                    }else{
                        completed(false);
                        [self getCamera];
                    }
                }];
            }
                break;
            default:
                break;
        }
    } else {
        completed(false);
        [self getCamera];
    }
    
}


-(void)requestAuthorizationAlbums:(ToolsAuthCompletedBlock)completed{
    //检查相册权限
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    switch (status) {
        case PHAuthorizationStatusDenied:{
            //用户拒绝当前应用访问相册,我们需要提醒用户打开访问开关
            completed(false);
            [self getAlbums];
            
        }
            break;
        case PHAuthorizationStatusRestricted:{
            //家长控制,不允许访问
            completed(false);
            [self getAlbums];
        }
            break;
        case PHAuthorizationStatusNotDetermined:{
            //用户还没有做出选择
            completed(true);
        }
            break;
        case PHAuthorizationStatusAuthorized:{
            //用户允许当前应用访问权限
            completed(true);
        }
            break;
        default:
            break;
    }
}


- (void)getCamera{
    dispatch_async(dispatch_get_main_queue(), ^{
        //判断是否已授权
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相机" message:@"请在iPhone的""设置-APP-相机""中允许使用相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    });
}


- (void)getAlbums{
    dispatch_async(dispatch_get_main_queue(), ^{
        //判断是否已授权
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-APP-照片""中允许访问照片" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    });
}


//跳转系统设置,调试使用
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if( [[UIApplication sharedApplication]canOpenURL:settingsURL ]&&settingsURL ) {
        [[UIApplication sharedApplication] openURL:settingsURL];
    }
}


@end
