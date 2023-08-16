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

@CustomDialog
struct SponsorDialog {
  controller: CustomDialogController
  cancel: () => void
  confirm: () => void

  build() {
    Column() {
      Text("赞助作者").fontSize(24)
      Text("我是一名独立开发者，F-OH和一些开源项目都是我的兴趣投入，服务器目前是自购自建，配置较低不太稳定，您的赞助支持将是F-OH运作的驱动力！").margin({top: 15})
      Image($r('app.media.sponsor_qrcode')).width('100%').margin({top: 15})
    }.padding(15)
  }
}

export {SponsorDialog}