@Component
export struct ForwardButton {
  @State defaultImage: Resource = $r("app.media.right_arrow_icon")

  build() {
    Button({type: ButtonType.Circle}) {
      Column() {
        Image(this.defaultImage)
          .width(30)
          .height(30)
      }
    }
    .width(40)
    .height(40)
    .height(40)
    .backgroundColor("#00FFFFFF")
  }
}