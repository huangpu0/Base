/*
 将项目中所有的接口写在这里,方便统一管理,降低耦合
 
 这里通过宏定义来切换你当前的服务器类型,
 将你要切换的服务器类型宏后面置为真(即>0即可),其余为假(置为0)
 如下:现在的状态为测试服务器
 这样做切换方便,不用来回每个网络请求修改请求域名,降低出错事件
 */

#ifndef InterfaceParameterList_h
#define InterfaceParameterList_h

/**
 Version 对应的值有v1
 develop 是开发版本接口
 preview 预览版
 released 是线上版本接口
 */

#define DevelopServer  0
#define PreviewServer  1
#define ReleasedServer 0

#if   DevelopServer

#define DEMO_SERVER @"http://caiyiquan.082818.com/api/Client/ApiHandle.ashx"//加密接口

#elif PreviewServer

#define DEMO_SERVER @"http://caiyiquan.082818.com/api"//加密接口

#elif ReleasedServer

#define DEMO_SERVER @"http://caiyiquan.082818.com"//加密接口

#endif

/**
 对应模块详情地址 -- >> URL
 */

#define MD_GetBannerPhotoList @"GetBannerPhotoList"//首页广告

#endif /* InterfaceParameterList_h */