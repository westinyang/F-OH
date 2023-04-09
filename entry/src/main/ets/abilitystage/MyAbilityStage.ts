import AbilityStage from '@ohos.app.ability.AbilityStage';

export default class MyAbilityStage extends AbilityStage {
    onCreate() {
        // 应用的HAP在首次加载的时，为该Module初始化操作
        console.log("MyAbilityStage onCreate");
    }
    onAcceptWant(want) {
        // 仅specified模式下触发
        return "MyAbilityStage";
    }
}
