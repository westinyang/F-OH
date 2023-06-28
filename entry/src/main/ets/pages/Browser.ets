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

import webview from '@ohos.web.webview';
import hilog from '@ohos.hilog';
import parameter from '@ohos.systemparameter'
import router from '@ohos.router'
import WindowStageUtil from '../util/WindowStageUtil';

// 自定义UA
const PAD_USER_AGENT: string = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTMl, like Gecko) Chrome/99.0.4844.88 Safari/537.36'
const PHONE_USER_AGENT: string = 'Mozilla/5.0 (Linux; Android 10.0; ohos) AppleWebKit/537.36 (KHTMl, like Gecko) Chrome/99.0.4844.88 HuaweiBrowser/13.0.4.302 Mobile Safari/537.36'

@Entry
@Component
struct Browser {
  @State title: string = router.getParams()['title']
  @State url: string = router.getParams()['url']

  @State isPhone: boolean = false
  controller: webview.WebviewController = new webview.WebviewController()

  onPageShow() {
    console.info('AboutComponent onPageShow');
    WindowStageUtil.setLayoutFullScreen(globalThis.windowStage, WindowStageUtil.COLOR_WHITE, WindowStageUtil.COLOR_BLACK, WindowStageUtil.COLOR_WHITE, WindowStageUtil.COLOR_BLACK);
  }

  @Builder NavigationTitle() {
    Column() {
      Text(this.title)
        .fontColor('#182431')
        .fontSize(26)
        .fontWeight(500)
    }.alignItems(HorizontalAlign.Start)
    .width('100%')
  }

  build() {
    Column() {
      // 页面标题
      Navigation()
        .title(this.NavigationTitle())
        .hideToolBar(true)
        .height(56)
        .width('100%')
        .titleMode(NavigationTitleMode.Mini)
        .hideBackButton(false)

      // 加载在线网页
      Web({ src: this.url, controller: this.controller })
        .width('100%')
        .height('100%')
        .padding({bottom: 56})
        .javaScriptAccess(true)
        .javaScriptProxy({
          object: this.extObj,
          name: "extObj",
          methodList: ["test"],
          controller: this.controller,
        })
        .fileAccess(true)
        .domStorageAccess(true)
        .userAgent(this.isPhone ? PHONE_USER_AGENT : PAD_USER_AGENT)
        .onPageBegin((event) => {
          hilog.info(0x0, '[Index]', `onPageBegin= ${JSON.stringify(event)}`)
        })
        .onPageEnd((event) => {
          hilog.info(0x0, '[Index]', `onPageEnd= ${JSON.stringify(event)}`)
        })
        .onProgressChange((event) => {
          hilog.info(0x0, '[Index]', `onProgressChange`)
        })
    }
  }

  aboutToAppear() {
    try {
      let deviceType = parameter.getSync("const.build.characteristics")
      // 修改为：default 也认为是 phone
      if (deviceType === 'phone' || deviceType === 'default') {
        this.isPhone = true
      }
    } catch (e) {
      hilog.info(0x0, '[Index]', `getSync unexpected error: ${e}`)
    }
  }

  // 扩展浏览器对象
  extObj = {
    test: (str) => {
      console.log("extObj.test: " + str)
      return "test " + str
    }
  }
}
