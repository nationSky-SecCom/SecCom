//
//  UserInfoViewController.m
//  SecCom
//
//  Created by duanran on 15/4/29.
//  Copyright (c) 2015年 LB. All rights reserved.
//

typedef enum
{
    uploadPortraitAlertTag                  = 0,
    authStatusTag                           = 1,
    
    
}alertTag;
#import "UserInfoViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "VendorMacro.h"
#import "LBFinder.h"

@interface UserInfoViewController ()
@property (nonatomic, strong) NSMutableArray *assets;

@end



@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"个人信息";
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSString *userPortrait=[NSString stringWithFormat:@"%@",[userDefault objectForKey:@"userPortrait"]];
   
    NSString*imgPath=getUserImgPath(getUserPath(getProJectPath(@"seccom"), @"dr"));
    NSString *userPortraitImgPath=[imgPath stringByAppendingPathComponent:userPortrait];

    UIImage *userPortraitImg=[UIImage imageWithContentsOfFile:userPortraitImgPath];
    
    [self.userPortraitBtn setBackgroundImage:userPortraitImg forState:UIControlStateNormal];
    
    

    
    

    
    
}
-(IBAction)uploadUserPortrait:(id)sender
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"头像上传" message:nil delegate:self cancelButtonTitle:@"相册" otherButtonTitles:@"拍照", nil];
    alert.tag=uploadPortraitAlertTag;
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==uploadPortraitAlertTag) {
        if (buttonIndex==0) {
            [self takePicture:nil];
        }
        else
        {
            [self Open:nil];
        }
    }
    else if (alertView.tag==authStatusTag)
    {
        
    }
    
}
- (IBAction)Open:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    picker.delegate=self;
    if(authStatus ==AVAuthorizationStatusRestricted){
        NSLog(@"Restricted");
    }else if(authStatus == AVAuthorizationStatusDenied){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"请在设备的'设置-隐私-相机'中允许访问相机。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        alert.tag=authStatus,
        [alert show];
        
    }
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
        picker.mediaTypes = @[(NSString*)kUTTypeImage];
        //        picker.allowsEditing = YES;
        
        
    }
    [self presentViewController:picker animated:YES completion:^(void){}];
    
}
- (void)takePicture:(id)sender
{
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        if (!self.assets)
            self.assets = [[NSMutableArray alloc] init];
        CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
        picker.maximumNumberOfSelection = 1;
        picker.delegate=self;
        [self presentViewController:picker animated:YES completion:NULL];
    }
    
}
#pragma mark-相册回调
-(void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    for (int i=0; i<assets.count; i++) {
        ALAsset *asset = [assets objectAtIndex:i];
        ALAssetRepresentation *representation = asset.defaultRepresentation;
        UIImage *image = [UIImage imageWithCGImage:representation.fullResolutionImage
                                             scale:1.0f
                                       orientation:(UIImageOrientation)representation.orientation];
        
        [self saveImage:image withName:@"default.jpg"];
      
    }
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self saveImage:image withName:@"default.jpg"];
   
    
}
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 1.0);
    
    
    NSString *userImgPath=getUserImgPath(getUserPath(getProJectPath(@"seccom"), @"dr"));
    
    NSString *fullPath = [userImgPath stringByAppendingPathComponent:imageName];
    [imageData writeToFile:fullPath atomically:NO];
    NSFileManager *file=[NSFileManager defaultManager];
    BOOL ret=[file fileExistsAtPath:fullPath];
    NSString *imgPathLastCompontStr=[fullPath lastPathComponent];
    if (ret==YES) {
        NSLog(@"存储成功");
        UIImage *image=[UIImage imageWithContentsOfFile:fullPath];
        
        NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
        [userDefault setValue:imgPathLastCompontStr forKey:@"userPortrait"];
        [self.userPortraitBtn setBackgroundImage:image forState:UIControlStateNormal];
    }
    else
    {
        NSLog(@"存储失败");
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
