#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(ImageDominantColor, NSObject)

RCT_EXTERN_METHOD(getColor:
                  (NSString *)imageUrl
                  withResolver: (RCTPromiseResolveBlock)resolve
                  withRejecter: (RCTPromiseRejectBlock)reject
                  )

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

@end
