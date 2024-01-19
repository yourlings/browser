import relationalStore from '@ohos.data.relationalStore'

class CommonConstants {
  APP_NAME = "小狐狸浏览器"

  VERSION = "v1.0"

  KEY_NAME = "AppStore.db"

  PREFERENCES_NAME = "browsingHistory"

  STORE_CONFIG = {
    name: "database.db",
    securityLevel: relationalStore.SecurityLevel.S1
  }

  HISTORY_TABLE = {
    tableName: "historyTable",
    sqlCreate: "CREATE TABLE IF NOT EXISTS historyTable(title VARCHAR(50), url VARCHAR(50), date VARCHAR(20), PRIMARY KEY(title, url, date)) DEFAULT CHARSET=utf8",
    columns: ["title", "url", "date"]
  }

  //搜索引擎
  SEARCH_OPTIONS = [
    {value: "Bing"},
    {value: "Google"},
    {value: "百度"}
  ]

  //搜索引擎的url前缀
  SEARCH_ENGINE = [
    {engine: "Bing", prefix: "https://cn.bing.com/search?q="},
    {engine: "Google", prefix: "http://www.google.com/search?q="},
    {engine: "百度", prefix: "http://www.baidu.com/s?wd="}
  ]


}

export default new CommonConstants()