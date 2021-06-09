//
//  ZeroSDCDownMenu.h
//  ZeroSDCycleView
//
//  Created by ZeroSmile on 2017/10/1.
//  Copyright © 2017年 陈美安. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ZeroSDCDownMenu;

@protocol ZeroSDCDownMenuDelegate <NSObject>

@optional
- (void)didSelectRowIndex:(ZeroSDCDownMenu *)didSelectRowIndex
                 selectitle:(NSString*)title;

@end


@interface ZeroSDCDownMenu : UIView
@property (nonatomic, weak) id<ZeroSDCDownMenuDelegate> delegate;
- (instancetype)initWithArraySource:(NSArray*)arraySource rowHeight:(CGFloat)rowHeight;
-(void)showAlertView;
-(void)dismissAlertView;
@end
