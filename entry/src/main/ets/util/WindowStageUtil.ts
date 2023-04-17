import window from '@ohos.window';

/**
 * 应用窗口工具
 */
export default class WindowStageUtil {
    static STATUS_BAR_HEIGHT = 36;

    static COLOR_WHITE = '#ffffff';
    static COLOR_BLACK = '#000000';

    /**
     * 全屏，不显示导航栏、状态栏
     * @param windowStage
     */
    static setFullScreen(windowStage: window.WindowStage) {
        // 1.获取应用主窗口
        let windowClass = null;
        windowStage.getMainWindow((err, data) => {
            if (err.code) {
                console.error('Failed to obtain the main window. Cause: ' + JSON.stringify(err));
                return;
            }
            windowClass = data;
            console.info('Succeeded in obtaining the main window. Data: ' + JSON.stringify(data));

            // 2.实现沉浸式效果。方式一：设置导航栏、状态栏不显示。
            let names = [];
            windowClass.setWindowSystemBarEnable(names, (err) => {
                if (err.code) {
                    console.error('Failed to set the system bar to be visible. Cause:' + JSON.stringify(err));
                    return;
                }
                console.info('Succeeded in setting the system bar to be visible.');
            });
        })
    }

    /**
     * 全屏，更改导航栏、状态栏配色
     * @param windowStage
     * @param sBarColor
     * @param sBarContentColor
     */
    static setLayoutFullScreen(windowStage: window.WindowStage, statusBarColor: string, statusBarContentColor: string, navigationBarColor: string, navigationBarContentColor: string) {
        // 1.获取应用主窗口
        let windowClass = null;
        windowStage.getMainWindow((err, data) => {
            if (err.code) {
                console.error('Failed to obtain the main window. Cause: ' + JSON.stringify(err));
                return;
            }
            windowClass = data;
            console.info('Succeeded in obtaining the main window. Data: ' + JSON.stringify(data));

            // 2.实现沉浸式效果。方式二：设置窗口为全屏布局，配合设置导航栏、状态栏的透明度、背景/文字颜色及高亮图标等属性，与主窗口显示保持协调一致。
            let isLayoutFullScreen = false;
            windowClass.setWindowLayoutFullScreen(isLayoutFullScreen, (err) => {
              if (err.code) {
                console.error('Failed to set the window layout to full-screen mode. Cause:' + JSON.stringify(err));
                return;
              }
              console.info('Succeeded in setting the window layout to full-screen mode.');
            });
            let sysBarProps = {
              statusBarColor: statusBarColor,
              statusBarContentColor: statusBarContentColor,     // API8+
              navigationBarColor: navigationBarColor,
              navigationBarContentColor: navigationBarContentColor  // API8+
            };
            windowClass.setWindowSystemBarProperties(sysBarProps, (err) => {
              if (err.code) {
                console.error('Failed to set the system bar properties. Cause: ' + JSON.stringify(err));
                return;
              }
              console.info('Succeeded in setting the system bar properties.');
            });
        })
    }
}