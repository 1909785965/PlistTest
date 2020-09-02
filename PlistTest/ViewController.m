//
//  ViewController.m
//  PlistTest
//
//  Created by tpv tpv on 17/12/29.
//  Copyright © 2017年 xumxum. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [self plistStore];
    
    [self userDefaultsStore];
    
    [self readLocalityData];
    
}

-(void)readLocalityData
{
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Property List" ofType:@"plist"]];
    NSLog(@"dict==%@",dict);
    

    NSBundle * myBundle = [NSBundle mainBundle];
    NSString * filePathStr = [myBundle pathForResource:@"zsr" ofType:@"JPG"];
    NSData * imgData = [NSData dataWithContentsOfFile:filePathStr];
    UIImage * image = [UIImage imageWithData:imgData];
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 50, 200, 200)];
    [imageView setImage:image];
    [imageView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:imageView];
    
    NSArray * appArr = [[NSBundle mainBundle]loadNibNamed:@"SecViewVontroller" owner:nil options:nil];
    UIView * getView = [appArr firstObject];
    [self.view addSubview:getView];
    
}

-(void)userDefaultsStore
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"isBool"];
    [defaults synchronize];
    
    BOOL getBool = [defaults objectForKey:@"isBool"];
    if (getBool) {
        NSLog(@"is bool");
    }else{
        NSLog(@"is not bool");
    }
    
    [defaults setInteger:10 forKey:@"Age"];
    [defaults setFloat:12.5 forKey:@"isFloat"];
    [defaults setDouble:12.36 forKey:@"isdouble"];
    [defaults setURL:[NSURL URLWithString:@"www.baidu.com"] forKey:@"isUrl"];
    
    NSArray * arr = @[@"1",@"2",@"3"];
    NSDictionary * dic = @{@"name":@"zsr",@"add":@"xiamen"};
    [defaults setObject:arr forKey:@"isArr"];
    [defaults setObject:dic forKey:@"isDic"];
    
    UIImage *image =[UIImage imageNamed:@"somename"];
    NSData *imageData = UIImageJPEGRepresentation(image, 100);//把image归档为NSData
    [defaults setObject:imageData forKey:@"image"];
    
    [defaults synchronize];//方法synchronise是为了强制存储，其实并非必要，因为这个方法会在系统中默认调用，但是你确认需要马上就存储，这样做是可行的
    
  

    NSInteger age = [defaults integerForKey:@"Age"];
    NSURL * getUrl = [defaults objectForKey:@"isUrl"];
    NSNumber  *getFloat = [defaults objectForKey:@"isFloat"];
    
    NSData * getimageData = [defaults dataForKey:@"image"];
//    UIImage * getimage = [UIImage imageWithData:imageData];
    
    NSLog(@"%d",(int)age);
    NSLog(@"%@",getimageData);
    NSLog(@"%@",getUrl);
    NSLog(@"%@",getFloat);
 

}

-(void)plistStore
{
    //plist文件的归档
    
    NSString * path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString * filePath = [path stringByAppendingPathComponent:@"test.plist"];
    
    NSDictionary * firstDic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSLog(@"读取原来存储的数据==%@",firstDic);
    
    NSDictionary * dic = @{@"001":@"zhangsan",@"002":@"lisi"};
    [dic writeToFile:filePath atomically:YES];
    
    //plist文件的解档
    NSDictionary * getDic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSLog(@"第一次读取==%@",getDic);
    NSDictionary * anotherDic = @{@"001":@"wangwu",@"002":@"lisi"};
    [anotherDic writeToFile:filePath atomically:YES];
    
    NSDictionary * lastDic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSLog(@"第二次读取==%@",lastDic);
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
