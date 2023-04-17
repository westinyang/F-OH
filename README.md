# F-OH

<img src="entry/src/main/resources/base/media/icon.png" width="128px" />

## 项目介绍

F-OH 是一个 OpenHarmony 平台上 FOSS（Free and Open Source Software，自由开源软件）的应用中心，并提供下载安装支持

F-OH 创建的初衷不论是命名还是愿景都受到了来自 [F-Droid](https://f-droid.org) 的启发，也许 OpenHarmony 背负了太多大家对国产化操作系统及生态的期待，那就让我们用实际行动由开源社区来共同维护和驱动 F-OH 去完成它的使命！

其实我给他想过一个中文的名字叫做：“自由开鸿”，很贴合F-OH的含义，但可能是我太执着太执念与最初的想法，暂时并不想改变它

开源仓库

- [Gitee](https://gitee.com/ohos-dev/f-oh)
- [Github](https://github.com/ohos-dev/f-oh)

## 下载安装

- https://gitee.com/ohos-dev/foh/releases

## 提交应用

> F-OH仅收录自由开源软件，“自由软件必定开源，开源软件未必自由，有些开源许可证对用户过于苛刻，它们就没有被列为自由软件”，引用自由GNU，FSF创始人——Richard Stallman编写的回答：[为什么开源错失了自由软件的重点？](https://www.gnu.org/philosophy/open-source-misses-the-point.zh-cn.html)

> 开发初期，为了最大程度减小后端开发和服务器的投入成本，暂时用自建的Git服务来协作管理应用的元数据

- [F-OH Data](http://170.178.208.105:3000/ohos-dev/F-OH-Data)
- 这里存放了 F-OH 所有应用程序的元数据，开发者在这里PR提交自己的应用
- 打开这个仓库链接，按照里面的指引去提交自己的应用（很简单的）

## 开发计划

客户端

- [x] 首页布局
- [x] 应用游戏（列表和状态同步）
- [x] 应用操作（下载、安装、打开）
- [x] 设置页面
- [x] 关于页面
- [x] 应用更新
- [x] 适配沉浸状态栏、导航栏
- [x] 清空缓存
- [x] 应用详情（简单实现，跳转开源仓库） 
- [ ] 应用详情（完整实现）
- [ ] 丰富首页
- [ ] 应用搜索
- [ ] 下载管理
- [ ] 应用管理
- [ ] 应用元数据源管理

服务端

- [x] 简易的应用元数据源
- [ ] 完整的后端管理系统

## 开发环境

> 如果没有Full-SDk，可以下载我编译好的：https://www.bilibili.com/opus/775167350060089384

- DevEco Studio 3.1 Beta1
- SDK API9 3.2.10.6 Beta5 伪装替换为 Full-SDK API10 4.0.5.3 Canary1

## 兼容测试

- 因为目前我手上只有 一加6T OpenHarmony 3.2 Beta5
- 并没有任何标准系统的开发板，所以说横屏、分辨率等问题暂时无法调试优化

## 截图预览

<img src="screenshot/01.jpg" width="300px" />&emsp;<img src="screenshot/02.jpg" width="300px" />

## 视频演示

https://www.bilibili.com/video/BV1dM411N7CG

## 许可声明

- 本项目是以GPLv3许可开源，你可以根据自由软件基金会发布的 [GNU通用公共许可证](https://www.gnu.org/licenses/gpl.html) 的条款重新分配和/或对其进行修改
- 一些图标是由 [OpenHarmony官方示例](https://gitee.com/openharmony/applications_app_samples) 开发人员制作的

## 赞助捐赠

- 我是一名独立开发者，F-OH和一些开源项目都是我的兴趣投入
- F-OH的元数据服务器目前是自购自建，配置较低不太稳定
- 你的赞助捐赠将是 F-OH 运作的驱动力！（不限于开发板、服务器等）
- 赞助请私信，捐赠点下面的按钮
