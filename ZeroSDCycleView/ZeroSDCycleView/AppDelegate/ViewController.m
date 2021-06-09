//
//  ViewController.m
//  ZeroSDCycleView
//
//  Created by ZeroSmile on 2017/9/7.
//  Copyright © 2017年 陈美安. All rights reserved.
//

#import "ViewController.h"
#import "HttpRequestManager.h"
#import "ZeroSDCycleView.h"
#import "ZeroSDCAlertView.h"
#import "ZeroBubbleView.h"
#import "ZeroLineView.h"
#import "ZeroFireworkView.h"
#import "ZeroStarView.h"
#import "ZeroRainbowView.h"
#import "ZeroSDCDownMenu.h"
#import "ZeroSDCDownButton.h"

@interface ViewController ()<ZeroSDCycleViewDelegate,ZeroSDCAlertDelegate,ZeroSDCDownMenuDelegate>
@property(nonatomic,strong)ZeroSDCycleView *zeroSDCycleView;
@property(nonatomic,strong)ZeroSDCAlertView *zeroSDCAlertView;
@property(nonatomic,strong)ZeroBubbleView *zeroBubble;
@property (nonatomic, strong) ZeroLineView *leftMoveView;
@property (nonatomic, strong)ZeroFireworkView *zeroFirework;
@property (nonatomic, strong)ZeroStarView *zeroStarView;
@property (weak, nonatomic) IBOutlet UIImageView *eggImageView;
@property (nonatomic, strong)ZeroRainbowView *zeroRainbow;
@property (nonatomic, strong)ZeroSDCDownButton*down;
@property (nonatomic, strong)ZeroSDCDownMenu*downMenu;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
              [self requestNetwork];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self zeroSDCycleView];
            [self down];
            [self.view addSubview:self.downMenu];
        });
    });

}

-(ZeroSDCDownMenu *)downMenu
{
    if (!_downMenu){
        _downMenu = [[ZeroSDCDownMenu alloc]initWithArraySource:[NSArray arrayWithObjects:@"收到的红包",@"发出的红包",@"退款",nil] rowHeight:45];
        _downMenu.delegate = self;
    }
    return _downMenu;
}

-(ZeroSDCDownButton*)down{
    if (!_down) {
        _down = [[ZeroSDCDownButton alloc]initWithFrame:CGRectMake(0, 0, 100, 45)];
        [_down addTarget:self action:@selector(downClick:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.titleView = _down;
    }
    return _down;
}

-(void)downClick:(UIButton *)sender{

    if (!sender.isSelected) {
        sender.selected = YES;
            NSLog(@"弹出菜单框");
      [_downMenu showAlertView];
    }else{
        sender.selected = NO;
        [_downMenu dismissAlertView];
         NSLog(@"关闭弹出菜单框");
    }
}


-(void)didSelectRowIndex:(ZeroSDCDownMenu *)didSelectRowIndex selectitle:(NSString *)title{
    _down.selected = NO;
    if (title) {
         [_down setTitle:title forState:UIControlStateNormal ];
    }
}

-(ZeroRainbowView*)zeroRainbow{
    if (!_zeroRainbow) {
        // 彩虹
        _zeroRainbow = [[ZeroRainbowView alloc] initWithFrame:CGRectMake(0, 0, 240*kW_Scale, 240*kW_Scale) type:ZeroRainbowTypeDefault];
        _zeroRainbow.center = CGPointMake(self.view.bounds.size.width - 34*kW_Scale, 273*kH_Scale);
        [self.view addSubview: _zeroRainbow];
    }
    return _zeroRainbow;
}

-(ZeroStarView*)zeroStarView{
    if (!_zeroStarView) {
        //闪亮星星
        _zeroStarView = [[ZeroStarView alloc] initWithFrame:CGRectMake(85*kW_Scale, 175*kH_Scale, 12*kW_Scale, 12*kW_Scale) type:ZeroStarTypeStar];
       
        //旋转大星星 _zeroStarView = [[ZeroStarView alloc] initWithFrameMaxStrat:CGRectMake(75*kW_Scale, 200*kH_Scale, 32*kW_Scale, 32*kW_Scale)];
        [self.view addSubview:_zeroStarView];
    }
    return _zeroStarView;
}

-(ZeroFireworkView*)zeroFirework{
    if (!_zeroFirework) {
        // 烟花
        _zeroFirework= [[ZeroFireworkView alloc] initWithFrame:CGRectMake(60*kW_Scale, 100*kH_Scale, 35*kW_Scale, 35*kW_Scale) type:ZeroFireworkTypeVulgarLine];
        [self.view addSubview:_zeroFirework];
    }
    return _zeroFirework;
}

-(ZeroLineView*)leftMoveView{
    if (!_leftMoveView) {
        _leftMoveView = [[ZeroLineView alloc] initWithFrame:CGRectMake(40*kW_Scale, 150*kH_Scale, 260*kW_Scale, 20*kH_Scale) lineType:ZeroLineTypeAlimentLeft];
        [self.view addSubview:_leftMoveView];
    }
    return _leftMoveView;
}
-(ZeroBubbleView*)zeroBubble{
    if (!_zeroBubble) {
        _zeroBubble = [[ZeroBubbleView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:_zeroBubble];
    }
    return _zeroBubble;
}


- (IBAction)click:(UIButton *)sender {
    _zeroSDCAlertView = [ZeroSDCAlertView zeroSDCAlertViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) delegate:self];
     [_zeroSDCAlertView setAnimationType:ZeroSDCAlertAnimationTypeDefault];
     [_zeroSDCAlertView showWithController:self];
}


- (IBAction)egg:(UIButton *)sender {

    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.keyTimes = @[@0,@0.4,@0.8,@0.9,@1];
    animation.values = @[@1,@0.001,@1.1,@0.9,@1];
    animation.duration = 1.4;
    [_eggImageView.layer addAnimation:animation forKey:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animation.duration/2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _eggImageView.image = [UIImage imageNamed:@"领取后"];

    });
    
}


-(void)starLineAnimation{
    // 移除左移线条
    [_leftMoveView startLeftAnimation];
    // 右移线条
    ZeroLineView *right = [[ZeroLineView alloc] initWithFrame:CGRectMake(40*kW_Scale, 150*kH_Scale, 260*kW_Scale, 24*kH_Scale)lineType:ZeroLineTypeAlimentRigh];
    [self.view  addSubview:right];
}


-(ZeroSDCycleView*)zeroSDCycleView{
    if (!_zeroSDCycleView) {
        _zeroSDCycleView = [ZeroSDCycleView cycleScrollViewWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 190) delegate:self];
        [_zeroSDCycleView setShowPageControl:YES];
        [_zeroSDCycleView  setPageControlStyle:ZeroSDCycleViewPageContolStyleAnimated];
        [_zeroSDCycleView setPageControlAliment:ZeroSDCycleViewPageContolAlimentRight];
        [self.view addSubview:self.zeroSDCycleView];
         [_zeroSDCycleView setAutoScrollTimeInterval:3.5f];
    }
    return _zeroSDCycleView;
}



-(void)requestNetwork{
    
    [[HttpRequestManager sharedManager]requestGetWithPath: URL_Subjects params:nil completed:^(BOOL ret, id obj) {
        if (ret) {
          NSLog(@"%@",obj);
            NSMutableArray*arraySource = [[NSMutableArray alloc]init];
            for (NSDictionary *dic in obj) {
                NSString*banner = [[NSString alloc]init];
                banner =  [dic objectForKey:@"home_banner"];
                [arraySource addObject:banner];
            }
         
            [_zeroSDCycleView setArrayStringUrl:[arraySource copy]];
    
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
