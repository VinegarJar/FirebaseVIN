//
//  ZeroSDCDownMenu.m
//  ZeroSDCycleView
//
//  Created by ZeroSmile on 2017/10/1.
//  Copyright © 2017年 陈美安. All rights reserved.
//  

#import "ZeroSDCDownMenu.h"
#import "ZeroSDCSafety.h"
#import " ZeroSDCHeader.h"
@interface ZeroSDCDownMenu ()<UITableViewDataSource,
UITableViewDelegate>
@property(nonatomic,strong)UIView *menuBlackView;
@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic,copy)NSArray*arraySource;
@property (nonatomic,assign)CGFloat rowHeight;
@end

@implementation ZeroSDCDownMenu

- (instancetype)initWithArraySource:(NSArray*)arraySource rowHeight:(CGFloat)rowHeight{
    if (self = [super initWithFrame:([UIScreen mainScreen].bounds)]) {
        self.backgroundColor = [UIColor clearColor];
        _arraySource = arraySource;
        _rowHeight = rowHeight;
         self.hidden = YES;
    }
    return self;
}


-(UITableView *)tableView{
    if (!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH , 0) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
         [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    }
    return _tableView;
}

-(UIView*)menuBlackView{
    if (!_menuBlackView) {
        _menuBlackView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH , SCREEN_HEIGHT-64)];
        _menuBlackView.backgroundColor = [UIColor colorWithRed:(0)/255.0f green:(0)/255.0f blue:(0)/255.0f alpha:(0.6)];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissView)];
        [_menuBlackView addGestureRecognizer:tapGesture];
    }
    return _menuBlackView;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = [_arraySource SafetyObjectAtIndex:indexPath.row];
     cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arraySource.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self dismissAlertView];

    if ([self.delegate respondsToSelector:@selector(didSelectRowIndex:selectitle:)]){
        [self.delegate didSelectRowIndex:self selectitle:[_arraySource SafetyObjectAtIndex:indexPath.row]];
    }
}

-(void)dismissView{
     [self dismissAlertView];
    if ([self.delegate respondsToSelector:@selector(didSelectRowIndex:selectitle:)]){
        [self.delegate didSelectRowIndex:self selectitle:nil];
    }
}

-(void)showAlertView{
    [self addSubview:self.menuBlackView];
    [self addSubview:self.tableView];
    [self.tableView reloadData];
    [UIView animateWithDuration:0.25f animations:^{
        self.menuBlackView.alpha = 1;
        self.hidden = NO;
        self.tableView.frame = CGRectMake(0, 64, SCREEN_WIDTH, _rowHeight * self.arraySource.count);
    }];
}

-(void)dismissAlertView{
    [UIView animateWithDuration:0.25f animations:^{
        self.menuBlackView.alpha = 0;
        self.tableView.frame = CGRectMake(0, 64, SCREEN_WIDTH, 0);
    } completion:^(BOOL finished) {
        [self.menuBlackView removeFromSuperview];
         self.hidden = YES;
    }];
    
}
@end
