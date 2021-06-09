//
//  ExpandRequest_Url.h
//  UIKitExpand
//
//  Created by 童公放 on 2017/8/4.
//  Copyright © 2017年 陈美安. All rights reserved.
//  

//防止一个头文件被重复包含
#ifndef ExpandRequest_Url_h
#define ExpandRequest_Url_h


#define SeverEnvironment 1

#if  SeverEnvironment==1  //开发测试网络
#define BASE_API_URL @"http://apiv2.yangkeduo.com/"

#elif SeverEnvironment==2  //正式发布网络
#define BASE_API_URL @"http://new.iformoney.com/"

#endif


#define URL_Subjects                   @"subjects"    //首页滚动banner


#endif /* ExpandRequest_Url_h */
