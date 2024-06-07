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
      Text($r('app.string.settings'))
        .fontColor('#182431')
        .fontSize(26)
        .fontWeight(500)
        .margin({left: -25})
    }.alignItems(HorizontalAlign.Start)
    .width('100%')
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
                ListItem() { SettingRow({icon: $r('app.media.ic_download'), title: $r('app.string.download_management'), info: $r('app.string.to_be_implemented'), clickHandler: ()=> {
                  promptAction.showToast({ message: $r('app.string.download_management_pending'), duration: ToastDuration });
                }}) }
                ListItem() { SettingRow({icon: $r('app.media.ic_control'), title: $r('app.string.app_management'), info: $r('app.string.to_be_implemented'), clickHandler: ()=> {
                  promptAction.showToast({ message: $r('app.string.app_management_pending'), duration: ToastDuration });
                }}) }
                ListItem() { SettingRow({icon: $r('app.media.ic_internet'), title: $r('app.string.app_metadata_management'), info: $r('app.string.to_be_implemented'), clickHandler: ()=> {
                  promptAction.showToast({ message: $r('app.string.metadata_management_pending'), duration: ToastDuration });
                }}) }
              }.divider({ strokeWidth: 0.5, color: '#d6d6d6', startMargin: 54, endMargin: 14 })
            }.borderRadius(18).backgroundColor('#fff').margin({bottom: 10})

            // 第2组
            Column() {
              List() {
                ListItem() { SettingRow({icon: $r('app.media.ic_delete'), title: $r('app.string.clear_cache'), info: $r('app.string.clear_local_pkgs'), showRightArrow: false, clickHandler: ()=> {
                  this.clearCache()
                }}) }
              }.divider({ strokeWidth: 0.5, color: '#d6d6d6', startMargin: 54, endMargin: 14 })
            }.borderRadius(18).backgroundColor('#fff').margin({bottom: 10})

            // 第3组
            Column() {
              List() {
                ListItem() { SettingRow({icon: $r('app.media.ic_foh'), title: $r('app.string.about_foh'), info: $r('app.string.app_center'), clickHandler: ()=> {
                  router.pushUrl({ url: 'pages/AboutApp', params: {} });
                }}) }
                ListItem() { SettingRow({icon: $r('app.media.author_avatar'), title: $r('app.string.about_author'), info: 'westinyang', clickHandler: ()=> {
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
        title: $r('app.string.confirm_clear_cache'),
        message: $r('app.string.clear_cache_warning'),
        buttons: [
          { text: $r('app.string.cancel'), color: '#000000', },
          { text:$r('app.string.confirm'), color: '#3478f6', }
        ],
      }).then(data => {
        console.info('showDialog success, click button: ' + data.index);
        if (data.index == 1) {
          // 下载路径 /data/storage/el2/base/haps/entry/files
          let dirPath = globalThis.abilityContext.filesDir;
          fs.rmdir(dirPath, (err) => {
            if (err) {
              console.info("rmdir failed with error message: " + err.message + ", error code: " + err.code);
              promptAction.showToast({ message: getContext(this).resourceManager.getStringSync($r('app.string.clear_cache_failed'))
                + err.code, duration: ToastDuration });
            } else {
              console.info("rmdir succeed");
              promptAction.showToast({ message: $r('app.string.clear_cache_done'), duration: ToastDuration });
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