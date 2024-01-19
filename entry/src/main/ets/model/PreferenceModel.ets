import dataPreferences from "@ohos.data.preferences"
import History from '../common/bean/History'
import CommonConstants from '../common/constants/CommonConstants'

let context = getContext(this)
let preference: dataPreferences.Preferences = null

class PreferenceModel {
  //初始化Preferences首选项
  async getPreferencesFromStorage() {
    try {
      preference = await dataPreferences.getPreferences(context, CommonConstants.PREFERENCES_NAME)
    } catch (err) {
      console.error(err)
    }
  }

  //删除preferences实例对应的首选项
  async deletePreferences() {
    try {
      await dataPreferences.deletePreferences(context, CommonConstants.PREFERENCES_NAME)
    } catch (err) {
      console.error(err)
    }
    preference = null
  }

  //设置key-value
  async putPreference(histories: History[]) {
    if (preference === null) {
      await this.getPreferencesFromStorage()
    }
    try {
      await preference.put(CommonConstants.KEY_NAME, JSON.stringify(histories))
    } catch (err) {
      console.error(err)
    }
    await preference.flush()
  }

  //获取key对应的value
  async getPreference() {
    let value = ""
    if (preference === null) {
      await this.getPreferencesFromStorage()
    }
    try {
      value = <string> await preference.get(CommonConstants.KEY_NAME, null)
    } catch (err) {
      console.error(err)
    }

    if (value === null) {
      return
    }

    return JSON.parse(value)
  }

  //删除key对应的value
  async deletePreference() {
    try {
      await preference.delete(CommonConstants.KEY_NAME)
    } catch (err) {
      console.error(err)
    }
  }

  //检查参数是否为null
  isNull(value: any) {
    if (value === null) {
      return false
    }
    return true
  }

  //获取date日期对应的浏览历史
  async getHistories() {
    let histories: History[] = await this.getPreference()
    return histories
  }

  //写入date日期对应的浏览历史
  writeHistories(histories: History[]) {
    if (!this.isNull(histories)) {
      return
    }

    this.putPreference(histories)
  }
}

export default new PreferenceModel()