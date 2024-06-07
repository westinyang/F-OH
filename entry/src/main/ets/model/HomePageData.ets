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

class HomePageData {
  // static defaultAnnouncement = 'F-OH 是一个 OpenHarmony 平台上 FOSS（Free and Open Source Software，自由开源软件）的应用中心';
  //static defaultAnnouncement = 'F-OH已停服 (2023-04-11 ~ 2023-12-29)，具体可到开源项目主页查看停服公告以及部署教程：https://gitee.com/westinyang/f-oh';
  static defaultAnnouncement=$r('app.string.default_announcement')
  constructor(source: Partial<Object>) {
    Object.assign(this, source);
  }

  // 显示公告
  showAnnouncement: boolean = true;
  // 公告内容
  announcement: string = "";
}

export {HomePageData}