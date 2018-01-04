//--------------------------------------拨打电话---------------------------------------//

#import "CallWebView.h"

@implementation CallWebView
+(void)callWithPhoneNumString:(NSString *)phonenum inView:(UIView *)view{
    NSString *str = [NSString stringWithFormat:@"tel:%@",phonenum];
    UIWebView *callWebView = [[UIWebView alloc]init];
    [callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [view addSubview:callWebView];
}
@end
