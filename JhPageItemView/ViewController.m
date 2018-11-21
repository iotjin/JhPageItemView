//
//  ViewController.m
//  JhPageItemView
//
//  Created by Jh on 2018/11/16.
//  Copyright © 2018 Jh. All rights reserved.
//

#import "ViewController.h"
#import "JhPageItemView.h"
#import "MJExtension.h"
#import "JhPageItemModel.h"

#define Kwidth  [UIScreen mainScreen].bounds.size.width
#define Kheight  [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<JhPageItemViewDelegate>

/** item数组 */
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) JhPageItemView *pageItemView;
@property (nonatomic, strong) JhPageItemView *pageItemView2;
@property (nonatomic, strong) JhPageItemView *pageItemView3;

@end

@implementation ViewController

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
        
//        NSArray *data = @[
//                          @{
//                              @"text" : @"1",
//                              @"img" : @"play",
//                              },
//                          @{
//                              @"text" : @"2",
//                              @"img" : @"play",
//                              },
//                          ];
//
//     self.dataArray = [JhPageItemModel mj_objectArrayWithKeyValuesArray:data];
        
        
        NSMutableArray *tempArr = [NSMutableArray new];
        
        for (int i=0; i<21; i++) {
            
            NSString *text = [NSString stringWithFormat:@"%d",i];
            NSString *img = @"play";
            
            NSMutableDictionary *dict =[NSMutableDictionary new];
            [dict setValue:text forKey:@"text"];
            [dict setValue:img forKey:@"img"];
            [tempArr addObject:dict];
           
         }

        self.dataArray = [JhPageItemModel mj_objectArrayWithKeyValuesArray:tempArr];
        
    }
    return _dataArray;
}






- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    //UIcollectionview 默认样式
    [self pageItemView];
    self.pageItemView.dataArray = self.dataArray;
    
    // 自定义样式
    [self pageItemView2];
    self.pageItemView2.dataArray = self.dataArray;

    // 自定义样式
    [self pageItemView3];
    self.pageItemView3.dataArray = self.dataArray;

    
    
}


-(JhPageItemView *)pageItemView{
    if (!_pageItemView) {
        
        CGRect femwe =  CGRectMake(0, 100, Kwidth, 90*2+3*2+5*2);
        JhPageItemView *view =  [[JhPageItemView alloc]initWithFrame:femwe withmaxColumn:5 maxRow:2];
        view.backgroundColor = [UIColor redColor];
        view.kTopBottomMargin = 3;
        view.kLeftRightMargin = 10;
        view.itemHorizontalMargin = 5.f;
        view.itemVerticalMargin = 5.f;
        view.current_BGColor=[UIColor greenColor];
        view.layoutStyle = JhSystemHorizontalArrangement;
        view.delegate =self;
        self.pageItemView = view;
        [self.view addSubview: self.pageItemView];
        
    }
    return _pageItemView;
}


-(JhPageItemView *)pageItemView2{
    if (!_pageItemView2) {
        
        CGRect femwe =  CGRectMake(0, 350, Kwidth, 90*2+5*2+5*2);
        JhPageItemView *view =  [[JhPageItemView alloc]initWithFrame:femwe withmaxColumn:5 maxRow:2];
        view.backgroundColor = [UIColor redColor];
        view.kTopBottomMargin = 5;
        view.kLeftRightMargin = 10;
        view.itemHorizontalMargin = 5.f;
        view.itemVerticalMargin = 5.f;
        view.current_BGColor=[UIColor yellowColor];
        view.layoutStyle = JhCustomHorizontalArrangement;
        
        view.PageControlStyle = JhPageControlStyelDotAndRectangle;//圆点 + 长条 样式
        view.PageControlContentMode = JhPageControlContentModeRight;
        view.PageControlMarginSpacing = 10;
        view.PageControlSpacing = 5;

        view.delegate =self;
        self.pageItemView2 = view;
        [self.view addSubview: self.pageItemView2];
        
    }
    return _pageItemView2;
}



-(JhPageItemView *)pageItemView3{
    if (!_pageItemView3) {
        
        CGRect femwe =  CGRectMake(0, 600, Kwidth, 90*1+5*2+5*2);
        JhPageItemView *view =  [[JhPageItemView alloc]initWithFrame:femwe withmaxColumn:5 maxRow:1];
        view.backgroundColor = [UIColor redColor];
        view.kTopBottomMargin = 5;
        view.kLeftRightMargin = 10;
        view.itemHorizontalMargin = 5.f;
        view.itemVerticalMargin = 5.f;
        view.current_BGColor = [UIColor greenColor];
        
        view.layoutStyle = JhCustomHorizontalArrangement;
        view.PageControlContentMode = JhPageControlContentModeLeft;
        view.PageControlStyle = JhPageControlStyelRectangle;//长条样式
        view.PageControlMarginSpacing =10;
        view.PageControlSpacing = 5;
        
        view.delegate =self;
        self.pageItemView3 = view;
        [self.view addSubview: self.pageItemView3];
        
//        view.pageControlIsHidden = YES;
        
    }
    return _pageItemView3;
}

- (void)JhPageItemViewDelegate:(JhPageItemView *)JhPageItemViewDeleagte indexPath:(NSIndexPath * )indexPath{
    
    NSLog(@"点击cell --- indexPath --- %@",indexPath);
    
}

@end
