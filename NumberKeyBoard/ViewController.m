//
//  ViewController.m
//  NumberKeyBoard
//
//  Created by kankanliu on 16/8/16.
//  Copyright © 2016年 jerry. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "UIImage+Extension.h"

#define kSCREENWIDTH  [UIScreen mainScreen].bounds.size.width
#define kSCREENHEIGHT [UIScreen mainScreen].bounds.size.height

#define RGBHex(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

#define normalButtonRedColor    RGBHex(0xffd00c) //普通button的颜色
#define highlightButtonRedColor RGBHex(0xfbc300) //高亮button的颜色
#define prohibitButtonRedColor  [RGBHex(0xffd00c) colorWithAlphaComponent:0.2] //禁止button的颜色

@interface ViewController ()<UITextViewDelegate>{
    CGFloat keyboardKeyHeight;
}
//@property(nonatomic,strong)UIView *keyBoardView;
@property(nonatomic,strong)UITextView *textView;
@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self addNotification];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self removeNotification];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setThePannel];
}

-(void)setThePannel{
    self.title=NSStringFromClass([self class]);
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.textView];
}

-(UITextView *)textView{
    if (!_textView) {
        _textView=[[UITextView alloc]initWithFrame:CGRectMake(0, 64, kSCREENWIDTH, kSCREENHEIGHT/3)];
        _textView.delegate=self;
        _textView.editable=YES;
        _textView.font=[UIFont systemFontOfSize:17 weight:100];
        _textView.textColor=[UIColor blackColor];
        _textView.backgroundColor=[UIColor orangeColor];
        _textView.keyboardType=UIKeyboardTypeNumberPad;
    }
    return _textView;
}

-(UIButton *)keyButton{
    UIButton *keyButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [keyButton setBackgroundColor:[UIColor whiteColor]];
    keyButton.titleLabel.font=[UIFont systemFontOfSize:24];
    [keyButton setBackgroundImage:[UIImage imageWithColor:normalButtonRedColor] forState:UIControlStateNormal];
    [keyButton setBackgroundImage:[UIImage imageWithColor:highlightButtonRedColor] forState:UIControlStateHighlighted];
    [keyButton addTarget:self action:@selector(chooseNumber:) forControlEvents:UIControlEventTouchUpInside];
    return keyButton;
}

-(UIView *)keyBoardViewWithFrame:(CGRect)frame{
    UIView *keyBoardView=[[UIView alloc]initWithFrame:frame];
    keyBoardView.backgroundColor=normalButtonRedColor;
    for (int i=0; i<12; i++) {
        UIButton *keyButton=[self keyButton];
        keyButton.tag=i+1;
        if (keyButton.tag==10) {
            [keyButton setTitle:@"↳" forState:UIControlStateNormal];
        }
        else if (keyButton.tag==11) {
            [keyButton setTitle:@"0" forState:UIControlStateNormal];
        }
        else if (keyButton.tag==12){
            [keyButton setTitle:@"⬅︎" forState:UIControlStateNormal];
        }
        else{
            [keyButton setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
        }
        NSInteger row=[self rowWithcollumnes:3 index:i];
        NSInteger collumn=[self collumnWithCollumnes:3 index:i];
        [keyButton setFrame:CGRectMake(collumn*kSCREENWIDTH/3, row*keyboardKeyHeight, kSCREENWIDTH/3, keyboardKeyHeight)];
        [keyBoardView addSubview:keyButton];
    }
    [keyBoardView addSubview:[self verticalLineWithFrame:CGRectMake(kSCREENWIDTH/3-0.25f, 0, 0.5f, frame.size.height)]];
    [keyBoardView addSubview:[self verticalLineWithFrame:CGRectMake(2*kSCREENWIDTH/3-0.25f, 0, 0.5f, frame.size.height)]];
    [keyBoardView addSubview:[self horizonLineWithFrame:CGRectMake(0, 0, kSCREENWIDTH, 0.5f)]];
    [keyBoardView addSubview:[self horizonLineWithFrame:CGRectMake(0, frame.size.height/4, kSCREENWIDTH, 0.5f)]];
    [keyBoardView addSubview:[self horizonLineWithFrame:CGRectMake(0, frame.size.height*2/4, kSCREENWIDTH, 0.5f)]];
    [keyBoardView addSubview:[self horizonLineWithFrame:CGRectMake(0, frame.size.height*3/4, kSCREENWIDTH, 0.5f)]];
    return keyBoardView;
}


-(NSInteger)rowWithcollumnes:(NSInteger)collumes index:(NSInteger)index {
    NSInteger row=index/collumes;
    return row;
}

-(NSInteger)collumnWithCollumnes:(NSInteger)collumnes index:(NSInteger)index{
    NSInteger collumn=index%collumnes;
    return collumn;
}

-(UIView *)numbetrKeyBoardBoundLineWithFrame:(CGRect)frame{
    UIView *boundLineView=[[UIView alloc]initWithFrame:frame];
    [boundLineView addSubview:[self verticalLineWithFrame:CGRectMake(kSCREENWIDTH/3-0.25f, 0, 0.5f, frame.size.height)]];
    [boundLineView addSubview:[self verticalLineWithFrame:CGRectMake(2*kSCREENWIDTH/3-0.25f, 0, 0.5f, frame.size.height)]];
    [boundLineView addSubview:[self horizonLineWithFrame:CGRectMake(0, 0, kSCREENWIDTH, 0.5f)]];
    [boundLineView addSubview:[self horizonLineWithFrame:CGRectMake(0, frame.size.height/4, kSCREENWIDTH, 0.5f)]];
    [boundLineView addSubview:[self horizonLineWithFrame:CGRectMake(0, frame.size.height*2/4, kSCREENWIDTH, 0.5f)]];
    [boundLineView addSubview:[self horizonLineWithFrame:CGRectMake(0, frame.size.height*3/4, kSCREENWIDTH, 0.5f)]];
    boundLineView.alpha=0.5f;
    boundLineView.userInteractionEnabled=YES;
    return boundLineView;
}

-(UIView *)horizonLineWithFrame:(CGRect)frame{
    UIView *horizonLine=[[UIView alloc]initWithFrame:frame];
    horizonLine.backgroundColor=[UIColor lightGrayColor];
    return horizonLine;
}

-(UIView *)verticalLineWithFrame:(CGRect)frame{
    UIView *verticalLine=[[UIView alloc]initWithFrame:frame];
    verticalLine.backgroundColor=[UIColor lightGrayColor];
    return verticalLine;
}

- (void)keyboardWillShow:(NSNotification *)notification{
    NSDictionary *userInfo = notification.userInfo;
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];// 键盘的frame
    keyboardKeyHeight=keyboardF.size.height/4;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatCount:1];
    [self setKeyboardView];
    [UIView commitAnimations];
}

- (void)setKeyboardView{
    __block UIView *result = [UIView new];
    UIWindow *keyBoardWindow=[self getKeyBoardWindow];
    NSArray *viewArray = [keyBoardWindow subviews];
    for (UIView *tmpView  in viewArray) {
        NSLog(@"tmpView's name:%s",object_getClassName(tmpView));
        if ([[NSString stringWithUTF8String:object_getClassName(tmpView)] isEqualToString:@"UIInputSetContainerView"]) {
            for (UIView *tmpSubView in tmpView.subviews) {
                if ([[NSString stringWithFormat:@"%s",object_getClassName(tmpSubView)] isEqualToString:@"UIInputSetHostView"]) {
                    NSLog(@"tmpSubView's name:%s",object_getClassName(tmpSubView));
                    [tmpSubView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        if (idx==1) {
                            UIView *selfDefineKeyBoardView=[self keyBoardViewWithFrame:obj.frame];
                            [obj addSubview:selfDefineKeyBoardView];
                            result = obj;
                        }
                        else{
                            obj.hidden=YES;
                        }
                    }];
                    break;
                }
            }
        }
    }
}

-(void)chooseNumber:(id)sender{
    UIButton *button=(UIButton *)sender;
    NSLog(@"button.tag:%ld",button.tag);
    switch (button.tag) {
        case 10:
            [self hideKeyBoard];//隐藏键盘
            break;
         case 12:
            [self deleteText];//删除文本
            break;
        default:
            [self inputText:sender];//输入文本
            break;
    }
}

-(void)inputText:(id)sender{
    UIButton *button=(UIButton *)sender;
    NSMutableString *textViewString=[NSMutableString stringWithString:_textView.text];
    if (button.tag==11) {
        [textViewString appendString:@"0"];
    }
    else{
        [textViewString appendString:[NSString stringWithFormat:@"%ld",button.tag]];
    }
    
    
    _textView.text=textViewString;
}

-(void)hideKeyBoard{
    [_textView resignFirstResponder];
}

-(void)deleteText{
    if (_textView.text.length<=0) {
        return;
    }
    NSMutableString *textViewString=[NSMutableString stringWithString:_textView.text];
    [textViewString deleteCharactersInRange:NSMakeRange(_textView.text.length-1, 1)];
    _textView.text=textViewString;
}

-(UIWindow *)getKeyBoardWindow{
    NSArray  *Windows = [UIApplication sharedApplication].windows;
    __block UIWindow *keyBoardWindow =Windows.lastObject;
    [Windows enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *windowName=[NSString stringWithFormat:@"%s",object_getClassName(Windows[idx])];
        if ([windowName isEqualToString:@"UIRemoteKeyboardWindow"]) {
            keyBoardWindow=Windows[idx];
        }
    }];
    return keyBoardWindow;
}

-(void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}

-(void)removeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_textView resignFirstResponder];
}


- (id)getPrivateProperty:(NSString *)propertyName class:(Class)class
{
    Ivar iVar = class_getInstanceVariable([self class], [propertyName UTF8String]);
    
    if (iVar == nil) {
        iVar = class_getInstanceVariable([self class], [[NSString stringWithFormat:@"_%@",propertyName] UTF8String]);
    }
    
    id propertyVal = object_getIvar(self, iVar);
    return propertyVal;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
