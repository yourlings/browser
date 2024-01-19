import webview from '@ohos.web.webview';
import {ForwardButton} from "../common/bean/ForwardButton";
import {BackButton} from "../common/bean/BackButton"
import { SettingButton } from '../common/bean/SettingButton';
import { PagesButton } from '../common/bean/PagesButton';
import { PrivateButton } from '../common/bean/PrivateButton';

@Component
export struct FunctionButtons {
  //isBacked用于绑定当前页面是否可回退
  //isForwarded用于绑定当前页面是否可前进
  @Link isBacked: boolean
  @Link isForward: boolean

  @Consume webviewController: webview.WebviewController

  build() {
    Row() {
      BackButton()
        .opacity(this.isBacked? 1 : 0.5)
        .enabled(this.isBacked)
        .onClick(() => {
          if (this.webviewController.accessBackward()) {
            this.webviewController.backward()
          }
        })
      ForwardButton()
        .opacity(this.isForward? 1 : 0.5)
        .enabled(this.isForward)
        .onClick(() => {
          if (this.webviewController.accessForward()) {
            this.webviewController.forward()
          }
        })
      PagesButton()
      PrivateButton()
      SettingButton()
    }
    .width("100%")
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceAround)
  }
}