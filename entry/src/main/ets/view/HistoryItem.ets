import webview from '@ohos.web.webview'
@Component
export default struct HistoryItem {
  @State title: string = ""
  @State url: string = ""

  @Consume("pagesDialogShowed") isClicked: boolean
  @Consume("webIsSearched") isSearched: boolean
  @Consume webviewController: webview.WebviewController

  build() {
    Row() {
      Button({ type: ButtonType.Normal }) {
        Column() {
          Text(this.title === ""? this.url : this.title)
            .width("100%")
            .margin({ top: 5 })
            .fontSize(15)
            .fontWeight(FontWeight.Medium)
            .textAlign(TextAlign.Start)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .maxLines(1)
          Text(this.url)
            .width("100%")
            .margin({ top: 5 })
            .fontSize(10)
            .textAlign(TextAlign.Start)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .maxLines(1)
        }
        .padding({ left: 15, right: 15 })
        .margin({ bottom: 5 })
      }
      .backgroundColor(Color.White)
      .onClick(() => {
        this.isClicked = ! this.isClicked
        this.isSearched = true
        this.webviewController.loadUrl(this.url)
      })
    }
    .justifyContent(FlexAlign.SpaceBetween)
  }
}