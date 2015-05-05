
//
//  DeviceInfoUtil.m
//  mdm
//
//  Created by Lu Henry on 9/26/12.
//  Copyright (c) 2012 NQ Mobile Inc. All rights reserved.
//
#import <sys/socket.h> // Per msqr
#import <sys/sysctl.h>
#import <net/if.h>
#import <net/if_dl.h>
#import "DeviceInfoUtil.h"
#import <AdSupport/ASIdentifierManager.h>
#import <UIKit/UIKit.h>
@interface process : NSObject {
	struct kinfo_proc data;
}

-(id)initWithKInfo:(struct kinfo_proc*)proc;
-(NSString*)name;
-(NSDate*)startTime;
-(NSString*)startTimeAsFormattedDateTime;

@end



@implementation process

-(id)initWithKInfo:(struct kinfo_proc*)proc {
	memcpy(&data, proc, sizeof(struct kinfo_proc));
	return self;
}

-(NSString*)name{
	return [NSString stringWithCString: data.kp_proc.p_comm encoding:NSUTF8StringEncoding];
}

-(NSDate*)startTime {
    return [NSDate dateWithTimeIntervalSince1970:data.kp_proc.p_un.__p_starttime.tv_sec];
}

- (NSString*)startTimeAsFormattedDateTime {
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date = [self startTime];
    
    // Retrieve the date as a string.
    return [dateFormatter stringFromDate:date];
}

@end



@implementation DeviceInfoUtil

#pragma mark sysctlbyname utils
+ (NSString *) getSysInfoByName:(char *)typeSpecifier
{
    size_t size;
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
    
    char *answer = malloc(size);
    sysctlbyname(typeSpecifier, answer, &size, NULL, 0);
    
    NSString *results = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];
    
    free(answer);
    return results;
}

+ (NSString *) platform
{
    return [DeviceInfoUtil getSysInfoByName:"hw.machine"];
}

#pragma mark platform type and name utils
+ (NSUInteger) platformType
{
    NSString *platform = [DeviceInfoUtil platform];
    
    NSLog(@"\n bug log platform string: %@\n",platform);
    
    // The ever mysterious iFPGA
    if ([platform isEqualToString:@"iFPGA"])        return UIDeviceIFPGA;
    
    // iPhone
    if ([platform isEqualToString:@"iPhone1,1"])    return UIDevice1GiPhone;
    if ([platform isEqualToString:@"iPhone1,2"])    return UIDevice3GiPhone;
    if ([platform hasPrefix:@"iPhone2"])            return UIDevice3GSiPhone;
    if ([platform hasPrefix:@"iPhone3"])            return UIDevice4iPhone;
    if ([platform hasPrefix:@"iPhone4"])            return UIDevice4SiPhone;
    if ([platform hasPrefix:@"iPhone5"])            return UIDevice5iPhone;
    if ([platform hasPrefix:@"iPhone6"])            return UIDevice5SiPhone;
    // iPod
    if ([platform hasPrefix:@"iPod1"])              return UIDevice1GiPod;
    if ([platform hasPrefix:@"iPod2"])              return UIDevice2GiPod;
    if ([platform hasPrefix:@"iPod3"])              return UIDevice3GiPod;
    if ([platform hasPrefix:@"iPod4"])              return UIDevice4GiPod;
    
    // 返回ipadmini
    if ([platform isEqualToString:@"iPad2,5"])    return UIDeviceiPadmini;
    if ([platform isEqualToString:@"iPad2,6"])    return UIDeviceiPadmini;
    if ([platform isEqualToString:@"iPad2,7"])    return UIDeviceiPadmini;
    
    // iPad
    if ([platform hasPrefix:@"iPad1"])              return UIDevice1GiPad;
    if ([platform hasPrefix:@"iPad2"])              return UIDevice2GiPad;
    if ([platform hasPrefix:@"iPad3"])              return UIDevice3GiPad;
    if ([platform hasPrefix:@"iPad4"])              return UIDevice4GiPad;
    

 
    
    // Apple TV
    if ([platform hasPrefix:@"AppleTV2"])           return UIDeviceAppleTV2;
    if ([platform hasPrefix:@"AppleTV3"])           return UIDeviceAppleTV3;
    
    if ([platform hasPrefix:@"iPhone"])             return UIDeviceUnknowniPhone;
    if ([platform hasPrefix:@"iPod"])               return UIDeviceUnknowniPod;
    if ([platform hasPrefix:@"iPad"])               return UIDeviceUnknowniPad;
    if ([platform hasPrefix:@"AppleTV"])            return UIDeviceUnknownAppleTV;
    
    // Simulator thanks Jordan Breeding
    if ([platform hasSuffix:@"86"] || [platform isEqual:@"x86_64"])
    {
        BOOL smallerScreen = [[UIScreen mainScreen] bounds].size.width < 768;
        return smallerScreen ? UIDeviceSimulatoriPhone : UIDeviceSimulatoriPad;
    }
    
    return UIDeviceUnknown;
}

+ (NSString *) platformString
{
    switch ([DeviceInfoUtil platformType])
    {
        case UIDevice1GiPhone: return IPHONE_1G_NAMESTRING;
        case UIDevice3GiPhone: return IPHONE_3G_NAMESTRING;
        case UIDevice3GSiPhone: return IPHONE_3GS_NAMESTRING;
        case UIDevice4iPhone: return IPHONE_4_NAMESTRING;
        case UIDevice4SiPhone: return IPHONE_4S_NAMESTRING;
        case UIDevice5iPhone: return IPHONE_5_NAMESTRING;
        case UIDevice5SiPhone: return IPHONE_5S_NAMESTRING;
        case UIDeviceUnknowniPhone: return IPHONE_UNKNOWN_NAMESTRING;
            
        case UIDevice1GiPod: return IPOD_1G_NAMESTRING;
        case UIDevice2GiPod: return IPOD_2G_NAMESTRING;
        case UIDevice3GiPod: return IPOD_3G_NAMESTRING;
        case UIDevice4GiPod: return IPOD_4G_NAMESTRING;
        case UIDeviceUnknowniPod: return IPOD_UNKNOWN_NAMESTRING;
            
        case UIDevice1GiPad : return IPAD_1G_NAMESTRING;
        case UIDevice2GiPad : return IPAD_2G_NAMESTRING;
        case UIDevice3GiPad : return IPAD_3G_NAMESTRING;
        case UIDevice4GiPad : return IPAD_4G_NAMESTRING;
        case UIDeviceiPadmini: return IPAD_MINI_NAMESTRING;
        case UIDeviceUnknowniPad : return IPAD_UNKNOWN_NAMESTRING;
            
        case UIDeviceAppleTV2 : return APPLETV_2G_NAMESTRING;
        case UIDeviceAppleTV3 : return APPLETV_3G_NAMESTRING;
        case UIDeviceAppleTV4 : return APPLETV_4G_NAMESTRING;
        case UIDeviceUnknownAppleTV: return APPLETV_UNKNOWN_NAMESTRING;
            
        case UIDeviceSimulator: return SIMULATOR_NAMESTRING;
        case UIDeviceSimulatoriPhone: return SIMULATOR_IPHONE_NAMESTRING;
        case UIDeviceSimulatoriPad: return SIMULATOR_IPAD_NAMESTRING;
        case UIDeviceSimulatorAppleTV: return SIMULATOR_APPLETV_NAMESTRING;
            
        case UIDeviceIFPGA: return IFPGA_NAMESTRING;
            
        default: return IOS_FAMILY_UNKNOWN_DEVICE;
    }
}


+ (NSString*) getName{
    return [UIDevice currentDevice].name;
}

+ (NSString*) getModel{
    return [DeviceInfoUtil platformString];
}

+ (NSString*) getModelType{
    NSString *model = [UIDevice currentDevice].model;
    if ([model hasPrefix:@"iPhone"]) {
        return @"20";
    }else if ([model hasPrefix:@"iPad mini"]){
        return @"22";
    }else if ([model hasPrefix:@"iPad"]){
        if (UIDeviceiPadmini== [DeviceInfoUtil platformType]) {
            return @"22";
        }
        return @"21";
    }else if ([model hasPrefix:@"iPod"]){
        return @"23";
    }else{
        return @"24";
    }
}

+ (NSString*) getOS{
    return [UIDevice currentDevice].systemName;
}

+ (NSString*) getOSType{
    return @"2";
}

+ (NSString*) getOSVersion{
    return [UIDevice currentDevice].systemVersion;
}

+ (NSString*) getUDID{
    //return [[UIDevice currentDevice] uniqueIdentifier];
    UIDevice *device = [UIDevice currentDevice];
    if ([device respondsToSelector:@selector(identifierForVendor)]) {
        return [[device identifierForVendor] UUIDString];
    }else {
        return [self getUUID];
    }

}

+ (NSString*)getUUID
{
    CFUUIDRef     myUUID;
    CFStringRef   myUUIDString;
    char          strBuffer[100];
    
    myUUID = CFUUIDCreate(kCFAllocatorDefault);
    myUUIDString = CFUUIDCreateString(kCFAllocatorDefault, myUUID);
    
    // This is the safest way to obtain a C string from a CFString.
    CFStringGetCString(myUUIDString, strBuffer, 100, kCFStringEncodingASCII);
    NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingASCII);
    NSString *ret = [NSString stringWithCString:strBuffer encoding:encoding];
    CFRelease(myUUID);
    CFRelease(myUUIDString);
    return ret;
}

+ (NSString*) getCurDateTime{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    [dateFormatter release];
    return  dateString;
}

+ (NSString*) getJailBreakStatus{
    BOOL jailbroken = NO;
    NSString *cydiaPath = @"/Applications/Cydia.app";
    NSString *aptPath = @"/private/var/lib/apt/";
    if ([[NSFileManager defaultManager] fileExistsAtPath:cydiaPath]) {
        jailbroken = YES;
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:aptPath]) {
        jailbroken = YES;
    }
    
    //另一种方式 发送linux命令
    //    if (system("ls") == 0) {
    //        NSLog(@"越狱成功");
    //    }
    return jailbroken?@"1":@"0";
}

+ (NSArray*)getBSDProcessList {
    int                 err;
    
    static const int    name[] = { CTL_KERN, KERN_PROC, KERN_PROC_ALL, 0 };
    size_t              length;
	int					count;
	NSMutableArray		*procArray = [[NSMutableArray alloc] init];
    
    
	length = 0;
	err = sysctl( (int *) name, (sizeof(name) / sizeof(*name)) - 1, NULL, &length, NULL, 0);
	if (err == -1) {
		err = errno;
	}
    
	if (err == 0) {
		struct kinfo_proc	*procBuffer;
		procBuffer = malloc(length);
		if(procBuffer == NULL){
			return nil;
		}
        
		err = sysctl( (int *) name, (sizeof(name) / sizeof(*name)) - 1, procBuffer, &length, NULL, 0);
		if (err == -1) {
			err = errno;
		}
		if (err == 0) {
		} else if (err == ENOMEM) {
			err = 0;
		}
        
		count = length / sizeof(struct kinfo_proc);
		for(int i = 0; i < count; i++){
			[procArray addObject:[[[process alloc] initWithKInfo:&(procBuffer[i])] autorelease]];
		}
		free(procBuffer);
	}
    
    return [procArray autorelease];
}

+ (process*)getKernelTaskProcess {
    process *kernel_taskProcess;
    NSArray *processes = [DeviceInfoUtil getBSDProcessList];
    
    for (process *p in processes) {
        if ([[p name] isEqualToString:@"kernel_task"]) {
            kernel_taskProcess = p;
        }
    }
    return kernel_taskProcess;
}

+ (NSString*) getUpTime {
    process *p = [self getKernelTaskProcess];
    NSTimeInterval systemUptimeInterval = [[NSDate date] timeIntervalSinceDate:[p startTime]];
    
    return [NSString stringWithFormat:@"%.0f", systemUptimeInterval];
    //return [p startTimeAsFormattedDateTime];
}


#pragma mark MAC addy
+ (NSString *) macaddress
{
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Error: Memory allocation error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2\n");
        free(buf); // Thanks, Remy "Psy" Demerest
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    
    free(buf);
    return outstring;
}

+ (NSString *)imei
{
//    return [UIDevice currentDevice].imei;
    return nil;
}

+ (NSString *) serialnumber
{
    return @"";//[UIDevice currentDevice].serialnumber;
}

+ (NSString *)systemLanguage
{
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defs objectForKey:@"AppleLanguages"];
    NSString *preferredLang = [languages objectAtIndex:0];
    NSLog(@"Preferred Language:%@", preferredLang);
    return preferredLang;
}

+ (NSString *)IDFA
{
    NSString *adId = nil;
    
    if ([[UIDevice currentDevice].systemVersion floatValue]>= 6.0) {
        adId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    } else {
//        adId = [UIDevice currentDevice].imei;
    }
    return adId;
}

@end
