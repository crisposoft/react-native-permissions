#import "RNPermissionHandlerLocationAlways.h"

#import <CoreLocation/CoreLocation.h>

@interface RNPermissionHandlerLocationAlways() <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) void (^resolve)(RNPermissionStatus status);
@property (nonatomic, strong) void (^reject)(NSError *error);

@end

@implementation RNPermissionHandlerLocationAlways

+ (NSArray<NSString *> * _Nonnull)usageDescriptionKeys {
  return @[@"NSLocationAlwaysAndWhenInUseUsageDescription"];
}

+ (NSString * _Nonnull)handlerUniqueId {
  return @"ios.permission.LOCATION_ALWAYS";
}

- (void)checkWithResolver:(void (^ _Nonnull)(RNPermissionStatus))resolve
                 rejecter:(void (__unused ^ _Nonnull)(NSError * _Nonnull))reject {
  reject(nil);
}

- (void)requestWithResolver:(void (^ _Nonnull)(RNPermissionStatus))resolve
                   rejecter:(void (^ _Nonnull)(NSError * _Nonnull))reject {
  reject(nil);
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
  [self checkWithResolver:_resolve rejecter:_reject];
}

@end
