
#import "RNBkmexpress.h"
#import <BKMExpress/BKMExpress.h>

@implementation RNBkmexpress
- (dispatch_queue_t)methodQueue{
    return dispatch_get_main_queue();
}

RCT_EXPORT_MODULE();

RCTResponseSenderBlock _callback;

RCT_EXPORT_METHOD(kkBexStart:(NSString *)TICKET_ID
                  TICKET_PATH:(NSString *)TICKET_PATH
                  TICKET_TOKEN:(NSString *)TICKET_TOKEN
                  ENVIRONMENT:(NSString *)ENVIRONMENT
                  callback:(RCTResponseSenderBlock)callback)
{
    if (TICKET_ID == (id)[NSNull null] || TICKET_ID.length == 0 ) NSLog(@"BKMExpress Log TICKET_ID is null");
    if (TICKET_TOKEN == (id)[NSNull null] || TICKET_TOKEN.length == 0 ) NSLog(@"BKMExpress Log TICKET_TOKEN is null");
    if (TICKET_PATH == (id)[NSNull null] || TICKET_PATH.length == 0 ) NSLog(@"BKMExpress Log TICKET_PATH is null");

    NSLog(@"BKMExpress Log BKM_TICKET_ID = %@", TICKET_ID);
    NSLog(@"BKMExpress Log BKM_TICKET_TOKEN = %@", TICKET_TOKEN);
    NSLog(@"BKMExpress Log BKM_TICKET_PATH = %@", TICKET_PATH);
    NSLog(@"BKMEXPRESS - MYLOG ENVIRONMENT = %@", ENVIRONMENT);
    
    // instantiate view controller with custom constructor
    BKMExpressPaymentViewController *expressPaymentViewController= [[BKMExpressPaymentViewController alloc] initWithBexTicketToken:TICKET_TOKEN bexTicketPath:TICKET_PATH bexTicketId:TICKET_ID delegate:self];
    
    _callback = [callback copy];
//    NSString *deviceName = @"SUCCESS";
//    callback(@[[NSNull null], deviceName]);
    
    // if debug mode is enabled, this sdk connect to preprod otherwise connect to prod.
    if(ENVIRONMENT == @"PRERPOD") {
        NSLog(@"BKMEXPRESS - MYLOG ENVIRONMENT PREPROD ON");
        [expressPaymentViewController setEnableDebugMode:YES];
    }
    
    // Present view controller
    UIViewController *rootController = UIApplication.sharedApplication.keyWindow.rootViewController;
    
    while (rootController.presentedViewController != nil)
    {
        rootController = rootController.presentedViewController;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [rootController presentViewController:expressPaymentViewController animated:YES completion:nil];
    });
}



- (void)bkmExpressPaymentDidCompleteWithPOSResult:(BKMPOSResult *)posResult{
    NSLog(@"Successful payment");
    NSString *result = @"0";
    _callback(@[[NSNull null], result]);
}

- (void)bkmExpressPaymentDidFail:(NSError *)error{
    NSLog(@"An error has occurred on payment = %@", error.localizedDescription);
    NSString *result = @"2";
    _callback(@[[NSNull null], result]);
}

- (void)bkmExpressPaymentDidCancel{
    NSLog(@"Payment is canceled by user");
    NSString *result = @"1";
    _callback(@[[NSNull null], result]);
}

- (NSDictionary *)constantsToExport
{    
    return @{ @"getMethod": @"1" };
}

@end
  
