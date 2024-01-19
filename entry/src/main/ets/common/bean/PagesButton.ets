import pagesDialog from "../../view/PagesDialog"

@Component
export struct PagesButton {
  //defaultImage用于表示默认的图标
  @State defaultImage: Resource = $r("app.media.clone_regular")
  //clickedImage用于表示点击后的图标
  @State clickedImage: Resource = $r("app.media.clone_solid")
  //点击后的放大比例,默认为原比例
  @State scaleOptions: ScaleOptions = {x: 1, y: 1}

  //绑定当前自定义弹窗是否显示,默认为隐藏
  @Provide("pagesDialogShowed") isClicked: boolean = false

  dialogController: CustomDialogController = new CustomDialogController({
    builder: pagesDialog(),
    cancel: () => {
      this.OnChange()
    }
  })

  //当自定义弹窗隐藏后执行
  private OnChange() {
    this.scaleOptions = { x: 1, y: 1}
    this.isClicked = false
  }

  build() {
    Button({type: ButtonType.Circle, stateEffect: false}) {
      Column() {
        Image(this.isClicked? this.clickedImage : this.defaultImage)
          .width(30)
          .height(30)
      }
    }
    .width(40)
    .height(40)
    .scale(this.scaleOptions)
    .backgroundColor("#00FFFFFF")
    .onClick(() => {
      this.isClicked = ! this.isClicked
      if (this.isClicked) {
        this.scaleOptions = { x: 1.2, y: 1.2 }
        if (this.dialogController) {
          this.dialogController.close()
        }
        this.dialogController.open()
      } else {
        this.scaleOptions = { x: 1, y: 1 }
      }
    })
    .animation({
      duration: 50
    })
  }
}