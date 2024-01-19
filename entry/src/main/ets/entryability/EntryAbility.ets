import UIAbility from '@ohos.app.ability.UIAbility';
import window from '@ohos.window';

export default class EntryAbility extends UIAbility {
  onWindowStageCreate(windowStage: window.WindowStage) {
    windowStage.loadContent("pages/Index", (err) => {
      if (err.code) {
        console.error(`Failed to load the content. Code:${err.code},message:${err.message}`);
        return
      }
    })
  }
}