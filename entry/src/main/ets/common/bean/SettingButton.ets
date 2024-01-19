import PreferenceModel from '../../model/PreferenceModel'
import CommonConstants from "../constants/CommonConstants"
import History from './History'

@Component
export struct SettingButton {
  @State defaultImage: Resource = $r("app.media.gear_setting_settings_wheel_icon")

  @Consume("histories") histories: History[]

  //从AppStore中获取持久化数据
  @StorageLink("currentEngineIndex") currentEngineIndex: number = 0
  @StorageLink("currentEngineName") currentEngineName: string = CommonConstants.SEARCH_OPTIONS[0].value
  @StorageLink("darkMode") darkMode: string = "false"

  private searchEngine: SelectOption[] = CommonConstants.SEARCH_OPTIONS

  @Builder MenuBuilder() {
    Menu() {
      MenuItemGroup() {
        MenuItem(this.EngineBuilder())
      }
      MenuItemGroup() {
        MenuItem(this.DarkModeBuilder())
      }
      MenuItemGroup() {
        MenuItem({ content: "清除浏览历史" })
          .onClick(() => {
            PreferenceModel.deletePreferences()
            this.histories = []
          })
      }
      MenuItemGroup() {
        MenuItem({ content: "关于我们", labelInfo: CommonConstants.APP_NAME + " " + CommonConstants.VERSION })
      }
    }
  }

  @Builder EngineBuilder() {
    Row() {
      Text("搜索引擎")
        .margin({left: 15})
        .fontSize(17)
      Select(this.searchEngine)
        .selected(this.currentEngineIndex)
        .value(this.currentEngineName)
        .onSelect((index: number, value: string) => {
          this.currentEngineIndex = index
          this.currentEngineName = value
        })
    }
    .width("90%")
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder DarkModeBuilder() {
    Row() {
      Text("夜间模式")
        .margin({left: 15})
        .fontSize(17)
      Toggle({type: ToggleType.Switch, isOn: this.darkMode === "false"? false : true})
        .onChange((isOn: boolean) => {
          this.darkMode = String(isOn)
        })
    }
    .width("90%")
    .justifyContent(FlexAlign.SpaceBetween)
  }

  build() {
    Button({type: ButtonType.Capsule}) {
      Column() {
        Image(this.defaultImage)
          .width(30)
          .height(30)
      }
    }
    .width(40)
    .height(40)
    .backgroundColor("#00FFFFFF")
    .bindMenu(this.MenuBuilder())
  }
}