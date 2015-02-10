//
//  MJViewController.m
//  表情排列
//
//  Created by 朱正晶 on 15-2-2.
//  Copyright (c) 2015年 China. All rights reserved.
//

#import "MJViewController.h"

#define kImgWH 50
#define kInitCount 13

/*
 1.adjust....方法去掉第2个参数----add:(BOOL)add （不能增加全局变量或者成员变量）
 2.在表情最后面增加一个“+”按钮，添加按钮在尾部添加一个表情（表情图片随机）
 */

@interface MJViewController ()
- (IBAction)selectIndex:(UISegmentedControl *)sender;
- (IBAction)addImage:(UIButton *)sender;

@end

@implementation MJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

	[self addFirstImagesWithColumns:2];
    [self adjustImagePosWithColumns:2];
}

- (void)addFirstImagesWithColumns:(int)columns
{
    // 1.定义列数、间距
    // 每行3列
    //#warning 不一样
    //    int columns = 3;
    // 每个表情之间的间距 = (控制器view的宽度 - 列数 * 表情的宽度) / (列数 + 1)
    CGFloat margin = (self.view.frame.size.width - columns * kImgWH) / (columns + 1);
    
    // 2.定义第一个表情的位置
    // 第一个表情的Y值
    CGFloat oneY = 100;
    // 第一个表情的x值
    CGFloat oneX = margin;
    
    // 3.创建所有的表情
    for (int i = 0; i < kInitCount; i++) {
        // i这个位置对应的列数
        int col = i % columns;
        // i这个位置对应的行数
        int row = i / columns;
        
        // 列数（col）决定了x
        CGFloat x = oneX + col * (kImgWH + margin);
        // 行数（row）决定了y
        CGFloat y = oneY + row * (kImgWH + margin);
        
        //NSLog(@"subviews.count == %d", self.view.subviews.count);
        
        int no = i % 9; // no == [0, 8]
        NSString *imgName = [NSString stringWithFormat:@"01%d.png", no];
        [self addImg:imgName x:x y:y];
    }
}

- (void)addNewImage:(int)columns
{
    // 1.定义列数、间距
    // 每行3列
    //#warning 不一样
    //    int columns = 3;
    // 每个表情之间的间距 = (控制器view的宽度 - 列数 * 表情的宽度) / (列数 + 1)
    CGFloat margin = (self.view.frame.size.width - columns * kImgWH) / (columns + 1);
    
    // 2.定义第一个表情的位置
    // 第一个表情的Y值
    CGFloat oneY = 100;
    // 第一个表情的x值
    CGFloat oneX = margin;
    
    // 3.创建新的表情
    int i = self.view.subviews.count - 1;
    // i这个位置对应的列数
    int col = i % columns;
    // i这个位置对应的行数
    int row = i / columns;

    // 列数（col）决定了x
    CGFloat x = oneX + col * (kImgWH + margin);
    // 行数（row）决定了y
    CGFloat y = oneY + row * (kImgWH + margin);
        
    //NSLog(@"subviews.count == %d", self.view.subviews.count);
    //获取[0, 8]随机数
    int no = arc4random() % 9;
    NSString *imgName = [NSString stringWithFormat:@"01%d.png", no];
    [self addImg:imgName x:x y:y];
}

#pragma mark 调整图片的位置
- (void)adjustImagePosWithColumns:(int)columns
{
    // 1.定义列数、间距
    // 每行3列
    //#warning 不一样
    //    int columns = 3;
    // 每个表情之间的间距 = (控制器view的宽度 - 列数 * 表情的宽度) / (列数 + 1)
    CGFloat margin = (self.view.frame.size.width - columns * kImgWH) / (columns + 1);
    
    // 2.定义第一个表情的位置
    // 第一个表情的Y值
    CGFloat oneY = 100;
    // 第一个表情的x值
    CGFloat oneX = margin;

    // 计算除了segment控件外当前view下有多少控件
    int subViewcount = self.view.subviews.count - 1;
    
    //NSLog(@"subViewCount = %d", subViewcount);
    // 3.创建所有的表情
    for (int i = 0; i < subViewcount; i++) {
        // i这个位置对应的列数
        int col = i % columns;
        // i这个位置对应的行数
        int row = i / columns;
        
        // 列数（col）决定了x
        CGFloat x = oneX + col * (kImgWH + margin);
        // 行数（row）决定了y
        CGFloat y = oneY + row * (kImgWH + margin);
        
// 取出旧的imageview 设置x、y
        // 取出i + 1位置对应的imageView，设置x、y值
        // + 1是为了跳过最前面的UISegmentControl
        UIView *child = self.view.subviews[i + 1];
        // 取出frame
        CGRect tempF = child.frame;
        // 修改x、y
        tempF.origin = CGPointMake(x, y);
        // 重新赋值
        child.frame = tempF;
    }
}


#pragma mark 添加表情 icon:表情图片名
- (void)addImg:(NSString *)icon x:(CGFloat)x y:(CGFloat)y
{
    UIImageView *one = [[UIImageView alloc] init];
    one.image = [UIImage imageNamed:icon];
    one.frame = CGRectMake(x, y, kImgWH, kImgWH);
    [self.view insertSubview:one atIndex:self.view.subviews.count-1];
}


- (IBAction)selectIndex:(UISegmentedControl *)sender {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    
    int columns = sender.selectedSegmentIndex + 2;
    [self adjustImagePosWithColumns:columns];
    
    [UIView commitAnimations];
}

- (IBAction)addImage:(UIButton *)sender {
    
    UISegmentedControl *seg = (UISegmentedControl *)self.view.subviews[0];
    int columns = [seg selectedSegmentIndex] + 2;
    [self addNewImage:columns];
    [self adjustImagePosWithColumns:columns];
}
@end
