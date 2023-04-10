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

import { HomePageData } from '../model/HomePageData';
import {AppInfo, AppType} from '../model/AppInfo';
import http from '@ohos.net.http';

// test
const ds_address: string = "http://192.168.1.100:8080";
// prod
//const ds_address: string = "https://gitee.com/ohos-dev/foh-data/raw/master";

const ds_homePageData: string = ds_address + "/homePageData.json";
const ds_allAppList: string = ds_address + "/allAppList.json";

class DataSource {
  public static allAppList: AppInfo[] = [];

  constructor() {
  }

  /**
   * 获取首页数据
   */
  static getHomePageData(success: Function, error: Function) {
    let httpRequest = http.createHttp();
    httpRequest.request(ds_homePageData, {
      method: http.RequestMethod.GET
    }, (err, data) => {
      if (!err && data.responseCode == 200) {
        let dataJson = JSON.parse(data.result as string) as Object
        let dataObj = new HomePageData(dataJson)
        success(dataObj);
      } else {
        console.info('error:' + JSON.stringify(err));
        httpRequest.destroy();
        error(err);
      }
    });
  }

  /**
   * 获取应用列表数据
   */
  static getAppList(appType: AppType, success: Function) {
    let httpRequest = http.createHttp();
    httpRequest.request(ds_allAppList, {
      method: http.RequestMethod.GET
    }, (err, data) => {
      if (!err && data.responseCode == 200) {
        // JSON字符串 转 数组（这里直接 as AppInfo[] 会导致元数据之外的属性不存在）
        let dataArr = JSON.parse(data.result as string) as []
        // 数组 转 数组对象
        let tmpList: AppInfo[] = [];
        dataArr.map((item)=>{
          tmpList.push(new AppInfo(item))
        })
        DataSource.allAppList = tmpList;
        // 过滤类型
        let filterData: AppInfo[] = DataSource.allAppList.filter((item, index, array)=>{
          return item.type == appType;
        })
        success(filterData, dataArr.length);
      } else {
        console.info('error:' + JSON.stringify(err));
        httpRequest.destroy();
      }
    });
  }
}

export {DataSource}