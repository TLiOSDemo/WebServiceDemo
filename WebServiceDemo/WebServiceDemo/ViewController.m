//
//  ViewController.m
//  WebServiceDemo
//
//  Created by Andrew on 14-8-22.
//  Copyright (c) 2014年 Andrew. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()<NSXMLParserDelegate>{
    NSXMLParser *xmlParser;
}
@property (strong, nonatomic) IBOutlet UILabel *showLb;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)requestWebService:(id)sender {
  
    //请求发送到的路径
    
    
    
    NSString *urlStr=@"http://fzoa.huayedc.com:8091/uapws/service/nc.itf.service.IHYService?wsdl";
    
    NSURL *url=[NSURL URLWithString:urlStr];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest addValue: @"text/xml;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [urlRequest addValue: @"http://localhost:8080/SampleWebService/webservice/HelloWorld" forHTTPHeaderField:@"SOAPAction"];
    [urlRequest addValue:@"1000" forHTTPHeaderField:@"Content-Length"];
    [urlRequest setHTTPMethod:@"POST"];
//    [urlRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    //请求
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    theConnection = nil;
    
}

//如果调用有错误，则出现此信息
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"ERROR with theConenction");
    UIAlertView * alert =
    [[UIAlertView alloc]
     initWithTitle:@"提示"
     message:[error description]
     delegate:self
     cancelButtonTitle:nil
     otherButtonTitles:@"OK", nil];
    [alert show];
}

//调用成功，获得soap信息
-(void) connection:(NSURLConnection *) connection didReceiveData:(NSData *)responseData
{
    NSString * returnSoapXML = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"返回的soap信息是：%@",returnSoapXML);
    //开始解析xml
    xmlParser = [[NSXMLParser alloc] initWithData: responseData];
    [xmlParser setDelegate:self];
    [xmlParser setShouldResolveExternalEntities: YES];
    [xmlParser parse];
  
    
}

@end
