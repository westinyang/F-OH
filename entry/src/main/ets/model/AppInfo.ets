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

import { ds_server } from '../data/DataSource';

class AppInfo {
  constructor(source: Partial<AppInfo>) {
    Object.assign(this, source);
  }

  /* 元数据 */
  id: number
  name: string
  desc: string
  icon: string
  vender: string
  packageName: string
  version: string
  hapUrl: string
  type: string
  tags: string
  openSourceAddress: string
  releaseTime: string

  /* 扩展数据 */
  // 应用状态
  status: AppStatus = AppStatus.NOT_INSTALLED
  // 操作按钮文本
  actionText: AppActionText = AppActionText.INSTALL

  getIcon() {
    return this.icon ? ds_server + this.icon : this.icon;
  }

  getHapUrl() {
    return this.hapUrl ? ds_server + this.hapUrl : this.hapUrl;
  }
}

enum AppType {
  APP = 'app',
  GAME = 'game'
}

enum AppStatus {
  NOT_INSTALLED = 0,  // 未安装
  INSTALLED = 1       // 已安装
}

enum AppActionText {
  OPEN = "打开",
  INSTALL = "安装"
}

export {AppInfo, AppType, AppStatus, AppActionText}