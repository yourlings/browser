import History from '../common/bean/History'
import HistoryItem from './HistoryItem'

@CustomDialog
export default struct PagesDialog {
  @Consume("histories") histories: Array<History>
  @Consume("pagesDialogShowed") @Watch("onClicked") isClicked: boolean

  dialogController: CustomDialogController

  onClicked() {
    this.dialogController.close()
  }

  @Builder ListHeader(date: string) {
    Text(date)
      .fontSize(20)
  }

  build() {
    Column() {
      Text("浏览历史")
        .fontSize(15)
        .margin({top: 10, bottom: 10})
      Divider()
        .color(Color.Black)
      .strokeWidth(1)
      List() {
        ForEach(this.histories, (history: History) => {
            ListItem() {
              HistoryItem({ title: history.title, url: history.url })
                .borderWidth({ bottom: 1 })
            }
        })
      }
    }
    .width("100%")
    .height("100%")
  }
}