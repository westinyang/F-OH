import { AppInfo, AppType } from '../model/Types';
import http from '@ohos.net.http';

const ds_address: string = "http://192.168.1.100:8080";
const ds_allAppList: string = ds_address + "/allAppList.json";

class DataSource {
  public static allAppList: AppInfo[] = [];

  constructor() {
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
        let jsonData = JSON.parse(data.result as string) as AppInfo[]
        DataSource.allAppList = jsonData;
        // 过滤类型
        let filterData = DataSource.allAppList.filter((item, index, array)=>{
          return item.type == appType;
        })
        success(filterData);
      } else {
        console.info('error:' + JSON.stringify(err));
        httpRequest.destroy();
      }
    });
  }
}

export {DataSource}