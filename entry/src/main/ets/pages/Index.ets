import webview from '@ohos.web.webview'
import CommonConstants from "../common/constants/CommonConstants"
import { FunctionButtons } from '../view/FunctionButtons'
import History from '../common/bean/History'
import window from '@ohos.window'
import PreferenceModel from '../model/PreferenceModel'

PersistentStorage.PersistProp("privateMode", "false")
PersistentStorage.PersistProp("currentEngineIndex", 0)
PersistentStorage.PersistProp("currentEngineName", "Bing")
PersistentStorage.PersistProp("darkMode", "false")

@Entry
@Component
struct Index {
  //当前搜索框内显示的url地址
  @State url: string = ""
  //Web组件的显示状态,默认为隐藏
  @State isShowed: Visibility = Visibility.None
  //
  @State high: string = "10%"
  //搜索框内的文本对齐方式,默认为左对齐
  @State textAlign: TextAlign = TextAlign.Start
  //绑定键盘高度
  @State keyboardHeight: number = 0
  //绑定当前页面加载进度
  @State currentProgress: number = 0
  //isBacked用于绑定当前页面是否可回退
  @State isBacked: boolean = false
  //isForwarded用于绑定当前页面是否可前进
  @State isForwarded: boolean = false

  @Provide("histories") histories: Array<History> = []

  @Provide webviewController: webview.WebviewController = new webview.WebviewController()
  @Provide("webIsSearched") @Watch("onSearched") isSearched: boolean = false

  //从AppStore中获取持久化数据
  //privateMode表示当前是否为隐私模式
  @StorageLink("privateMode") privateMode: string = "false"
  //darkMode表示当前是否为夜间模式
  @StorageLink("darkMode") darkMode: string = "false"
  //currentEngineIndex表示当前的搜索引擎的索引
  @StorageLink("currentEngineIndex") searchEngine: number = 0

  // private browsingHistory: BrowsingHistory = new BrowsingHistory(() => {})
  private windowClass: window.Window = null

  async aboutToAppear() {
    await PreferenceModel.getPreferencesFromStorage();
    PreferenceModel.getHistories().then(histories => {
      if (histories !== null) {
        this.histories = histories
      }
    })

    //开启软键盘高度变化的监听
    window.getLastWindow(getContext(this), (err, data) => {
      if (err) {
        console.log(err.message)
      }
      this.windowClass = data
      this.windowClass.on("keyboardHeightChange", (data) => {
        this.keyboardHeight =  data
      })
    })
  }

  //保存浏览记录
  onSaveHistory() {
    let history = new History(this.webviewController.getTitle(), this.webviewController.getUrl())

    this.histories.push(history)

    PreferenceModel.writeHistories(this.histories)
  }

  //判断用户输入的内容是否为网址
  private checkContent(content: string) {
    if (content.endsWith(".com") || content.endsWith(".cn") || content.endsWith(".tv")) {
      return true
    } else {
      return false
    }
  }

  onSearched() {
    this.isShowed = Visibility.Visible
    this.high = "91%"
    this.textAlign = TextAlign.Center
  }

  build() {
    Flex({ direction: FlexDirection.Column , alignItems: ItemAlign.Center}) {
      Column() {
        Column() {
          if (!this.isSearched) {
            Row() {
              Image($r("app.media.app_icon"))
                .width(30)
                .height(30)
                .margin({ bottom: 25, right: 10 })
              Text(CommonConstants.APP_NAME)
                .fontSize(25)
                .fontColor(this.darkMode === "false"? Color.Black : Color.White)
                .margin({ bottom: 25 })
                .animation({
                  duration: 300
                })
            }
            .width("100%")
            .height("100%")
            .justifyContent(FlexAlign.Center)
          }
          Web({ src: this.url, controller: this.webviewController })
            .width("100%")
            .height("100%")
            .visibility(this.isShowed)
            .animation({
              duration: 300
            })
            .onProgressChange((event) => {
                this.currentProgress = event.newProgress
            })
            .onRefreshAccessedHistory((event) => {
              if (!event.isRefreshed && !this.privateMode) {
                this.onSaveHistory()
              }
              this.isBacked = this.webviewController.accessBackward()
              this.isForwarded = this.webviewController.accessForward()
            })
        }
        .width("100%")
        .height(this.high)
        .justifyContent(FlexAlign.Center)
        .animation({
          duration: 300
        })

        Stack({ alignContent: Alignment.Bottom }) {
          Search({ placeholder: "搜索或输入网址", value: this.url })
            .width("90%")
            .height("8%")
            .size({ height: 50 })
            .margin({ top: 5, bottom: 10 })
            .offset(this.isSearched ? { y: -this.keyboardHeight / 3.8 } : {})
            .textAlign(this.textAlign)
            .backgroundColor(this.darkMode === "false"? "#E8E8E8" : "#696969")
            .animation({
              duration: 300
            })
            .onSubmit((value) => {
              if (this.checkContent(value)) {
                this.webviewController.loadUrl(value)
              } else {
                this.webviewController.loadUrl(CommonConstants.SEARCH_ENGINE[this.searchEngine].prefix + value)
              }

              this.url = this.webviewController.getOriginalUrl()

              //更改搜索框的搜索状态
              if (!this.isSearched) {
                this.isSearched = true
              }

              this.onSaveHistory()
            })
          Progress({ value: this.currentProgress, type: ProgressType.Linear })
            .visibility(this.currentProgress === 100 || this.currentProgress === 0 ? Visibility.None : Visibility.Visible)
            .animation({
              duration: 100
            })
        }
      }
      .width("100%")
      .layoutWeight(11)
      .justifyContent(FlexAlign.Center)
      FunctionButtons({ isBacked: $isBacked, isForward: $isForwarded })
        .width("100%")
        .margin({ top: 5 })
        .layoutWeight(1)
    }
    .backgroundColor(this.darkMode === "false"? Color.White : "#1C1C1C")
    .animation({
      duration: 300
    })
  }
}