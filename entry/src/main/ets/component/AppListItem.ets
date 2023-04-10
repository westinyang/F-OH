/*
 * Copyright (C) 2023 westinyang https://gitee.com/ohos-dev
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import {AppInfo, AppActionText, AppStatus} from '../model/AppInfo';
import request from '@ohos.request';
import promptAction from '@ohos.promptAction';
import installer from '@ohos.bundle.installer';
import fs from '@ohos.file.fs';
import bundleManager from '@ohos.bundle.bundleManager';
import hilog from '@ohos.hilog';

const ToastDuration = 1000

@Component
export default struct AppListItem {
  @State appInfo: AppInfo = null;
  @State mainAbilityName: string = '';
  @State installLoading: boolean = false;

  aboutToAppear() {
    // 检查应用是否已经安装，并获取指定包名应用的启动Ability名
    let bundleName = this.appInfo.packageName;
    let bundleFlags = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_HAP_MODULE | bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_ABILITY;
    let userId = 100;
    try {
      bundleManager.getBundleInfo(bundleName, bundleFlags, userId, (err, data) => {
        if (err) {
          // 获取失败
          hilog.error(0x0000, 'testTag', 'getBundleInfo failed: %{public}s', err.message);
        } else {
          // 获取成功
          hilog.info(0x0000, 'testTag', 'getBundleInfo successfully: %{public}s', JSON.stringify(data));
          this.appInfo.status = AppStatus.INSTALLED;
          this.appInfo.actionText = AppActionText.OPEN;
          this.mainAbilityName = data.hapModulesInfo[0].mainElementName;
        }
      });
    } catch (err) {
      hilog.error(0x0000, 'testTag', 'getBundleInfo failed: %{public}s', err.message);
    }
  }

  build() {
    // 应用信息行
    Flex({
      direction: FlexDirection.Row,
      justifyContent: FlexAlign.SpaceBetween,
      alignItems: ItemAlign.Center
    }) {
      // 左 应用图标
      Column() {
        Image(this.appInfo.icon || $r('app.media.icon'))
      }
      .width(55)
      .height('100%')
      .border({width: 0.7, radius: 13, color: '#ebebeb'})
      .flexShrink(0)

      // 中 应用信息
      Column() {
        Text(this.appInfo.name).fontSize(16).margin({top: 2, bottom: 5}).maxLines(1).textOverflow({overflow: TextOverflow.Ellipsis})
        Text(this.appInfo.desc).fontSize(12).maxLines(2).textOverflow({overflow: TextOverflow.Ellipsis})
      }
      .height('100%')
      .margin({left: 10, right: 10})
      .alignItems(HorizontalAlign.Start)
      .flexGrow(1)
      .justifyContent(FlexAlign.Start)

      // 右 安装按钮
      Column() {
        Stack() {
          Button(this.appInfo.actionText.toString())
            .width('100%').height(26).fontSize(14).fontColor('#3478f6').backgroundColor('#eeeeee')
            .onClick(()=>{
              this.appAction();
            })

          Button() {
            Row() {
              LoadingProgress().width('100%').height('100%').color('#3478f6')
            }.alignItems(VerticalAlign.Center).width('100%').height('100%')
          }
          .width('100%').height(26).fontSize(14).fontColor('#3478f6').backgroundColor('#eeeeee')
          .visibility(this.installLoading ? Visibility.Visible : Visibility.None)
        }
      }
      .width(60)
      .height('100%')
      .flexShrink(0)
      .justifyContent(FlexAlign.Center)
    }
    .height(55)
  }

  appAction() {
    if (this.appInfo.status == AppStatus.NOT_INSTALLED) {
      // 未安装（下载或下载并安装）
      this.installLoading = true;
      this.downloadApp()
    } else {
      // 已安装（打开）
      this.openApp()
    }
  }

  downloadApp() {
    let _this = this;
    let downloadTask;

    // 下载路径，示例: /data/storage/el2/base/haps/entry/files/org.ohosdev.deviceinfo-v1.0.0.hap
    let filePath = globalThis.abilityContext.filesDir + '/' + this.appInfo.packageName + '-' + this.appInfo.version + ".hap";

    // 判断文件是否存在
    fs.access(filePath).then((res) => {
      if (res) {
        // 存在，直接安装
        this.installApp(filePath);
      } else {
        // 不存在，下载并安装
        try {
          request.downloadFile(globalThis.abilityContext, {
            url: this.appInfo.hapUrl,
            filePath: filePath
          }).then((data) => {
            downloadTask = data;
            // 监听下载完成
            downloadTask.on('complete', function callback() {
              console.info('Download task completed.');
              // 安装应用
              _this.installApp(filePath);
            });
            // 监听下载失败
            downloadTask.on('fail', function callBack(err) {
              console.info('Download task failed. Cause:' + err);
              this.installLoading = false;
              promptAction.showToast({ message: '下载失败', duration: ToastDuration });
            });
          }).catch((err) => {
            console.error('Failed to request the download. Cause: ' + JSON.stringify(err));
            this.installLoading = false;
          })
        } catch (err) {
          // err.message: bad file path   Download File already exists
          console.error('err.code : ' + err.code + ', err.message : ' + err.message);
          this.installLoading = false;
        }
      }
    }).catch((err) => {
      console.info("access failed with error message: " + err.message + ", error code: " + err.code);
      this.installLoading = false;
    });
  }

  // 安装应用
  installApp(hapPath: string) {
    let hapFilePaths = [hapPath];
    let installParam = {
      userId: 100,
      isKeepData: false,
      installFlag: 1,
    };

    try {
      installer.getBundleInstaller().then(data => {
        data.install(hapFilePaths, installParam, err => {
          this.installLoading = false;
          if (err) {
            console.error('install failed:' + err.message);
            promptAction.showToast({ message: '安装失败：' + err.message, duration: ToastDuration });
          } else {
            console.info('install successfully.');
            // 更改状态和操作文本
            this.appInfo.status = AppStatus.INSTALLED;
            this.appInfo.actionText = AppActionText.OPEN;
            promptAction.showToast({ message: '安装成功', duration: ToastDuration });
          }
        });
      }).catch(error => {
        console.error('getBundleInstaller failed. Cause: ' + error.message);
        this.installLoading = false;
        promptAction.showToast({ message: '安装失败：' + error.message, duration: ToastDuration });
      });
    } catch (error) {
      console.error('getBundleInstaller failed. Cause: ' + error.message);
      this.installLoading = false;
      promptAction.showToast({ message: '安装失败：' + error.message, duration: ToastDuration });
    }
  }

  // 打开应用
  openApp() {
    // 检查应用是否已经安装，并获取指定包名应用的启动Ability名
    let bundleName = this.appInfo.packageName;
    let bundleFlags = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_HAP_MODULE | bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_ABILITY;
    let userId = 100;
    try {
      bundleManager.getBundleInfo(bundleName, bundleFlags, userId, (err, data) => {
        if (err) {
          // 获取失败
          hilog.error(0x0000, 'testTag', 'getBundleInfo failed: %{public}s', err.message);
          promptAction.showToast({ message: '打开失败：应用不存在', duration: ToastDuration });
          this.appInfo.status = AppStatus.NOT_INSTALLED;
          this.appInfo.actionText = AppActionText.INSTALL;
        } else {
          // 获取成功
          hilog.info(0x0000, 'testTag', 'getBundleInfo successfully: %{public}s', JSON.stringify(data));
          // 打开应用
          globalThis.abilityContext.startAbility({
            bundleName: this.appInfo.packageName,
            abilityName: this.mainAbilityName,
            moduleName: '',
          }).then(() => {
            console.error('startApplication promise success');
            promptAction.showToast({ message: '打开成功', duration: ToastDuration });
          }, (err) => {
            console.error(`startApplication promise error: ${JSON.stringify(err)}`);
            promptAction.showToast({ message: '打开失败：应用不存在', duration: ToastDuration });
          });
        }
      });
    } catch (err) {
      hilog.error(0x0000, 'testTag', 'getBundleInfo failed: %{public}s', err.message);
      promptAction.showToast({ message: '打开失败：应用不存在', duration: ToastDuration });
      this.appInfo.status = AppStatus.NOT_INSTALLED;
      this.appInfo.actionText = AppActionText.INSTALL;
    }
  }
}
