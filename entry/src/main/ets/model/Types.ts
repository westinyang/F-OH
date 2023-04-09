enum AppType {
    app = 'app',
    game = 'game'
}

type AppInfo = {
    id: number,
    name: string,
    desc: string,
    icon: string,
    vender: string,
    packageName: string,
    version: string,
    hapUrl: string,
    type: string,
    tags: string,
    openSourceAddress: string,
    releaseTime: string,
}

export {AppType, AppInfo}