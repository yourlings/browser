import Prompt from '@system.prompt'

@Component
export struct PrivateButton {
  //defaultImage用于表示默认的图标
  @State defaultImage: Resource = $r("app.media.eye_slash_fill_icon")
  //clickedImage用于表示点击后的图标
  @State clickedImage: Resource = $r("app.media.eye_fill_icon")

  //从AppStore中获取持久化数据
  @StorageLink("privateMode") privateMode: string = "false"

  private message: string[] = ["无痕浏览已打开", "无痕浏览已关闭"]

  build() {
    Button({type: ButtonType.Circle}) {
      Image(this.privateMode === "false"? this.defaultImage : this.clickedImage)
        .width(30)
        .height(30)
    }
    .width(40)
    .height(40)
    .backgroundColor("#00FFFFFF")
    .onClick(() => {
      if (this.privateMode === "false") {
        this.privateMode = "true"
      } else {
        this.privateMode = "false"
      }
      Prompt.showToast({
        message: this.privateMode === "true"? this.message[0] : this.message[1]
      })
    })
  }
}