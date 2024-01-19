export default class History {
  //网页标题
  title: string

  //网页的url
  url: string

  constructor(title: string, url: string) {
    this.title = title
    this.url = url
  }
}