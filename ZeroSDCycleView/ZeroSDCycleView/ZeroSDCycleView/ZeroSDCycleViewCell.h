//
//  ZeroSDCycleViewCell.h
//  ZeroSDCycleView
//
//  Created by ZeroSmile on 2017/9/7.
//  Copyright © 2017年 2966497308@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZeroSDCycleViewCell : UICollectionViewCell
@property (weak, nonatomic) UIImageView *imageView;
-(void)setImageUrl:(NSString*)url;
@end
