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

import router from '@ohos.router';
import fs from '@ohos.file.fs';
import promptAction from '@ohos.promptAction';
import { SettingRow } from '../components/Settings';

const ToastDuration = 1000

@Component
export default struct Settings {
  aboutToAppear(): void {

  }

  @Builder NavigationTitle() {
    Column() {
      Text('设置')
        .fontColor('#182431')
        .fontSize(26)
        .fontWeight(500)
        .margin({left: -25})
    }.alignItems(HorizontalAlign.Start)
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        // 页面标题
        Navigation()
          .title(this.NavigationTitle())
          .hideToolBar(true)
          .height(56)
          .width('100%')
          .titleMode(NavigationTitleMode.Mini)
          .hideBackButton(true)
//          .border({width: {bottom: 0.5}, color: '#c9c9c9'})
          .padding({left: 15, right: 15})

        Scroll() {
          Column() {
            // 第1组
            Column() {
              List() {
                ListItem() { SettingRow({icon: $r('app.media.ic_download'), title: '下载管理', info: '待实现', clickHandler: ()=> {
                  promptAction.showToast({ message: '待实现，下载管理', duration: ToastDuration });
                }}) }
                ListItem() { SettingRow({icon: $r('app.media.ic_control'), title: '应用管理', info: '待实现', clickHandler: ()=> {
                  promptAction.showToast({ message: '待实现，应用管理', duration: ToastDuration });
                }}) }
                ListItem() { SettingRow({icon: $r('app.media.ic_internet'), title: '应用元数据源管理', info: '待实现', clickHandler: ()=> {
                  promptAction.showToast({ message: '待实现，应用元数据源管理', duration: ToastDuration });
                }}) }
              }.divider({ strokeWidth: 0.5, color: '#d6d6d6', startMargin: 54, endMargin: 14 })
            }.borderRadius(18).backgroundColor('#fff').margin({bottom: 10})

            // 第2组
            Column() {
              List() {
                ListItem() { SettingRow({icon: $r('app.media.ic_delete'), title: '清空缓存', info: '清理全部已下载到本地的应用安装包', clickHandler: ()=> {
                  this.clearCache()
                }}) }
              }.divider({ strokeWidth: 0.5, color: '#d6d6d6', startMargin: 54, endMargin: 14 })
            }.borderRadius(18).backgroundColor('#fff').margin({bottom: 10})

            // 第3组
            Column() {
              List() {
                ListItem() { SettingRow({icon: $r('app.media.ic_foh'), title: '关于F-OH', info: 'OpenHarmony自由开源软件的应用中心', clickHandler: ()=> {
                  router.pushUrl({ url: 'pages/AboutApp', params: {} });
                }}) }
                ListItem() { SettingRow({icon: $r('app.media.author_avatar'), title: '关于作者', info: 'westinyang', clickHandler: ()=> {
                  router.pushUrl({ url: 'pages/AboutAuthor', params: {} });
                }}) }
              }.divider({ strokeWidth: 0.5, color: '#d6d6d6', startMargin: 54, endMargin: 14 })
            }.borderRadius(18).backgroundColor('#fff').margin({bottom: 10})

          }.width('100%').padding({left: 15, right: 15})
        }
        .edgeEffect(EdgeEffect.None)
        .width('100%')
        .height('auto')
        .margin({bottom: 56})
      }
      .width('100%')
      .height('100%')
    }.width('100%').height('100%').backgroundColor('#f3f4f6')
  }

  clearCache() {
    try {
      promptAction.showDialog({
        title: '确认要清空缓存吗？',
        message: '此操作将会清理全部已下载到本地的应用安装包',
        buttons: [
          { text: '取消', color: '#000000', },
          { text: '确认', color: '#3478f6', }
        ],
      }).then(data => {
        console.info('showDialog success, click button: ' + data.index);
        if (data.index == 1) {
          // 下载路径 /data/storage/el2/base/haps/entry/files
          let dirPath = globalThis.abilityContext.filesDir;
          fs.rmdir(dirPath, (err) => {
            if (err) {
              console.info("rmdir failed with error message: " + err.message + ", error code: " + err.code);
              promptAction.showToast({ message: '清空缓存失败：' + err.code, duration: ToastDuration });
            } else {
              console.info("rmdir succeed");
              promptAction.showToast({ message: '清空缓存完毕', duration: ToastDuration });
            }
          });
        }
      }).catch(err => {
        console.info('showDialog error: ' + err);
      })
    } catch (error) {
      console.error(`showDialog args error code is ${error.code}, message is ${error.message}`);
    }
  }
}