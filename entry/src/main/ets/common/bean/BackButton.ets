@Component
export struct BackButton {
  @State defaultImage: Resource = $r("app.media.left_arrow_icon")

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
    .backgroundColor("#00FFFFFF")
  }
}