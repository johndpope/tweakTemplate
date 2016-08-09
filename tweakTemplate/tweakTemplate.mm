#import "tweakTemplate.h"



__int64 _module_base = 0;





void SaveImage(ImageBuf* Image)
{
    BOOL isDir = FALSE;
    BOOL ok =FALSE;
    static int iCount3=0;
    UIImage *MyImage=nil;
    int nChannels =[Image bytesPerPixel];
    int _dwWidth=[Image width];
    int _dwHeight=[Image height];
    unsigned   char *pBuffer=[Image rawData];
    
    if (nChannels==1) {
          MyImage=[UIImage imageWithGrayData:pBuffer width:_dwWidth height:_dwHeight];
    }
  else
  {
       MyImage=[UIImage initwithImageData:pBuffer size:CGSizeMake(_dwWidth, _dwHeight) orientation:nil];
  }
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSFileManager *fileManage = [NSFileManager defaultManager];
    NSString *myDirectory = [documentsDirectory stringByAppendingPathComponent:@"tempPic"];
    
    
    
    BOOL isDirExist =[fileManage fileExistsAtPath:myDirectory isDirectory:&isDir];
    
    
    if(!(isDirExist && isDir))
        
    {
        ok= [fileManage createDirectoryAtPath:myDirectory withIntermediateDirectories:YES attributes:nil error:nil];
        
    }
    else
    {
        ok=TRUE;
    }
    
    
    if (ok) {
        NSString* desPath =[NSString stringWithFormat:@"%@/%02d_%x_%x_%x.png",myDirectory,iCount3,_dwWidth,_dwHeight,nChannels];
        [UIImagePNGRepresentation(MyImage) writeToFile:desPath atomically:YES];
    }
    
    
    
    iCount3++;

}
void SaveImage2(NSString*strSub,  __int64 Image)
{
    BOOL isDir = FALSE;
    BOOL ok =FALSE;
    static int iCount7=0;
    
    UIImage *MyImage=nil;

    _DWORD __dwWidth=*(_DWORD*)(Image+0xc);
    _DWORD _dwHeight=*(_DWORD*)(Image+0x10);
    _DWORD _dwStrid=*(_DWORD*)(Image+0x20);
    unsigned   char *pBuffer=(unsigned char*)*(_QWORD*)(Image+0x18);
    
    _DWORD _dwUnKnow=*(_DWORD*)(Image+0x28);
    NSData *photoData=nil;
    _DWORD _nChinnel=0;
    _DWORD _dwWidth=0;
    if (__dwWidth!=0) {
       _nChinnel =_dwStrid/__dwWidth;
        if (_nChinnel!=0) {
             _dwWidth=_dwStrid/_nChinnel;
        }
       else
       {
           return;
       }
        
    }
   else
   {
       return;
   }

       
       // MyImage=[UIImage initwithImageData:pBuffer size:CGSizeMake(_dwWidth, _dwHeight) orientation:nil];
           //这里的pBuffer需要检查一下是否为空
    [YYHelper YYLog:[NSString stringWithFormat:@"%d_%d_%d_%d_%d",iCount7,*pBuffer,_nChinnel,_dwWidth,_dwHeight],nil];

    if (_nChinnel==4 ) {
         MyImage=[UIImage initwithImageData:pBuffer size:CGSizeMake(_dwWidth, _dwHeight) orientation:nil];
    }
    else if (_nChinnel==1)
    {
        MyImage=[UIImage imageWithGrayData:pBuffer width:_dwWidth height:_dwHeight];
    }
    else{
         photoData=[[NSData alloc]initWithBytes:pBuffer length:_dwStrid*_dwHeight];
    }
   

            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSFileManager *fileManage = [NSFileManager defaultManager];
            NSString *myDirectory = [documentsDirectory stringByAppendingPathComponent:@"tempPic"];
            
            
            
            BOOL isDirExist =[fileManage fileExistsAtPath:myDirectory isDirectory:&isDir];
            
            
            if(!(isDirExist && isDir))
                
            {
                ok= [fileManage createDirectoryAtPath:myDirectory withIntermediateDirectories:YES attributes:nil error:nil];
                
            }
            else
            {
                ok=TRUE;
            }
            
            
            if (ok) {
                if (photoData!=nil) {
                    NSString* desPath2 =[NSString stringWithFormat:@"%@/%@_%02d_%d_%d_%d.bin",myDirectory,strSub,iCount7,_dwWidth,_dwHeight,_nChinnel];
                     [photoData writeToFile:desPath2 atomically:YES];
                     [photoData release];
                }
                else
                {
                    NSString* desPath2 =[NSString stringWithFormat:@"%@/%@_%02d_%d_%d_%d.png",myDirectory,strSub,iCount7,_dwWidth,_dwHeight,_nChinnel];
                    [UIImagePNGRepresentation(MyImage) writeToFile:desPath2 atomically:YES];
                }
                
            }
            
            iCount7++;
    
}



id (*Old_turnFaceToYounger)(FacedpsEngine *self, SEL  _cmd, ImageBuf *a3, FaceDAInfo *a4, ImageBuf *a5, FaceDAInfo *a6, int64_t a7);
id New_turnFaceToYounger(FacedpsEngine *self, SEL _cmd, ImageBuf *a3, FaceDAInfo *a4, ImageBuf *a5, FaceDAInfo *a6, int64_t a7);
id New_turnFaceToYounger(FacedpsEngine *self, SEL _cmd, ImageBuf *a3, FaceDAInfo *a4, ImageBuf *a5, FaceDAInfo *a6, int64_t a7)
{
    
    
    SaveImage(a3);
    SaveImage(a5);
    
    return Old_turnFaceToYounger(self,_cmd,a3,a4,a5,a6,a7);
}
id (*Old_applyNaturalEffect)(FacedpsEngine *self, SEL  _cmd, ImageBuf *a3, id a4,bool a5);
id New_applyNaturalEffect(FacedpsEngine *self, SEL  _cmd, ImageBuf *a3, id a4,bool a5);
id New_applyNaturalEffect(FacedpsEngine *self, SEL  _cmd, ImageBuf *a3, id a4,bool a5)
{
    
    
    
    SaveImage(a3);
    id ret=Old_applyNaturalEffect(self,_cmd,a3,a4,a5);
    SaveImage(a3);
    return ret;
}
//releas函数
_QWORD*  (*Old_sub_10001252C)(__int64 a1);
_QWORD*   New_sub_10001252C(__int64 a1);
_QWORD*   New_sub_10001252C(__int64 a1)
{

    SaveImage2(@"New_sub_10001252C",a1);
    return Old_sub_10001252C(a1) ;
}
_QWORD*  (*Old_sub_1001D302C)(__int64 a1);
_QWORD*   New_sub_1001D302C(__int64 a1);
_QWORD*   New_sub_1001D302C(__int64 a1)
{
    
    SaveImage2(@"New_sub_1001D302C",a1);
    return Old_sub_1001D302C(a1) ;
}
//releas函数
void  (*Old_sub_1001D34C8)(__int64 a1);
void  New_sub_1001D34C8(__int64 a1);
void  New_sub_1001D34C8(__int64 a1)
{
    SaveImage2(@"New_sub_1001D34C8",a1);
    Old_sub_1001D34C8(a1);

}

__int64 (* Old_sub_1001C4AD0)(__int64 a1, __int64 a2, void *a3, __int64 a4, __int64 a5, __int64 a6, __int64 a7);
__int64 New_sub_1001C4AD0(__int64 a1, __int64 a2, void *a3, __int64 a4, __int64 a5, __int64 a6, __int64 a7);
__int64 New_sub_1001C4AD0(__int64 a1, __int64 a2, void *a3, __int64 a4, __int64 a5, __int64 a6, __int64 a7)
{
    SaveImage2(@"New_sub_1001C4AD0",a2);
    SaveImage2(@"New_sub_1001C4AD0",(__int64)a3);
    __int64 ret=Old_sub_1001C4AD0(a1,a2,a3,a4,a5,a6,a7);
    SaveImage2(@"New_sub_1001C4AD0",a2);
    SaveImage2(@"New_sub_1001C4AD0",(__int64)a3);
    SaveImage2(@"New_sub_1001C4AD0",a4);
    SaveImage2(@"New_sub_1001C4AD0",a5);
    return ret;
}



void sub_hook(__int64 image_base)
{
    
    
    __int64 Addr_subFunc1=(image_base+ 0x100034D58);
    __int64 Addr_subFunc2=(image_base+ 0x1000108A4);
    __int64 Addr_subFunc3=(image_base+0x1001D3094);
    __int64 Addr_subFunc4=(image_base+ 0x1001D34C8);
      __int64 Addr_subFunc4_1=(image_base+ 0x1001D302C);
     __int64 Addr_subFunc5=(image_base+0x1001C4AD0);//第一个关键函数
    __int64 Addr_subFunc6=(image_base+ 0x100011640);


    //MSHookFunction((void *)Addr_subFunc1, (void *)&New_sub_100034D58, (void **)&Old_sub_100034D58);
   MSHookFunction((void *)Addr_subFunc2, (void *)&New_turnFaceToYounger, (void **)&Old_turnFaceToYounger);
    //MSHookFunction((void *)Addr_subFunc3, (void *)&New_sub_10001252C, (void **)&Old_sub_10001252C);
     //MSHookFunction((void *)Addr_subFunc4, (void *)&New_sub_1001D34C8, (void **)&Old_sub_1001D34C8);
    // MSHookFunction((void *)Addr_subFunc4_1, (void *)&New_sub_1001D302C, (void **)&Old_sub_1001D302C);
   //MSHookFunction((void *)Addr_subFunc5, (void *)&New_sub_1001C4AD0, (void **)&Old_sub_1001C4AD0);
    //MSHookFunction((void *)Addr_subFunc6, (void *)&New_applyNaturalEffect, (void **)&Old_applyNaturalEffect);


}
MSInitialize
{
    _module_base =(__int64) _dyld_get_image_vmaddr_slide(0);

    if (_module_base == 0) {
        
    } else {
        //sub_hook(_module_base);
    }
    
    
    //Class class__ImageBuf= objc_getClass("ImageBuf");
   // Class class__FacedpsEngine= objc_getClass("FacedpsEngine");
   // MSHookMessageEx(class__ImageBuf, @selector(releaseRGBAImageBuf), (IMP)&New_releaseRGBAImageBuf, (IMP*)&Old_releaseRGBAImageBuf);
   // MSHookMessageEx(class__ImageBuf, @selector(releaseGrayImageBuf), (IMP)&New_releaseGrayImageBuf, (IMP*)&Old_releaseGrayImageBuf);
   // MSHookMessageEx(class__FacedpsEngine, @selector(turnFaceToYounger:::::), (IMP)&New_turnFaceToYounger, (IMP*)&Old_turnFaceToYounger);
    
    
}